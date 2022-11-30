//
//  FoxView.swift
//  NewWorld
//
//  Created by İbrahim Ballıbaba on 30.11.2022.
//

import SwiftUI
import Kingfisher

struct FoxView: View {
    
    //MARK: - Body
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color.orange.opacity(0.8), Color.white.opacity(0.9), Color.black.opacity(0.4)], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack {
                Spacer()
                TopBarArea().padding(.all)
                Spacer()
            }
        }
    }
}

//MARK: - Preview
struct FoxView_Previews: PreviewProvider {
    static var previews: some View {
        FoxView()
    }
}

struct TopBarArea: View {
    private let title: String = "F O X"
    @ObservedObject private var foxViewModel: FoxViewModel = FoxViewModel()
    var body: some View {
        VStack {
            Text(title).font(.largeTitle)
                .foregroundColor(.white)
            if foxViewModel.fox != nil{
                KFImage(URL(string: foxViewModel.fox?.image ?? "")).resizable()
                    .frame(width: 250, height: 250)
                    .cornerRadius(16)
            }
            Button("Refresh"){
                foxViewModel.refreshButton()
            }.font(.callout.bold())
            .foregroundColor(.white)
            .padding()
        }
    }
}
