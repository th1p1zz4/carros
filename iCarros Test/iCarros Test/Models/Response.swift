//
//  Response.swift
//  iCarros Test
//
//  Created by Thiago Freitas Oliveira on 20/10/17.
//  Copyright © 2017 iCarros. All rights reserved.
//

import Foundation

// MARK: - URLSession Response Object

struct Response {
    let data        : Data?
    let response    : URLResponse?
    let error       : Error?
}
