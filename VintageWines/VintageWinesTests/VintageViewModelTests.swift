//
//  VintageViewModelTests.swift
//  VintageWinesTests
//
//  Created by ashokdy on 19/09/2021.
//

import XCTest
@testable import VintageWines

class VintageViewModelTests: XCTestCase {
    
    func testJSONMapping() throws {
        guard let mockURL = Bundle(for: VintageViewModelTests.self).url(forResource: "VintageWines", withExtension: "json") else { return }
        let viewModel = MockVintageViewModel(mockURL: mockURL)
        viewModel.getWines()
        XCTAssertEqual(viewModel.allVintageWine.recordsMatched, 2)
        XCTAssertEqual(viewModel.allVintageWine.matches.count, 2)
    }
    
    func testDataLoaded() throws {
        guard let mockURL = Bundle(for: VintageViewModelTests.self).url(forResource: "VintageWines", withExtension: "json") else { return }
        let viewModel = MockVintageViewModel(mockURL: mockURL)
        
        viewModel.getWines()
        viewModel.dataLoaded = {
            XCTAssertNotNil(viewModel.allVintageWine)
        }
    }
    
    func testErrorReceived() throws {
        guard let mockURL = Bundle(for: VintageViewModelTests.self).url(forResource: "VintageWines", withExtension: "json") else { return }
        let viewModel = MockVintageViewModel(mockURL: mockURL)
        
        viewModel.getWines()
        viewModel.dataLoaded = {
            XCTAssertNil(viewModel.allVintageWine)
        }
        viewModel.errorReceived = { errorMessage in
            XCTAssertNotNil(errorMessage)
        }
    }
}
