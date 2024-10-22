import UIKit

// Coordinator principal do aplicativo, responsável por decidir qual fluxo iniciar (onboarding ou main)
class ApplicationCoordinator: Coordinator {
    
    // Referência à janela principal do app (passada pelo SceneDelegate)
    private let window: UIWindow
    private let onboardingService: OnboardingServiceProtocol // Serviço de onboarding para verificar o estado
    
    // Inicializador que recebe a janela e o serviço de onboarding
    init(window: UIWindow) {
        self.window = window
        self.onboardingService = OnboardingService()
    }
    
    // Método principal que inicia o fluxo do aplicativo
    func start() {
        print("Application Coordinator --- STARTED")
        
        // Verifica se o usuário já viu o onboarding usando o serviço de onboarding
        if onboardingService.hasSeenOnboarding() {
            self.startMainTabFlow() // Se já viu, inicia o fluxo principal
        } else {
            self.startOnboardingFlow() // Se não viu, inicia o onboarding
        }
        
        // Faz a janela ser visível
        self.window.makeKeyAndVisible()
    }
    
    // Método que inicia o fluxo principal (Tab Bar)
    private func startMainTabFlow() {
        let mainTabCoordinator = MainTabBarCoordinator() // Inicializa o Coordinator da Tab Bar
        mainTabCoordinator.start() // Inicia o Coordinator da Tab Bar
        
        // Define o rootViewController da janela como a Tab Bar Controller
        self.window.rootViewController = mainTabCoordinator.tabBarController
    }
    
    // Método que inicia o fluxo de onboarding
    private func startOnboardingFlow() {
        let onboardingCoordinator = OnboardingCoordinator(onboardingService: onboardingService) // Passa o serviço para o Coordinator de onboarding
        onboardingCoordinator.start() // Inicia o Onboarding Coordinator
        
        // Define o rootViewController da janela como o OnboardingPageViewController
        self.window.rootViewController = onboardingCoordinator.rootViewController
        
        // Quando o onboarding for concluído, inicia o fluxo principal
        onboardingCoordinator.onboardingDidFinish = { [weak self] in
            self?.startMainTabFlow()
        }
    }
}
