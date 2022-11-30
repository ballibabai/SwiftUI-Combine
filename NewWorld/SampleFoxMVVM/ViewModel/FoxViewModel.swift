//
//  FoxViewModel.swift
//  NewWorld
//
//  Created by İbrahim Ballıbaba on 30.11.2022.
//

import Foundation

class FoxViewModel: ObservableObject {
    
    @Published var fox: FoxModel?
    
    init(){
        getData()
    }
    func getData(){
        FoxRequest.shared.retrieveData(path: .floof) { response in
            DispatchQueue.main.async {
                self.fox = response
            }
        }
    }
    func refreshButton(){
        getData()
    }
}
