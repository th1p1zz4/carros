//
//  CarroTableViewCell.swift
//  iCarros Test
//
//  Created by Thiago Freitas Oliveira on 21/10/17.
//  Copyright © 2017 iCarros. All rights reserved.
//

import UIKit

class CarroTableViewCell: UITableViewCell {

    @IBOutlet weak var marcaAnoModelo       : UILabel!
    @IBOutlet weak var imagemDoCarro        : UIImageView!
    @IBOutlet weak var precoDoCarro         : UILabel!
    @IBOutlet weak var nomeDoAnunciante     : UILabel!
    @IBOutlet weak var telefoneDoAnunciante : UILabel!
    @IBOutlet weak var whiteView            : UIView!
    @IBOutlet weak var contentImage         : UIView!
    
    override func awakeFromNib() {
        // Configurando layout da view branca da célula
        self.whiteView.layer.borderColor        = UIColor(red: 200 / 255.0,
                                                          green: 200 / 255.0,
                                                          blue: 200 / 255.0,
                                                          alpha: 0.5).cgColor
        self.whiteView.layer.borderWidth        = 1.0
        self.whiteView.layer.cornerRadius       = 0.0
        // Configurando layout da view que contempla a imagem do carro
        self.contentImage.layer.cornerRadius    = 4.0
    }
}
