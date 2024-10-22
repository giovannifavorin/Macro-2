//
//  BibleViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class BibleViewController: UIViewController{
    
    var viewModel = BibleViewModel()
    private var bibleView: BibleView!
    var coordinator: BibleCoordinator?
    
    
    override func loadView() {
        bibleView = BibleView()
        view = bibleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bible"
        viewModel.loadBooks()
        print("BibleViewController Loaded Successfully")
        
        // Add a button to open the modal
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Select Verse",
            style: .plain,
            target: self,
            action: #selector(openSelectionModal)
        )
    }
    
    @objc private func openSelectionModal() {
        coordinator?.showSelectionModal(from: self)
    }
}

extension BibleViewController: SelectionModalDelegate {
    func didSelectVerse(_ verse: Verse) {
        // Update the view with the selected verse
        bibleView.titleLabel.text = "\(verse.number): \(verse.text)"
        
        // Force the UI to update
        bibleView.setNeedsLayout()
        bibleView.layoutIfNeeded()
    }
}
