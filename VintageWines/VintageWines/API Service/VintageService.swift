//
//  VintageService.swift
//  VintageWines
//
//  Created by ashokdy on 16/09/2021.
//

import Foundation
import Networking
import Combine

protocol VintageWinesServiceType {
    func fetchWineList() -> AnyPublisher<VintageWine, Error>
}

struct VintageService: APIService, VintageWinesServiceType {
    
    var needsHeaders: Bool { false }
    func fetchWineList() -> AnyPublisher<VintageWine, Error> {
        requestAPI(VintageAPI())
    }
}

struct VintageAPI: APIPath {
    var subURL: String {
        "/vintages/_explore?limit=50&q=the%20prisoner%201991"
    }
}

struct VintageMockService: APIService, VintageWinesServiceType {
    var mockURL: URL
    var needsHeaders: Bool { false }
    func fetchWineList() -> AnyPublisher<VintageWine, Error> {
        let jsonData = try! Data(contentsOf: mockURL)
        let jsonObject = try! JSONDecoder().decode(VintageWine.self, from: jsonData)
        return Just<VintageWine>(jsonObject)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
