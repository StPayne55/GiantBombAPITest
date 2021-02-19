//
//  APIManager.swift
//  CodeTest
//
//  Created by Stephen Payne on 2/18/21.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    static let characterURL = "https://www.giantbomb.com/api/characters/?format=json&limit=100&api_key=a3c8f1c7ea1ad249deb201014d6b0b852e1399b2"
    
    /// Grabs an array of Characters from the GiantBomb character API
    ///
    /// - Parameter completion: Escapes, and returns a Result with either an array of Character objects, or an Error
    func getCharacters(completion: @escaping ((Result<[Character], Error>) -> Void)) {
        guard let url = URL(string: APIManager.characterURL) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let e = error {
                    completion(.failure(e))
                    return
                }

                guard let d = data else {
                    completion(.failure(URLError(.unknown)))
                    return
                }

                do {
                    let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: d)
                    completion(.success(characterResponse.characters))
                } catch let err {
                    print(err)
                    completion(.failure(err))
                }
            }
        }.resume()
    }
}
