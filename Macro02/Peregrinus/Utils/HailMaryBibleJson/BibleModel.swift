//
//  HailMaryModel.swift
//  Macro02
//
//  Created by Gabriel Ribeiro Noronha on 21/10/2024.
//

struct Bible: Codable {
    let oldTestament: [Book]
    let newTestament: [Book]
    
    enum CodingKeys: String, CodingKey {
        case oldTestament = "antigoTestamento"
        case newTestament = "novoTestamento"
    }
}

struct Book: Codable {
    let name: String
    let chapters: [Chapter]
    
    enum CodingKeys: String, CodingKey {
        case name = "nome"
        case chapters = "capitulos"
    }
}

struct Chapter: Codable {
    let number: Int
    let verses: [Verse]
    
    enum CodingKeys: String, CodingKey {
        case number = "capitulo"
        case verses = "versiculos"
    }
}

struct Verse: Codable {
    let number: Int
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case number = "versiculo"
        case text = "texto"
    }
}
