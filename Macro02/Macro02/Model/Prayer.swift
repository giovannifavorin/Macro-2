//
//  Prayer.swift
//  Macro02
//
//  Created by Victor Dantas on 20/09/24.
//

import UIKit

struct Prayer {
    var id: UUID
    var title: String
    var content: String
}

struct PrayerCategory {
    var id: UUID
    var name: String
    var image: UIImage
    var prayers: [Prayer]
}
