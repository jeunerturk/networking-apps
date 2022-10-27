//
//  CryptoCurrencyVM.swift
//  CryptoApp
//
//  Created by Umut Can Ertürk on 21.10.2022.
//

import Foundation

class CryptoListViewModel: ObservableObject {
    
    @Published var cryptoList = [CryptoCurrencyVM]()
    
    let networkManager = NetworkManager()
    
    func downloadCryptosAsync(url: URL) async {
        do {
       let cryptos = try await networkManager.downloadCurrenciesAsync(url: url)
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoCurrencyVM.init)
            }
        } catch {
            print(error)
        }
    }
    
    func downloadCryptos(url: URL) {
        networkManager.downloadCurrencies(url: url) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let cryptoCurrencies):
                guard let cryptos = cryptoCurrencies else {
                    return
                }
                DispatchQueue.main.async {
                    self.cryptoList = cryptos.map(CryptoCurrencyVM.init)
                }
            }
        }
    }
}

struct CryptoCurrencyVM {
    
    let crypto: CryptoCurrency
    
    var id: UUID? {
        crypto.id
    }
    
    var currency: String {
        crypto.currency
    }
    
    var price: String {
        crypto.price
    }
}
