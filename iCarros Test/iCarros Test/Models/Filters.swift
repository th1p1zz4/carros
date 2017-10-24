//
//  Filters.swift
//  iCarros Test
//
//  Created by Thiago Freitas Oliveira on 20/10/17.
//  Copyright © 2017 iCarros. All rights reserved.
//

import Foundation

struct Filters : Codable {
    let filterGroups        : String?
    let filterType          : FilterType?
    let selected            : Bool?
    let minValue            : Double?
    let maxValue            : Double?
    let minValueSelected    : Double?
    let maxValueSelected    : Double?
    let filterOptions       : [FilterOptions]?
}
