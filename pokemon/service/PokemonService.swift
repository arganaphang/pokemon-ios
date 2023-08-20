//
//  GetPokemonList.swift
//  pokemon
//
//  Created by Argana Phangquestian on 20/08/23.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

// MARK: - PokemonList
struct PokemonList: Codable {
    let count: Int
    let next, previous: String?
    let results: [PokemonItem]
}

// MARK: - Result
struct PokemonItem: Codable {
    let name: String
    let url: String
}


// MARK: - PokemonService
struct PokemonService {
    let BASE_URL = "https://pokeapi.co/api/v2"
    
    // MARK: - Get Pokemons
    func getPokemons(page: Int = 0, size: Int = 100) async throws -> [Pokemon] {
        try await self.getList(page: page, size: size).concurrentMap { item in
            try await self.getDetail(url: item.url)
        }
    }
    
    // MARK: - Get Pokemon List
    func getList(page: Int, size: Int) async throws -> [PokemonItem] {
        let parameters = [
            "limit": size,
            "offset": size*page,
        ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                "\(BASE_URL)/pokemon",
                method: .get,
                parameters: parameters,
                headers: headers
            )
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let jsonData = try JSONDecoder().decode(PokemonList.self, from: data)
                        continuation.resume(returning: jsonData.results)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
                
            }
        }
        
    }
    
    // MARK: - Get Pokemon Detail
    func getDetail(url: String) async throws -> Pokemon {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: .get,
                headers: headers
            )
            .responseData { response in
                switch(response.result) {
                case let .success(data):
                    do {
                        let json = try JSON(data: data)
                        continuation.resume(returning: Pokemon(
                            id: json["id"].intValue,
                            name: json["name"].stringValue,
                            height: json["height"].intValue,
                            weight: json["weight"].intValue,
                            stats: json["stats"].arrayValue.map {
                                Stat(
                                    key: $0["stat","name"].stringValue,
                                    value: $0["base_stat"].intValue
                                )
                            },
                            types: json["types"].arrayValue.map {$0["type", "name"].stringValue}
                        ))
                    } catch {
                        print(error.localizedDescription)
                    }
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
