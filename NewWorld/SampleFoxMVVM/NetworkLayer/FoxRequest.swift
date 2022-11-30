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
    private var cancellable: AnyCancellable?
    
    private let baseUrl: String = "https://randomfox.ca/"
    
    //MARK: - Alamofire
    func fetchData(path: FoxPath, completion:@escaping (FoxModel) -> ()){
        AF.request(baseUrl + path.rawValue).responseDecodable(of: FoxModel.self,
                                                              completionHandler: { response in
            guard let response = response.value else {return}
            completion(response)
        })
    }
    
    //MARK: - Combine
    func retrieveData(path: FoxPath, completion:@escaping (FoxModel) -> ()){
        guard let url = URL(string: baseUrl + path.rawValue) else {return}
        let publisher = URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: FoxModel.self, decoder: JSONDecoder())
            cancellable = publisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                default:()
                }
            }, receiveValue: { data in
                completion(data)
            })
    }
    
}
