//
//  CounsciousnessExamViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 19/09/24.
//

import UIKit
import SwiftUI

class ConsciousnessExamViewController: UIViewController {

    @ObservedObject var viewModel: ConsciousnessExamViewModel
    
    init(viewModel: ConsciousnessExamViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
    }

}
