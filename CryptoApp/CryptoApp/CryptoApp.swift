//
//  ContentView.swift
//  CryptoApp
//
//  Created by Umut Can Ertürk on 21.10.2022.
//

import SwiftUI

struct CryptoApp: View {
    
    @ObservedObject var cryptoListVM = CryptoListViewModel()
    
    var body: some View {
        NavigationView {
            
            List(cryptoListVM.cryptoList, id: \.id) { crypto in
                VStack {
                    Text(crypto.currency)
                        .font(.title3)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(crypto.price)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }.navigationTitle("CryptoMarketCap")
        }.task {
            await cryptoListVM.downloadCryptosAsync(url: URL(string: "https://raw.githubusercontent.com/jeunerturk/networking-apps/main/crypto.json")!)
        }
        
        /* .onAppear {
            cryptoListVM.downloadCryptos(url: URL(string: "https..........")!)
        }
         */
    }
}

struct CryptoApp_Previews: PreviewProvider {
    static var previews: some View {
        CryptoApp()
    }
}
