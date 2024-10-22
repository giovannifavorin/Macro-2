//
//  Untitled.swift
//  Macro02
//
//  Created by Gabriel Ribeiro Noronha on 21/10/2024.
//

import UIKit

class VersesViewController: UIViewController {

    var viewModel: VersesViewModel?
    var coordinator: BibleCoordinator?
    private var tableView: UITableView!

    override func loadView() {
        tableView = UITableView()
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chapter \(viewModel?.chapter.number ?? 0)"
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "verseCell")
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource

extension VersesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.chapter.verses.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "verseCell", for: indexPath)
        if let verse = viewModel?.chapter.verses[indexPath.row] {
            cell.textLabel?.text = "\(verse.number). \(verse.text.prefix(30))..." // Display part of the verse
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let verse = viewModel?.chapter.verses[indexPath.row] else { return }
        coordinator?.showSpecificVerse(for: verse) // Navigate to the specific verse
    }
}




