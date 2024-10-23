//
//  BibleCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class BibleCoordinator: Coordinator {
    
    // Primeira View desta Tab
    var rootViewController: BibleViewController
    
    // Navigation Controller deste fluxo
    var navigationController: UINavigationController
   
    init() {
        self.rootViewController = BibleViewController()
        self.navigationController = UINavigationController(rootViewController: rootViewController)
    }
    
    func start() {
        self.rootViewController.coordinator = self
    }
    
    func showChapters(for book: Book) {
        let chaptersVC = ChaptersViewController()
        chaptersVC.viewModel = ChaptersViewModel(book: book)
        chaptersVC.coordinator = self // Pass the coordinator
        navigationController.pushViewController(chaptersVC, animated: true)
    }

    
    func showVerses(for chapter: Chapter) {
        let versesVC = VersesViewController()
        versesVC.viewModel = VersesViewModel(chapter: chapter)
        versesVC.coordinator = self 
        navigationController.pushViewController(versesVC, animated: true)
    }
    
    func showSpecificVerse(for verse: Verse) {
        let verseVC = VerseViewController()
        verseVC.viewModel = VerseViewModel(verse: verse)
        verseVC.coordinator = self 
        navigationController.pushViewController(verseVC, animated: true)
    }

}
