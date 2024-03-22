//
//  BarcodeAPIManager.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 21/03/24.
//

import Foundation
import Alamofire

class BarcodeAPIManager {
    static func searchBarcode(query: String, completion: @escaping (Result<ProductResponse, Error>) -> Void) {
        let headers: HTTPHeaders = [
            "X-RapidAPI-Key": "\(ProcessInfo.processInfo.environment["BarcodeAPIKey"] ?? "")",
            "X-RapidAPI-Host": "\(ProcessInfo.processInfo.environment["BarcodeAPIHost"] ?? "")"
        ]

        let parameters: [String: Any] = [
            "query": query
        ]

        let url = "https://barcodes1.p.rapidapi.com/"

        AF.request(url, method: .get, parameters: parameters, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
//                print(String(data: data, encoding: .utf8) ?? "Nenhum dado")
                do {
                    let decoder = JSONDecoder()
                    let productResponse = try decoder.decode(ProductResponse.self, from: data)
                    completion(.success(productResponse))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
