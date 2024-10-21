//
//  CapitulosViewController.swift
//  Macro02
//
//  Created by Gabriel Ribeiro Noronha on 21/10/2024.
//
//
import UIKit

class ChaptersViewController: UIViewController {
    
    var viewModel: ChaptersViewModel?
    var coordinator: BibleCoordinator?
    private var tableView: UITableView!
    
    
    override func loadView() {
        tableView = UITableView()
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = viewModel?.book.name
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "chapterCell")
    }
}

extension ChaptersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.book.chapters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chapterCell", for: indexPath)
        let chapter = viewModel?.book.chapters[indexPath.row]
        cell.textLabel?.text = "Chapter \(chapter?.number ?? 0)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let chapter = viewModel?.book.chapters[indexPath.row] else { return }
        print("Selected Chapter: \(chapter.number)")
        coordinator?.showVerses(for: chapter) 
    }
}
