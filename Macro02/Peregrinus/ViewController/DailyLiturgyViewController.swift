import UIKit
import SwiftUI

class DailyLiturgyViewController: UIViewController {
    
    // MARK: - ViewModel e propriedades
    weak var coordinator: DailyLiturgyCoordinator?  // Adicionando a referência ao Coordinator
    private let viewModel = DailyLiturgyViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHostingController()
    }
    
    private func setupHostingController() {
        let dailyLiturgyView = DailyLiturgyView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: dailyLiturgyView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
}

//Whaper do card pra transformar de UIKIT para SwiftUI
struct LiturgyCardViewWrapper: UIViewRepresentable {
    
    typealias UIViewType = LiturgyCardView
    let liturgia: Liturgia

    // Cria a UIView
    func makeUIView(context: Context) -> LiturgyCardView {
        let view = LiturgyCardView()
        view.update(with: liturgia) // Configura com os dados da liturgia
        return view
    }

    // Atualiza a UIView quando necessário
    func updateUIView(_ uiView: LiturgyCardView, context: Context) {
        uiView.update(with: liturgia)
    }
}

#Preview {
    DailyLiturgyView(viewModel: DailyLiturgyViewModel())
}

