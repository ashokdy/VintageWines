//
//  VintageViewModel.swift
//  VintageWines
//
//  Created by ashokdy on 16/09/2021.
//

import Foundation
import Networking
import Combine

typealias DataLoadedBlock = (() -> Void)
typealias ErrorReceivedBlock = ((String) -> Void)

enum FilterType: Int {
    case name = 0
    case year
    case actual
}

protocol VintageWinesViewModelType {
    var allVintageWine: VintageWine { get set }
    var filteredVintageWine: VintageWine { get set }
    var filterType: FilterType { get set }
    
    var dataLoaded: DataLoadedBlock? { get set }
    var errorReceived: ErrorReceivedBlock? { get set }
    
    func getWines()
}

class VintageViewModel: VintageWinesViewModelType {
    
    var cancellables = [AnyCancellable]()
    
    var allVintageWine = VintageWine()
    var filteredVintageWine = VintageWine()
    var filterType = FilterType.actual
    
    var dataLoaded: (() -> Void)?
    var errorReceived: ((String) -> Void)?
    
    func getWines() {
        let serviceTask = VintageService().fetchWineList()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    self?.errorReceived?(error.localizedDescription)
                    print(error)
                }
            } receiveValue: { [weak self] vintageWine in
                self?.allVintageWine = vintageWine
                self?.filteredVintageWine = vintageWine
                self?.dataLoaded?()
            }
        cancellables.append(serviceTask)
    }
    
    func noOfRows() -> Int {
        allVintageWine.matches.count
    }
    
    func filterVintageWines(filterType: FilterType) {
        self.filterType = filterType
        switch filterType {
        case .actual: break
        case .name:
            filteredVintageWine.matches.sort(by: { $0.vintage.name < $1.vintage.name })
        case .year:
            filteredVintageWine.matches.sort(by: { $0.vintage.year < $1.vintage.year })
        }
        self.dataLoaded?()
    }
    
    func dataSource() -> VintageWine {
        switch filterType {
        case .actual:
            return allVintageWine
        case .name, .year:
            return filteredVintageWine
        }
    }
}

#if DEBUG
class MockVintageViewModel: VintageWinesViewModelType {
    var allVintageWine = VintageWine()
    var filteredVintageWine = VintageWine()
    var filterType: FilterType = .actual
    var dataLoaded: DataLoadedBlock?
    var errorReceived: ErrorReceivedBlock?
    
    var mockURL: URL
    var cancellables = [AnyCancellable]()
    
    init(mockURL: URL) {
        self.mockURL = mockURL
    }
    
    func getWines() {
        let serviceTask = VintageMockService(mockURL: mockURL).fetchWineList()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    self?.errorReceived?(error.localizedDescription)
                    print(error)
                }
            } receiveValue: { [weak self] vintageWine in
                self?.allVintageWine = vintageWine
                self?.filteredVintageWine = vintageWine
                self?.dataLoaded?()
            }
        cancellables.append(serviceTask)
    }
}
#endif
