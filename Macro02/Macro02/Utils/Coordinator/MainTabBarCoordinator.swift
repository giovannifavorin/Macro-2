//
//  MainTabBarCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 10/10/24.
//

import UIKit

class MainTabBarCoordinator: Coordinator {
    
    var tabBarController: UITabBarController
    
    init() {
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        
        let sinViewModel = SinViewModel() // Instância única da SinViewModel
        
        
        // MARK: Instância dos Coordinators que irão compor a Tab Bar
        // Home Coordinator
        let homeCoordinator = HomeCoordinator(sinViewModel: sinViewModel)
        homeCoordinator.start()
        
        // Bible Coordinator
        let bibleCoordinator = BibleCoordinator()
        bibleCoordinator.start()
        
        // Confession Coordinator
        let confessionCoordinator = ConfessionCoordinator(viewModel: sinViewModel)
        confessionCoordinator.start()
        
        // Daily Liturgy Coordinator
        let dailyLiturgyCoordinator = DailyLiturgyCoordinator()
        dailyLiturgyCoordinator.start()
        
        // About Coordinator
        let aboutCoordinator = AboutCoordinator()
        aboutCoordinator.start()
        
        
        
        // navigationControllers de cada Coordinator
        let homeNavController = homeCoordinator.navigationController
        let bibleNavController = bibleCoordinator.navigationController
        let confessionNavController = confessionCoordinator.navigationController
        let dailyLiturgyNavController = dailyLiturgyCoordinator.navigationController
        let aboutNavController = aboutCoordinator.navigationController
        
        // Configurando a aparência dos Tab Bar Itens
        setupTabBarItems(vc: homeNavController,
                         title: "Home",
                         imageName: "house",
                         selectedImageName: "house.fill")
        
        setupTabBarItems(vc: confessionNavController,
                         title: "Confession",
                         imageName: "book.pages",
                         selectedImageName: "book.pages.fill")
        
        setupTabBarItems(vc: dailyLiturgyNavController,
                         title: "Liturgy",
                         imageName: "sun.max",
                         selectedImageName: "sun.max.fill")
        
        setupTabBarItems(vc: bibleNavController,
                         title: "Bible",
                         imageName: "book",
                         selectedImageName: "book.fill")
        
        setupTabBarItems(vc: aboutNavController,
                         title: "About",
                         imageName: "line.3.horizontal.circle",
                         selectedImageName: "line.3.horizontal.circle.fill")
        
        
        
        // Define as navigations na Tab Bar
        self.tabBarController.viewControllers = [dailyLiturgyNavController, confessionNavController, homeNavController, bibleNavController, aboutNavController]
        
    }
    
    // Função auxiliar para alterar a aparência dos itens Tab Bar
    private func setupTabBarItems(vc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        let defaultImage = UIImage(systemName: imageName) ?? UIImage()
        let selectedImage = UIImage(systemName: selectedImageName) ?? UIImage()
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        vc.tabBarItem = tabBarItem
    }
}
