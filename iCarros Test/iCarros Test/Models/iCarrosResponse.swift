//
//  iCarrosResponse.swift
//  iCarros Test
//
//  Created by Thiago Freitas Oliveira on 20/10/17.
//  Copyright © 2017 iCarros. All rights reserved.
//

import Foundation

// MARK: - Resposta do Serviço iCarros

struct iCarrosResponse : Codable {
    let numResults      : Int?
    let deals           : [Deals]?
    let filters         : [Filters]?
    let searchSummary   : String?
    let searchOptions   : String?
}
