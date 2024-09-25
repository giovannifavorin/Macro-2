//
//  HomeViewModel.swift
//  Macro02
//
//  Created by Victor Dantas on 17/09/24.
//

import SwiftUI
import UIKit

class HomeViewModel: ObservableObject {
    @Published var selectedNavigation: NavigationCases = .none
}

// Todos os casos de navegacão possíveis a partir da Home
enum NavigationCases {
    
    case liturgicalCalendar
    case penance
    case counsciousnessExam
    case todaysSaint
    case prayers
    
    case none
}
