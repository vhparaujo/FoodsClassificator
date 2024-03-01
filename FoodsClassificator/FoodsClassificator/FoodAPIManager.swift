//
//  FoodAPIManager.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 29/02/24.
//

import Foundation
import Alamofire

class FoodAPIManager: ObservableObject {
    
    static func searchIngredients(query: String, number: Int, completion: @escaping (Result<IngredientSearchResponse, Error>) -> Void) {
        let apiKey = "0d0055e51be649b2a20ccfb6b9df91c8"
        let url = "https://api.spoonacular.com/food/ingredients/search"
        let parameters: [String: Any] = [
            "query": query,
            "number": number,
            "apiKey": apiKey
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(IngredientSearchResponse.self, from: data)
                    completion(.success(searchResponse))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func getIngredientInformation(id: Int, amount: Double, unit: String, completion: @escaping (Result<IngredientInformation, Error>) -> Void) {
        let apiKey = "0d0055e51be649b2a20ccfb6b9df91c8"
        let url = "https://api.spoonacular.com/food/ingredients/\(id)/information"
        let parameters: Parameters = [
            "amount": amount,
            "unit": unit,
            "apiKey": apiKey
        ]
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let ingredientInfo = try decoder.decode(IngredientInformation.self, from: data)
                    completion(.success(ingredientInfo))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
