//
//  HomeViewModel.swift
//  Macro02
//
//  Created by Victor Dantas on 17/09/24.
//

import SwiftUI
import UIKit

class HomeViewModel: ObservableObject {
    @Published var selectedNavigation: HomeNavigationCases = .none
}

// Todos os casos de navegação possíveis a partir da Home
enum HomeNavigationCases {
    
    case liturgicalCalendar
    case penance
    case consciousnessExam
    case todaysSaint
    case prayers
    
    case none
}
