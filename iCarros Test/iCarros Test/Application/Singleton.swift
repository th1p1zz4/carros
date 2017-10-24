//
//  Singleton.swift
//  iCarros Test
//
//  Created by Thiago Freitas Oliveira on 21/10/17.
//  Copyright © 2017 iCarros. All rights reserved.
//

import Foundation

class App {
    
    static let shared = App()
    // MARK: - Propriedades
    var icarrosResponse : iCarrosResponse?
    var listaDeCarros : [CarroPreview] = []
    var carIndex = 0
    
}

