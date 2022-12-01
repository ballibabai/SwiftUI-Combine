//
//  FoxRequest.swift
//  NewWorld
//
//  Created by İbrahim Ballıbaba on 30.11.2022.
//

import Foundation
import Alamofire
import Combine



class FoxRequest {
    static let shared = FoxRequest()
    private let baseUrl: String = "https://randomfox.ca/"
    var cancellable =  Set<AnyCancellable>()
    
    //MARK: - Alamofire
    func fetchData(path: FoxPath, completion:@escaping (FoxModel) -> ()){
        AF.request(baseUrl + path.rawValue).responseDecodable(of: FoxModel.self,
                                                              completionHandler: { response in
            guard let response = response.value else {return}
            completion(response)
        })
    }
    
    //MARK: - Combine
    func newFetchData(path: FoxPath) -> Future<FoxModel, ErrorTypes>{
        return Future<FoxModel, ErrorTypes> { [weak self] promise in
            guard let self = self, let url = URL(string: self.baseUrl.appending(path.rawValue)) else {return promise(.failure(.invalidURL))}
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, _ -> Data in
                    return data
                }
                .decode(type: FoxModel.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion{
                    case .failure(let error):
                        print("error \(error.localizedDescription)")
                    default:()
                    }
                }, receiveValue: { data in
                    promise(.success(data))
                }).store(in: &self.cancellable)
        }
        
    }
    
}
