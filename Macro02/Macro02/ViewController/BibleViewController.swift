//
//  BibleViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class BibleViewController: UIViewController{
    
    var viewModel: BibleViewModel? = BibleViewModel()
    private var bibleView: BibleView!
    var coordinator: BibleCoordinator?
    
    
    override func loadView() {
        bibleView = BibleView()
        view = bibleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bible"
        setupTableView()
        viewModel?.loadBooks()
        print("BibleViewController Loaded Successfully")
    }
    
    private func setupTableView() {
        bibleView.tableView.delegate = self
        bibleView.tableView.dataSource = self
        bibleView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension BibleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.books.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let book = viewModel?.books[indexPath.row]
        cell.textLabel?.text = book?.name
        return cell
    }
    
}
