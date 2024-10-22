//
//  BibleViewModel.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import SwiftUI

class BibleViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var oldTestament: [Book] = []
    @Published var newTestament: [Book] = []
    
//    loadBooks() loads the entire Bible from the JSON file.
    func loadBooks() {
        if let bible = loadBible() {
            self.oldTestament = bible.oldTestament
            self.newTestament = bible.newTestament
            self.books = oldTestament + newTestament
        } else {
            print("Failed to load Bible data")
        }
    }
    
//    Get all chapters from a specific book.
    func getChapters(for book: Book) -> [Chapter] {
        return book.chapters
    }
    
//    From the selected book, the user picks a chapter, and you list the verses using getVerses(for:).
    func getVerses(for chapter: Chapter) -> [Verse] {
        return chapter.verses
    }
    
    /// Get a specific verse by number from a chapter.
    func getVerse(from chapter: Chapter, number: Int) -> Verse? {
        return chapter.verses.first { $0.number == number }
    }

    
    /// Private method to decode the Bible JSON.
    private func loadBible() -> Bible? {
        guard let url = Bundle.main.url(forResource: "bibliaAveMaria", withExtension: "json") else {
            print("JSON file not found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(Bible.self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
}
