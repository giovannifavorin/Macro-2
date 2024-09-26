//
//  LiturgiaDiariaAPI.swift
//  Macro02
//
//  Created by Thiago Pereira de Menezes on 25/09/24.
//

import Foundation

// Modelo de dados que representará a resposta da API
struct Liturgia: Decodable {
    let data: String?
    let liturgia: String?
    let cor: String?
    let dia: String?
    let oferendas: String?
    let comunhao: String?
    let primeiraLeitura: Leitura?
    let segundaLeitura: String?
    let salmo: Salmo?
    let evangelho: Leitura?
    let antifonas: Antifonas?
    
    struct Leitura: Decodable {
        let referencia: String?
        let titulo: String?
        let texto: String?
    }
    
    struct Salmo: Decodable {
        let referencia: String?
        let refrao: String?
        let texto: String?
    }
    
    struct Antifonas: Decodable {
        let entrada: String?
        let ofertorio: String?
        let comunhao: String?
    }
}

class LiturgiaDiariaAPI {
    
    // Função que faz a requisição para a API
    func fetchLiturgia(completion: @escaping (Result<Liturgia, Error>) -> Void) {
        guard let url = URL(string: "https://liturgiadiaria.site") else {
            print("URL inválida")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Erro ao fazer a requisição: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("Dados não recebidos")
                return
            }

            // Imprimir a resposta bruta
            if let responseString = String(data: data, encoding: .utf8) {
                print("Resposta da API: \(responseString)")
            }
            
            // Verificar o código de resposta HTTP
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("Erro na resposta da API: \(httpResponse.statusCode)")
                    return
                }
            }

            // Tenta converter os dados recebidos para JSON e imprimir
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Resposta JSON da API: \(json)")
                } else {
                    print("A resposta não é um dicionário JSON.")
                }
            } catch {
                print("Erro ao converter para JSON: \(error.localizedDescription)")
            }

            do {
                let decoder = JSONDecoder()
                let liturgia = try decoder.decode(Liturgia.self, from: data)
                completion(.success(liturgia))
            } catch {
                print("Erro ao decodificar dados: \(error)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
