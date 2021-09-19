//
//  ViewController.swift
//  VintageWines
//
//  Created by ashokdy on 16/09/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var winesTableView: UITableView?
    
    var viewModel = VintageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBinding()
    }
    
    @IBAction func resetWinesListToApi(_ sender: UIBarButtonItem) {
        viewModel.filterVintageWines(filterType: .actual)
    }
    
    @IBAction func filterWinesList(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case FilterType.name.rawValue: viewModel.filterVintageWines(filterType: .name)
        case FilterType.year.rawValue: viewModel.filterVintageWines(filterType: .year)
        default: break
        }
    }
    
    func setupView() {
        winesTableView?.register(UINib(nibName: Constants.vintageWineCell, bundle: nil), forCellReuseIdentifier: Constants.vintageWineCell)
    }
    
    func setupBinding() {
        let loader = self.showLoading()
        viewModel.getWines()
        viewModel.dataLoaded = { [weak self] in
            loader.dismiss(animated: true)
            self?.winesTableView?.reloadData()
        }
        viewModel.errorReceived = { errorMessage in
            loader.dismiss(animated: true) { [weak self] in
                self?.showAlert(messageText: errorMessage)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.noOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.vintageWineCell) as? VintageWineTableCell else { return UITableViewCell() }
        cell.vintageModel = viewModel.dataSource().matches.at(indexPath.row)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
