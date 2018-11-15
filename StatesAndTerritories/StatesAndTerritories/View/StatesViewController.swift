//
//  StatesViewController.swift
//  StatesAndTerritories
//
//  Created by Jovito Royeca on 14/11/2018.
//  Copyright © 2018 Jovito Royeca. All rights reserved.
//

import UIKit
import JRStatesCell
import MBProgressHUD
import PromiseKit

class StatesViewController: UIViewController {

    // MARK: Variables
    let searchController = UISearchController(searchResultsController: nil)
    let viewModel = StatesViewModel()
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        tableView.keyboardDismissMode = .onDrag
        
        // load our framework bundle
        let bundle = Bundle(identifier: "com.jovitoroyeca.JRStatesCell")
        tableView.register(UINib(nibName: "StateTableViewCell", bundle: bundle),
                           forCellReuseIdentifier: StateTableViewCell.reuseIdentifier)
        
        viewModel.fetchData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.isEmpty() {
            fetchData()
        }
    }

    // MARK: Custom methods
    /*
     * Fetch data from web API
     */
    func fetchData() {
        let webService = WebServiceAPI()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        firstly {
            webService.fetchStates()
        }.then { json in
            CoreDataAPI.sharedInstance.saveStates(json: json)
        }.done {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.viewModel.fetchData()
            self.tableView.reloadData()
        }.catch { error in
            print("\(error)")
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    @objc func doSearch() {
        viewModel.queryString = searchController.searchBar.text ?? ""
        viewModel.fetchData()
        tableView.reloadData()
    }
    
    func setup(cell: StateTableViewCell, withState state: State) {
        cell.set(name: state.name)
        cell.set(abbreviation: state.abbreviation)
        
        var text = "Capital: "
        if let capital = state.capital {
            text.append(capital)
        }
        cell.set(capital: text)
        
        text = "Largest City: "
        if let largestCity = state.largestCity {
            text.append(largestCity)
        }
        cell.set(largestCity: text)
        
        text = "Area: "
        if let area = state.area {
            text.append(area.convertToMiles())
            text.append(" sq mi.")
        }
        cell.set(area: text)
    }
}

// MARK: UITableViewDataSource
extension StatesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StateTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? StateTableViewCell else {
            fatalError("\(StateTableViewCell.reuseIdentifier) cell not found.")
        }
        
        let state = viewModel.object(forRowAt: indexPath)
        setup(cell: cell, withState: state)
        
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.sectionIndexTitles()
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return viewModel.sectionForSectionIndexTitle(title: title, at: index)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection(section: section)
    }
}

// MARK: UITableViewDelegate
extension StatesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return StateTableViewCell.cellHeight
    }
}

// MARK: UISearchResultsUpdating
extension StatesViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(doSearch),
                                               object: nil)
        perform(#selector(doSearch),
                with: nil,
                afterDelay: 0.5)
    }
}

// MARK: UISearchResultsUpdating
extension StatesViewController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.searchCancelled = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchCancelled = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if viewModel.searchCancelled {
            searchBar.text = viewModel.queryString
        } else {
            viewModel.queryString = searchBar.text ?? ""
        }
    }
}
