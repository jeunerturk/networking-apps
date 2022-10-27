//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Umut Can Ertürk on 21.10.2022.
//

import Foundation

class NetworkManager {
    
    func downloadCurrenciesAsync(url: URL) async throws -> [CryptoCurrency] {
      
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
        
        return currencies ?? []
    }
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[CryptoCurrency]?, NetworkingError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.badURL))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else {
                return completion(.failure(.dataParseError))
            }
            completion(.success(currencies))
        }.resume()
    }


}

enum NetworkingError: Error {
    case badURL, noData, dataParseError
}
