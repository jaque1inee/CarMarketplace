//
//  CarTableViewCell.swift
//  CarMarketplace
//
//  Created by Jaqueline Oliveira on 14/11/22.
//

import UIKit

protocol CarTableViewCellDelegate: AnyObject {
    
    func didAddPressed(modelo: String)
}

class CarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var modeloCarLabel: UILabel!
    @IBOutlet weak var marcaCarLabel: UILabel!
    @IBOutlet weak var corCarLabel: UILabel!
    @IBOutlet weak var valorCarLabel: UILabel!
    @IBOutlet weak var imageCarView: UIImageView!
    @IBOutlet weak var addCarButton: UIButton!
    
    weak var delegate: CarTableViewCellDelegate?
    
    func setup(result: ListCar) {
        modeloCarLabel.text = result.nome_modelo
        marcaCarLabel.text = result.marca_nome
        corCarLabel.text = result.cor
        valorCarLabel.text = "R$\(result.valor_fipe ?? 0)"
    }
    
    @IBAction func didAddPressed(_ sender: Any) {
        
        self.delegate?.didAddPressed(modelo: modeloCarLabel.text ?? "")
    }
}
