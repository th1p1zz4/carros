//
//  FilterType.swift
//  iCarros Test
//
//  Created by Thiago Freitas Oliveira on 20/10/17.
//  Copyright © 2017 iCarros. All rights reserved.
//

import Foundation

struct FilterType : Codable {
    let id                  : String?
    let filterType          : String?
    let name                : String?
    let namePlural          : String?
    let genre               : String?
    let presentationModel   : Int?
    let parameters          : String?
}
