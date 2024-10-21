//
//  SinViewModel.swift
//  Macro02
//
//  Created by Giovanni Favorin de Melo on 25/09/24.
//

import Foundation
import Combine
import UIKit

class SinViewModel: ObservableObject {
    
    weak var view: UIViewController?
    
    // Lista de perguntas divididas por mandamento
    @Published var commandments: [Commandment] = []
    
    // Para exibir pecados salvos
    @Published var savedSins: [Sin] = []
    
    private let sinDataManager = DataManager.shared
    
    init() {
        fetchSavedSins()
    }
    
    // Carrega os mandamentos e as perguntas relacionadas
    func loadCommandments(_ int: Int) -> [Commandment] {
        
        switch int {
        case 1:
            return [Commandment(title: "Primeiro Mandamento", description: "Amar a Deus sobre todas as coisas", sins: [
                "Neguei ou abandonei a minha fé.",
                "Tenho a preocupação de conhecê-la melhor.",
                "Recusei-me a defender a minha fé ou fiquei envergonhado dela.",
                "Existe algum aspecto da minha fé que eu ainda não aceito.",
                "Pratiquei o espiritismo ou coloquei a minha confiança em adivinhos ou horóscopos.",
                "Manifestei falta de respeito pelas pessoas, lugares ou coisas santas.",
                "Descuidei da minha responsabilidade de aproximar os outros de Deus, com o meu exemplo e a minha palavra.",
            ]),
                    
                    Commandment(title: "Segundo Mandamento", description: "Não tomar o nome de Deus em vão", sins: [
                        "Disse o nome de Deus em vão."
                    ]),
                    
                    Commandment(title: "Terceiro Mandamento", description: "Guardar domingos e festas de guarda", sins: [
                        "Faltei voluntariamente à Missa nos domingos ou dias de preceito.",
                        "Recebi a Comunhão sem agradecimento ou sem a devida reverência."
                    ]),
                    
            ]
            
        case 2:
            return [
                Commandment(title: "Quarto Mandamento", description: "Honrar pai e mãe", sins: [
                "Não honrei os meus pais ou figuras de autoridade."
                ]),
                    
                    Commandment(title: "Quinto Mandamento", description: "Não matar", sins: [
                        "Fui violento nas palavras ou ações com outros.",
                        "Tive ódio ou juízos críticos, em pensamentos ou ações.",
                        "Olhei os outros com desprezo.",
                        "Colaborei ou encorajei alguém a fazer um aborto, destruir embriões humanos, praticar a eutanásia ou outro meio de acabar com a vida.",
                        "Abusei de bebidas alcoólicas.",
                        "Usei drogas."
                    ]),
                    
                    Commandment(title: "Sexto Mandamento", description: "Não pecar contra a castidade", sins: [
                        "Assisti vídeos ou acessei sites pornográficos.",
                        "Cometi atos impuros, sozinho ou com outras pessoas.",
                        "Estou morando com alguém como se fosse casado, sem que o seja.",
                        "Se sou casado, não procuro amar o meu cônjuge mais do que a qualquer outra pessoa.",
                        "Não coloco meu casamento em primeiro lugar.",
                        "Não tenho uma atitude aberta para novos filhos."
                    ]),
                    
                    
                    Commandment(title: "Sétimo Mandamento", description: "Não furtar", sins: [
                        "Roubei ou enganei alguém no trabalho.",
                        "Gastei dinheiro com o meu conforto e luxo pessoal, esquecendo minhas responsabilidades para com os outros e para com a Igreja."
                    ]),
                    
            ]
            
        case 3:
            return [
                
                Commandment(title: "Oitavo Mandamento", description: "Não levantar falso testemunho", sins: [
                    "Falei mal dos outros, transformando o assunto em fofoca.",
                    "Disse mentiras.",
                    "Não fui honesto ou diligente no meu trabalho."
                ]),
                
                Commandment(title: "Nono Mandamento", description: "Não desejar a mulher do próximo", sins: [
                        "Desejei ou tive pensamentos impuros com pessoas que não são meu cônjuge (implícito nas questões de pureza e castidade)."
                ]),
                
                Commandment(title: "Décimo Mandamento", description: "Não cobiçar as coisas alheias", sins: [
                "Fui invejoso.",
                "Fui orgulhoso ou egoísta em meus pensamentos e ações.",
                "Cedi à preguiça.",
                "Preferi a comodidade ao invés de servir aos demais.",
                "Trabalhei de forma desordenada, ocupando tempo e energias que deveria dedicar à minha família e amigos."
                ])
                   
            ]
            
        default:
            return []
        }
    }
    
    // Verifica se uma pergunta já foi marcada como pecado
    func isQuestionMarkedAsSin(question: String) -> Bool {
        return savedSins.contains { $0.sinDescription == question }
    }
    
    // Marca uma pergunta como pecado
    func markAsSin(question: String) {
        let sinDescription = question
        if sinDataManager.createSin(commandments: "primeiro", commandmentDescription: "pecado", sinDescription: sinDescription) != nil {
            fetchSavedSins()
        }
    }
    
    // Desmarca uma pergunta como pecado
    func unmarkAsSin(question: String) {
        if let sin = savedSins.first(where: { $0.sinDescription == question }) {
            sinDataManager.deleteSin(sin)
            fetchSavedSins()
        }
    }
    
    // Busca os pecados já salvos
    func fetchSavedSins() {
//        savedSins = sinDataManager.fetchAllSins(for: ) ?? []
    }
}

struct Commandment {
    let title: String
    let description: String
    var sins: [String]
}
