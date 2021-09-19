//
//  VintageWine.swift
//  VintageWines
//
//  Created by ashokdy on 18/09/2021.
//

import Foundation

// MARK: - VintageWine
struct VintageWine: Codable {
    let recordsMatched: Int
    var matches: [Match]
    
    enum CodingKeys: String, CodingKey {
        case recordsMatched = "records_matched"
        case matches
    }
    
    init() {
        self.recordsMatched = 0
        self.matches = []
    }
}

// MARK: - Match
struct Match: Codable {
    let vintage: Vintage
}

// MARK: - Vintage
struct Vintage: Codable {
    let id: Int
    let name: String
    let year: String
    let image: Image
    let wine: Wine
}

// MARK: - Image
struct Image: Codable {
    let variations: ImageVariations
}

// MARK: - ImageVariations
struct ImageVariations: Codable {
    let  medium: String
}

// MARK: - Wine
struct Wine: Codable {
    let id: Int
    let name: String
    let region: Region?
    let winery: Winery
}

// MARK: - Region
struct Region: Codable {
    let id: Int
    let name, country: String
}

// MARK: - Winery
struct Winery: Codable {
    let id: Int
    let name: String
}
