//
//  ListCarModel.swift
//  CarMarketplace
//
//  Created by Jaqueline Oliveira on 14/11/22.
//

import Foundation

struct ListCar: Codable {
    
    var id: Int?
    var marca_id: Int?
    var marca_nome: String?
    var nome_modelo: String?
    var ano: Int?
    var combustivel: String?
    var num_portas: Int?
    var valor_fipe: Double?
    var cor: String?
    
    private enum CodingKeys: String, CodingKey {
        
        case id, marca_id, marca_nome, nome_modelo, ano, combustivel, num_portas, valor_fipe, cor
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        marca_id = try container.decode(Int.self, forKey: .marca_id)
        marca_nome = try container.decode(String.self, forKey: .marca_nome)
        nome_modelo = try container.decode(String.self, forKey: .nome_modelo)
        combustivel = try container.decode(String.self, forKey: .combustivel)
        num_portas = try container.decode(Int.self, forKey: .num_portas)
        cor = try container.decode(String.self, forKey: .cor)
        
        if let anoData = try? container.decode(Int.self, forKey: .ano) {
            ano = anoData
        } else {
            let anoData = try container.decode(String.self, forKey: .ano)
            ano = Int(anoData)
        }
        
        if let fipeData = try? container.decode(Double.self, forKey: .valor_fipe) {
            valor_fipe = fipeData
        }
        else if let fipeData = try? container.decode(Int.self, forKey: .valor_fipe) {
            valor_fipe = Double(fipeData)
        } else {
            let fipeData = try container.decode(String.self, forKey: .valor_fipe)
            valor_fipe = Double(fipeData)
        }
    }
}
