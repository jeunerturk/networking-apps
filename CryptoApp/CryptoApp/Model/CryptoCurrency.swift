//
//  CryptoCurrency.swift
//  CryptoApp
//
//  Created by Umut Can Ertürk on 21.10.2022.
//

import Foundation

struct CryptoCurrency: Hashable, Codable, Identifiable {
    let id = UUID()
    let currency: String
    let price: String
    
    private enum CodingKeys: String, CodingKey {
        case currency = "currency"
        case price = "price"
        
    }
}
