//
//  SelectionModalViewController.swift
//  Peregrinus
//
//  Created by Gabriel Ribeiro Noronha on 22/10/2024.
//

import UIKit

protocol SelectionModalDelegate: AnyObject {
    func didSelectVerse(_ verse: Verse)
}

class SelectionModalViewController: UIViewController {

    var viewModel = BibleViewModel()
    weak var delegate: SelectionModalDelegate?
    private var tableView: UITableView!

    private var selectedBook: Book?
    private var selectedChapter: Chapter?

    override func loadView() {
        tableView = UITableView()
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadBooks()
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "selectionCell")
    }

    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension SelectionModalViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        // Define the number of sections dynamically
        if selectedBook == nil {
            return 1 // Show books only
        } else if selectedChapter == nil {
            return 1 // Show chapters of the selected book
        } else {
            return 1 // Show verses of the selected chapter
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Determine the correct number of rows
        if selectedBook == nil {
            return viewModel.books.count // List all books
        } else if selectedChapter == nil {
            return selectedBook?.chapters.count ?? 0 // List chapters
        } else {
            return selectedChapter?.verses.count ?? 0 // List verses
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectionCell", for: indexPath)

        if selectedBook == nil {
            let book = viewModel.books[indexPath.row]
            cell.textLabel?.text = book.name
        } else if selectedChapter == nil, let book = selectedBook {
            let chapter = book.chapters[indexPath.row]
            cell.textLabel?.text = "Chapter \(chapter.number)"
        } else if let chapter = selectedChapter {
            let verse = chapter.verses[indexPath.row]
            cell.textLabel?.text = "\(verse.number). \(verse.text.prefix(30))..."
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedBook == nil {
            // User selected a book
            selectedBook = viewModel.books[indexPath.row]
            reloadTableView() // Reload the table to show chapters
        } else if selectedChapter == nil, let book = selectedBook {
            // User selected a chapter
            selectedChapter = book.chapters[indexPath.row]
            reloadTableView() // Reload the table to show verses
        } else if let chapter = selectedChapter {
            // User selected a verse
            let verse = chapter.verses[indexPath.row]
            delegate?.didSelectVerse(verse) // Pass the verse to the delegate
            dismiss(animated: true, completion: nil) // Close the modal
        }
    }
}
