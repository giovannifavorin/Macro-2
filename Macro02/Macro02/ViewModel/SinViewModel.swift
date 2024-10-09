//
//  SinViewModel.swift
//  Macro02
//
//  Created by Giovanni Favorin de Melo on 25/09/24.
//

import Foundation
import Combine

class SinViewModel: ObservableObject {
    
    // Lista de perguntas divididas por mandamento
    @Published var commandments: [Commandment] = []
    
    // Para exibir pecados salvos
    @Published var savedSins: [Sin] = []
    
    private let sinDataManager = DataManager.shared
    
    init() {
        loadCommandments()
        fetchSavedSins()
    }
    
    // Carrega os mandamentos e as perguntas relacionadas
    func loadCommandments() {
        commandments = [
            Commandment(title: "Décimo Mandamento", description: "Não cobiçar as coisas alheias", questions: [
                "Fui invejoso?",
                "Fui orgulhoso ou egoísta em meus pensamentos e ações?",
                "Cedi à preguiça?",
                "Preferi a comodidade ao invés de servir aos demais?",
                "Trabalhei de forma desordenada, ocupando tempo e energias que deveria dedicar à minha família e amigos?"
            ]),
            Commandment(title: "Nono Mandamento", description: "Não desejar a mulher do próximo", questions: [
                "Desejei ou tive pensamentos impuros com pessoas que não são meu cônjuge (implícito nas questões de pureza e castidade)?"
            ]),
            Commandment(title: "Oitavo Mandamento", description: "Não levantar falso testemunho", questions: [
                "Falei mal dos outros, transformando o assunto em fofoca?",
                "Disse mentiras?",
                "Não fui honesto ou diligente no meu trabalho?"
            ]),
            Commandment(title: "Sétimo Mandamento", description: "Não furtar", questions: [
                "Roubei ou enganei alguém no trabalho?",
                "Gastei dinheiro com o meu conforto e luxo pessoal, esquecendo minhas responsabilidades para com os outros e para com a Igreja?"
            ]),
            Commandment(title: "Sexto Mandamento", description: "Não pecar contra a castidade", questions: [
                "Assisti vídeos ou acessei sites pornográficos?",
                "Cometi atos impuros, sozinho ou com outras pessoas?",
                "Estou morando com alguém como se fosse casado, sem que o seja?",
                "Se sou casado, não procuro amar o meu cônjuge mais do que a qualquer outra pessoa?",
                "Não coloco meu casamento em primeiro lugar?",
                "Não tenho uma atitude aberta para novos filhos?"
            ]),
            Commandment(title: "Quinto Mandamento", description: "Não matar", questions: [
                "Fui violento nas palavras ou ações com outros?",
                "Tive ódio ou juízos críticos, em pensamentos ou ações?",
                "Olhei os outros com desprezo?",
                "Colaborei ou encorajei alguém a fazer um aborto, destruir embriões humanos, praticar a eutanásia ou outro meio de acabar com a vida?",
                "Abusei de bebidas alcoólicas?",
                "Usei drogas?"
            ]),
            Commandment(title: "Quarto Mandamento", description: "Honrar pai e mãe", questions: [
                "Não honrei os meus pais ou figuras de autoridade?"
            ]),
            Commandment(title: "Terceiro Mandamento", description: "Guardar domingos e festas de guarda", questions: [
                "Faltei voluntariamente à Missa nos domingos ou dias de preceito?",
                "Recebi a Comunhão sem agradecimento ou sem a devida reverência?"
            ]),
            Commandment(title: "Segundo Mandamento", description: "Não tomar o nome de Deus em vão", questions: [
                "Disse o nome de Deus em vão?"
            ]),
            Commandment(title: "Primeiro Mandamento", description: "Amar a Deus sobre todas as coisas", questions: [
                "Neguei ou abandonei a minha fé?",
                "Tenho a preocupação de conhecê-la melhor?",
                "Recusei-me a defender a minha fé ou fiquei envergonhado dela?",
                "Existe algum aspecto da minha fé que eu ainda não aceito?",
                "Pratiquei o espiritismo ou coloquei a minha confiança em adivinhos ou horóscopos?",
                "Manifestei falta de respeito pelas pessoas, lugares ou coisas santas?",
                "Descuidei da minha responsabilidade de aproximar os outros de Deus, com o meu exemplo e a minha palavra?",
            ])
        ]
    }
    
    // Verifica se uma pergunta já foi marcada como pecado
    func isQuestionMarkedAsSin(question: String) -> Bool {
        return savedSins.contains { $0.sinDescription == question }
    }
    
    // Marca uma pergunta como pecado
    func markAsSin(question: String) {
        let sinDescription = question
        if sinDataManager.createSin(commandments: "primeiro", sinDescription: sinDescription) != nil {
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
    var questions: [String]
}
