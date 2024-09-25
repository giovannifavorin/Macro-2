//
//  PrayersViewModel.swift
//  Macro02
//
//  Created by Victor Dantas on 20/09/24.
//

import SwiftUI

class PrayersViewModel: ObservableObject {
    
    @Published var prayerCategories: [PrayerCategory] = []
    // ------ "private(set)" -- Define a propriedade @Published para apenas "get",
    //                          deixando o papel de alterar o valor da propriedade ("set") exclusivamente para a ViewModel
    @Published var selectedCategory: PrayerCategory?
    @Published var selectedPrayer: Prayer?
    @Published var fontSize: CGFloat = 17.0
    
    // TO-DO: Popular arrays com chamadas de API
    private let prayers = [Prayer(id: UUID(),
                      title: "Prayer 1 - Category 1 Title",
                      content: "Prayer 1 - Category 1 text\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ligula arcu, maximus vitae sollicitudin pretium, ultrices accumsan tellus. In hac habitasse platea dictumst. Praesent accumsan sapien mauris, eget imperdiet dui convallis pretium. Vestibulum sagittis gravida tortor, vitae facilisis metus porta ut. Pellentesque tempor sem ut felis dignissim viverra."),
               
               Prayer(id: UUID(),
                      title: "Prayer 2 - Category 1 Title",
                      content: "Prayer 2 - Category 1 text\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ligula arcu, maximus vitae sollicitudin pretium, ultrices accumsan tellus. In hac habitasse platea dictumst. Praesent accumsan sapien mauris, eget imperdiet dui convallis pretium. Vestibulum sagittis gravida tortor, vitae facilisis metus porta ut. Pellentesque tempor sem ut felis dignissim viverra."),
               
               Prayer(id: UUID(),
                      title: "Prayer 3 - Category 1 Title",
                      content: "Prayer 3 - Category 1 text\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ligula arcu, maximus vitae sollicitudin pretium, ultrices accumsan tellus. In hac habitasse platea dictumst. Praesent accumsan sapien mauris, eget imperdiet dui convallis pretium. Vestibulum sagittis gravida tortor, vitae facilisis metus porta ut. Pellentesque tempor sem ut felis dignissim viverra.")
                   ]
    
    private let prayers2 = [Prayer(id: UUID(),
                      title: "Prayer 1 - Category 2 Title",
                      content: "Prayer 1 - Category 2 text\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ligula arcu, maximus vitae sollicitudin pretium, ultrices accumsan tellus. In hac habitasse platea dictumst. Praesent accumsan sapien mauris, eget imperdiet dui convallis pretium. Vestibulum sagittis gravida tortor, vitae facilisis metus porta ut. Pellentesque tempor sem ut felis dignissim viverra."),
               
               Prayer(id: UUID(),
                      title: "Prayer 2 - Category 2 Title",
                      content: "Prayer 2 - Category 2 text\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ligula arcu, maximus vitae sollicitudin pretium, ultrices accumsan tellus. In hac habitasse platea dictumst. Praesent accumsan sapien mauris, eget imperdiet dui convallis pretium. Vestibulum sagittis gravida tortor, vitae facilisis metus porta ut. Pellentesque tempor sem ut felis dignissim viverra."),
               
               Prayer(id: UUID(),
                      title: "Prayer 3 - Category 2 Title",
                      content: "Prayer 3 - Category 2 text\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ligula arcu, maximus vitae sollicitudin pretium, ultrices accumsan tellus. In hac habitasse platea dictumst. Praesent accumsan sapien mauris, eget imperdiet dui convallis pretium. Vestibulum sagittis gravida tortor, vitae facilisis metus porta ut. Pellentesque tempor sem ut felis dignissim viverra.")
                   ]
    
    init() {
        // Populando as orações
        // Posteriormente, popular puxando uma API
        self.prayerCategories = [PrayerCategory(id: UUID(),
                                                name: "Category 1",
                                                image: UIImage(systemName: "book")!,
                                                prayers: self.prayers),
                                 
                                 PrayerCategory(id: UUID(),
                                                name: "Category 2",
                                                image: UIImage(systemName: "book.fill")!,
                                                prayers: self.prayers2)
        
        ]
        
        
        
    }
    
}

