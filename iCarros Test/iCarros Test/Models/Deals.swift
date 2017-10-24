//
//  Deals.swift
//  iCarros Test
//
//  Created by Thiago Freitas Oliveira on 20/10/17.
//  Copyright © 2017 iCarros. All rights reserved.
//

import Foundation

struct Deals : Codable {
    let anuncioSomenteTradein               : Bool?
    let anuncioSomentePF                    : Bool?
    let modelId                             : Int?
    let segment                             : String?
    let dealerId                            : Int?
    let trimId                              : Int?
    let modelYear                           : String?
    let trimDescription                     : String?
    let price                               : Double?
    let offerFinancing                      : Bool?
    let sellerPhoneNumber                   : String?
    let sellerCity                          : Int?
    let dealText                            : String?
    let dealId                              : Int?
    let makeId                              : Int?
    let conversionTag                       : String?
    let visualizationTag                    : String?
    let sellerUf                            : String?
    let dealerAddress                       : String?
    let manufacturingYear                   : String?
    let latitude                            : Double?
    let longitude                           : Double?
    let makeDescription                     : String?
    let modelDescription                    : String?
    let sellerType                          : Int?
    let sellerName                          : String?
    let regionalGroupId                     : Int?
    let sellerCityDescription               : String?
    let regionalGroupDealersCount           : Int?
    let colorDescription                    : String?
    let legalText                           : String?
    let equipmentsIds                       : [Int]?
    let equipments                          : [String]?
    let fuelDescription                     : String?
    let hasDealFeiraoEnabled                : Bool?
    let hasDealCallTrackingEnabled          : Bool?
    let hasLeadQualifierEnabled             : Bool?
    let sellerFR                            : Int?
    let mid                                 : String?
    let sellerCallTrackingPhoneNumber       : String?
    let gearDescription                     : String?
    let plateLastNumber                     : String?
    let cpfRequired                         : Bool?
    let isZeroKm                            : Bool?
    let regionalGroupHasSimulationEnabled   : Bool?
    let sellerPhoneNumbers                  : [String]?
    let sellerText                          : String?
    let images                              : [String]?
    let km                                  : Double?
    let distKm                              : Double?
    let dealerImageVersion                  : String?
    let makeImageVersion                    : String?
    let financingAvailable                  : Bool?
    let shareData                           : SharedData?
    let hasDealSimulationEnabled            : Bool?
    let phoneRequired                       : Bool?
}
