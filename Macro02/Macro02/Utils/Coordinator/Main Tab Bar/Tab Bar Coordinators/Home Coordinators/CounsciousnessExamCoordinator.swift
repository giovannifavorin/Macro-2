//
//  CounsciousnessExamCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 19/09/24.
//

import UIKit
import Combine

class CounsciousnessExamCoordinator: Coordinator {
    
    var viewModel = CounsciousnessExamViewModel()
    
    lazy var rootViewController: CounsciousnessExamViewController = {
        let vc = CounsciousnessExamViewController(viewModel: viewModel)
        vc.hidesBottomBarWhenPushed = true // esconde a tab bar
        return vc
    }()
    
    // Subscription para manter o Combine observando mudanças
    private var cancellables = Set<AnyCancellable>()
        
    func start() {
        print("APERTOU")
        
        // Lidar com as diferentes telas do Exame de Consciência
        // enum com switch
        
    }
}
