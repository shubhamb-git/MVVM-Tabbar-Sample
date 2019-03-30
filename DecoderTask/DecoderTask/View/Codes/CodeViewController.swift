//
//  CodeViewController.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 16/02/19.
//  Copyright © 2019 SB. All rights reserved.
//
import UIKit
import DropDown

class CodeViewController: BaseViewController, CodeViewModelDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    lazy var viewModel = CodeViewModel(with: self)
    lazy var dropDownFilterOptions = DropDown()

    var filterOptions = {
        return ["All", "JAVA", "C++", "C#", "Py", "C"]
    }()
    
    var tableHeader: UIView = {
       let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 5))
        headerView.backgroundColor = .clear
        return headerView
    }()
    
    var filterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("All", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(#colorLiteral(red: 0.3607843137, green: 0.8470588235, blue: 0.8862745098, alpha: 1), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.3607843137, green: 0.8470588235, blue: 0.8862745098, alpha: 0.4), for: .highlighted)
        button.setImage(UIImage(named: "caret-down"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)

        button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        return button
    }()
    
    var refreshButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Refresh", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(#colorLiteral(red: 0.3607843137, green: 0.8470588235, blue: 0.8862745098, alpha: 1), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.3607843137, green: 0.8470588235, blue: 0.8862745098, alpha: 0.4), for: .highlighted)
        button.contentHorizontalAlignment = .left
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        return button
    }()
    
    @objc private func filterButtonClicked(_ sender: UIButton) {
        dropDownFilterOptions.anchorView = sender
        dropDownFilterOptions.dataSource = self.filterOptions
        dropDownFilterOptions.reloadAllComponents()
        dropDownFilterOptions.show()
    }
   
    @objc private func refreshButtonClicked(_ sender: UIButton) {
        // fetch record from server
        activityIndicator.startAnimating()
        viewModel.getCode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUISetup()
        initialSetup()
        // fetch record from server
        activityIndicator.startAnimating()
        viewModel.getCode()
    }
    
    private func navigationUISetup() {
        navigationController?.navigationBar.prefersLargeTitles = true

        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        navigationItem.searchController = search

        refreshButton.addTarget(self, action: #selector(CodeViewController.refreshButtonClicked(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: refreshButton)

        filterButton.addTarget(self, action: #selector(CodeViewController.filterButtonClicked(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
    }
    
    private func initialSetup() {
        CodeItemCell.registerCell(to: tableView)
        tableView.tableHeaderView = tableHeader
        
        dropDownFilterOptions.selectionAction = { (index: Int, item: String) in
            self.filterButton.setTitle(item, for: .normal)
        }
    }
    
    //MARK: - CodeViewModelDelegate
    func didReceiveCodeItemsFromServer() {
        DispatchQueue.main.sync {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
}

extension CodeViewController: UISearchResultsUpdating {
 
    func updateSearchResults(for searchController: UISearchController) {
        // update table records
    }
}

extension CodeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.codeItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CodeItemCell.cell(for: tableView, at: indexPath, with: viewModel.codeItems[indexPath.row])
    }
}
