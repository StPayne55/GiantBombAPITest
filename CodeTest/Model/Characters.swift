//
//  Characters.swift
//  CodeTest
//
//  Created by Brines, Steve on 2/4/21.
//

import Foundation

// MARK: - CharacterResponse
struct CharacterResponse: Codable {
    let error: String
    let statusCode: Int
    let characters: [Character]

    enum CodingKeys: String, CodingKey {
        case error
        case statusCode = "status_code"
        case characters = "results"
    }
}

// MARK: - Result
struct Character: Codable {
    let aliases: String?
    let deck: String?
    let image: CharacterImage
    let name: String

    enum CodingKeys: String, CodingKey {
        case aliases = "aliases"
        case deck = "deck"
        case image = "image"
        case name = "name"
    }
}

// MARK: - Image
struct CharacterImage: Codable {
    let iconURL, screenLargeURL: String
    let originalURL: String

    enum CodingKeys: String, CodingKey {
        case iconURL = "icon_url"
        case screenLargeURL = "screen_large_url"
        case originalURL = "original_url"
    }
}
