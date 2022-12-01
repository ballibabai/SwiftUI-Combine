//
//  FoxViewModel.swift
//  NewWorld
//
//  Created by İbrahim Ballıbaba on 30.11.2022.
//

import Foundation
import Combine

class FoxViewModel: ObservableObject {
    
    private var cancellable =  Set<AnyCancellable>()
    @Published var fox: FoxModel?
    
    init(){
        getDataWithCombine()
    }
    func getDataWithCombine(){
        FoxRequest.shared.newFetchData(path: .floof).sink(receiveCompletion: { completion in
            switch completion{
            case .failure(let error):
                print("error \(error.localizedDescription)")
            case .finished:
                print("It,s Done!")
            }
        }, receiveValue: { [weak self] data in
            self?.fox = data
            
        }).store(in: &cancellable)
    }
    func refreshButton(){
        getDataWithCombine()
    }
}
