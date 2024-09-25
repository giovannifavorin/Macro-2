//
//  MainCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 17/09/24.
//

import SwiftUI
import UIKit

class MainTabBarCoordinator: Coordinator {
    
    var rootViewController: UITabBarController
    var childCoordinators = [Coordinator]()
    
    // ViewModels
    var homeViewModel = HomeViewModel()
    var confessionViewModel = ConfessionViewModel()
    var dailyLiturgyViewModel = DailyLiturgyViewModel()
    var bibleViewModel = BibleViewModel()
    var aboutViewModel = AboutViewModel()
    
    init() {
        self.rootViewController = UITabBarController()
        self.rootViewController.tabBar.isTranslucent = true
    }
    
    func start() {
        print("\nSTARTED MAIN COORDINATOR")
        
        // Instanciando e iniciando todos os Coordinators que irão compor a Tab Bar
        // HOME
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.start()
        childCoordinators.append(homeCoordinator)
        
        // CONFESSION
        let confessionCoordinator = ConfessionCoordinator()
        confessionCoordinator.start()
        childCoordinators.append(confessionCoordinator)
        
        // DAILY LITURGY
        let dailyLiturgyCoordinator = DailyLiturgyCoordinator()
        dailyLiturgyCoordinator.start()
        childCoordinators.append(dailyLiturgyCoordinator)
        
        // BIBLE
        let bibleCoordinator = BibleCoordinator()
        bibleCoordinator.start()
        childCoordinators.append(bibleCoordinator)
        
        // ABOUT
        let aboutCoordinator = AboutCoordinator()
        aboutCoordinator.start()
        childCoordinators.append(aboutCoordinator)
        
        
        // Atribuindo as rootViewControllers de cada Coordinator para sua prórpia variável
        let homeViewController = homeCoordinator.rootViewController
        let confessionViewController = confessionCoordinator.rootViewController
        let dailyLiturgyViewController = dailyLiturgyCoordinator.rootViewController
        let bibleViewController = bibleCoordinator.rootViewController
        let aboutViewController = aboutCoordinator.rootViewController
        
        
        // Configurando a aparência dos Tab Bar Itens
        setupTabBarItems(vc: homeViewController,
                         title: "Home",
                         imageName: "house",
                         selectedImageName: "house.fill")
        
        setupTabBarItems(vc: confessionViewController,
                         title: "Confession",
                         imageName: "book.pages",
                         selectedImageName: "book.pages.fill")
        
        setupTabBarItems(vc: dailyLiturgyViewController,
                         title: "Liturgy",
                         imageName: "sun.max",
                         selectedImageName: "sun.max.fill")
        
        setupTabBarItems(vc: bibleViewController,
                         title: "Bible",
                         imageName: "book",
                         selectedImageName: "book.fill")
        
        setupTabBarItems(vc: aboutViewController,
                         title: "About",
                         imageName: "line.3.horizontal.circle",
                         selectedImageName: "line.3.horizontal.circle.fill")
        
        
        
        // Define as Views que popularão a Tab Bar
        self.rootViewController.viewControllers = [dailyLiturgyViewController, confessionViewController, homeViewController, bibleViewController, aboutViewController]
    }
    
    
    
    
    // Função auxiliar para alterar a aparência dos itens Tab Bar
    func setupTabBarItems(vc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        let defaultImage = UIImage(systemName: imageName)
        let selectedImage = UIImage(systemName: selectedImageName)
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        vc.tabBarItem = tabBarItem
    }
    
}
