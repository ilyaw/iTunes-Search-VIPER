//
//  SearchView.swift
//  iOSArchitecturesDemo
//
//  Created by Evgeny Kireev on 02/06/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

protocol SearchModeControlDelegate: AnyObject {
    func didSelectSearchMode(with mode: SearchMode)
}

enum SearchMode: Int {
    case apps = 0
    case songs = 1
}


final class SearchView: UIView {
    
    weak var delegate: SearchModeControlDelegate?
    
    // MARK: - Subviews
    
    let modeSegmentControl = UISegmentedControl(items: ["Apps", "Songs"])
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let emptyResultView = UIView()
    let emptyResultLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.backgroundColor = .white
        self.addModeSegmentControl()
        self.addSearchBar()
        self.addTableView()
        self.addEmptyResultView()
        self.setupConstraints()
    }
    
    private func addModeSegmentControl() {
        self.modeSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        self.modeSegmentControl.selectedSegmentIndex = 0
        self.modeSegmentControl.addTarget(self, action: #selector(didChangeMode), for: .valueChanged)
        
        self.addSubview(self.modeSegmentControl)
    }
    
    private func addSearchBar() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.searchBarStyle = .minimal
        
        self.addSubview(self.searchBar)
    }
    
    private func addTableView() {
        self.tableView.rowHeight = 72.0
        self.tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 12.0, bottom: 0.0, right: 0.0)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.isHidden = true
        self.tableView.tableFooterView = UIView()
        
        self.addSubview(self.tableView)
    }
    
    private func addEmptyResultView() {
        self.emptyResultView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyResultView.backgroundColor = .white
        self.emptyResultView.isHidden = true
        
        self.emptyResultLabel.translatesAutoresizingMaskIntoConstraints = false
        self.emptyResultLabel.text = "Nothing was found"
        self.emptyResultLabel.textColor = UIColor.darkGray
        self.emptyResultLabel.textAlignment = .center
        self.emptyResultLabel.font = UIFont.systemFont(ofSize: 12.0)
        
        self.addSubview(self.emptyResultView)
        self.emptyResultView.addSubview(self.emptyResultLabel)
    }
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.modeSegmentControl.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            self.modeSegmentControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.modeSegmentControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            self.searchBar.topAnchor.constraint(equalTo: self.modeSegmentControl.bottomAnchor, constant: 5.0),
            self.searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            self.emptyResultView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.emptyResultView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.emptyResultView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.emptyResultView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.emptyResultLabel.topAnchor.constraint(equalTo: self.emptyResultView.topAnchor, constant: 12.0),
            self.emptyResultLabel.leadingAnchor.constraint(equalTo: self.emptyResultView.leadingAnchor),
            self.emptyResultLabel.trailingAnchor.constraint(equalTo: self.emptyResultView.trailingAnchor)
        ])
    }
    
    @objc private func didChangeMode() {
        let searchMode = SearchMode(rawValue: modeSegmentControl.selectedSegmentIndex) ?? .apps
        delegate?.didSelectSearchMode(with: searchMode)
    }
    
}
