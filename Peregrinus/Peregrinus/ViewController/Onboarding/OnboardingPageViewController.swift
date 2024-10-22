//
//  OnboardingPageViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 10/10/24.
//

import UIKit
import SwiftUI

// Animação da PageViewController ------------------------
class OnboardingPageViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    var coordinator: OnboardingCoordinator?
    
    
    init() {
        // Inicializa a PageViewController com a animação de transição "scroll"
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupPages()
        style()
        layout()
    }
    
    
    
    private func setupPages() {
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        // ViewControllers que compõem a Tab Bar
        let page1 = UIHostingController(rootView: OnboardingFirstView(nextPageAction: { [weak self] in
            self?.goToNextPage()
        }))
        let page2 = UIHostingController(rootView: OnboardingSecondView(nextPageAction: { [weak self] in
            self?.goToNextPage()
        }))
        let page3 = UIHostingController(rootView: OnboardingThirdView(nextPageAction: { [weak self] in
            self?.goToNextPage()
        }))
        let page4 = UIHostingController(rootView: OnboardingFourthView(nextPageAction: { [weak self] in
            self?.goToNextPage()
        }))
        
        // Para a quinta página, passa a closure para finalizar o onboarding
        let page5 = UIHostingController(rootView: OnboardingFifthView(finishAction: { [weak self] in
            self?.finishOnboarding()
        }))
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        pages.append(page5)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: false)
    }

    
    private func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    private func layout() {
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func goToNextPage() {
        guard let currentViewController = viewControllers?.first,
              let currentIndex = pages.firstIndex(of: currentViewController),
              currentIndex < pages.count - 1 else {
            return
        }
        let nextIndex = currentIndex + 1
        setViewControllers([pages[nextIndex]], direction: .forward, animated: true, completion: nil)
        
        pageControl.currentPage = nextIndex
    }
    
    @objc
    private func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: false)
    }
    
    @objc
    private func finishOnboarding() {
        coordinator?.finishOnboarding()
    }

}

// MARK: - Delegates
extension OnboardingPageViewController: UIPageViewControllerDelegate {
    
    // Monitora a página atual para atualizar o Page Control (bolinhas que ficam embaixo)
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}

// MARK: - Data Sources
extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    // Controla o retorno das views
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // Index da página atual sendo mostrada
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            // Se for a primeira página
            return nil // Permanece na mesma
        } else {
            // Se não for a primeira página
            return pages[currentIndex - 1] // Retorna
        }
    }
    
    // Controla o avanço das views
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // Index da página atual sendo mostrada
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            // Se não for a última página
            return pages[currentIndex + 1] // Avança
        } else {
            // Se for a última página
            return nil // Permanece na mesma
        }
    }
    
}
