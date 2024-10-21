//
//  BibleViewModel.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import SwiftUI

class BibleViewModel: ObservableObject {
    @Published var books: [Book] = [] // Updated variable name to English
    
    func loadBooks() {
        // Decode the JSON and load the books
        if let bible = loadBible() {
            books = bible.oldTestament + bible.newTestament
        }
    }
    
    func load

    private func loadBible() -> Bible? {
        guard let url = Bundle.main.url(forResource: "bibliaAveMaria", withExtension: "json") else {
            print("Failed to locate bibliaAveMaria.json in bundle.")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(Bible.self, from: data)
        } catch {
            print("Failed to load Bible: \(error)")
            return nil
        }
    }
    
}
