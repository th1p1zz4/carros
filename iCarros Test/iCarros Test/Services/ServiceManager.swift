//
//  ServiceManager.swift
//  iCarros Test
//
//  Created by Thiago Freitas Oliveira on 20/10/17.
//  Copyright © 2017 iCarros. All rights reserved.
//

import Foundation

// MARK: - Protocolo de callback

protocol ServiceManagerDelegate: class {
    func callbackSuccess(response : Response)
    func callbackError(response : Response)
}

// MARK: - Enum dos endpoints

enum Endpoint : String {
    case SEARCH = "https://paginasegura.icarros.com.br/rest/search/deals/est_SP.1-esc_3.1-%20mar_5.1-ami_2010.1/0/20/1"
    case IMAGES = "https://img0.icarros.com/dbimg/imgadicionalanuncio/2/"
}

// MARK: - Classe de chamada de serviço

class ServiceManager {
    var delegate : ServiceManagerDelegate?
    
    // MARK: - Chamada de serviço GET
    
    public func invokeGet(urlString : Endpoint) {
        guard let url = URL(string: urlString.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let resposta = Response(data: data,response: response,error: error)
            if error != nil {
                self.delegate?.callbackError(response: resposta)
            } else {
                self.delegate?.callbackSuccess(response: resposta)
            }
            }.resume()
    }
    
    // MARK: - chamada de serviço POST
    
    public func invokePost(urlString : Endpoint, parameters : Data) {
        guard let url       = URL(string: urlString.rawValue) else { return }
        var request         = URLRequest(url: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod  = "POST"
        request.httpBody = parameters
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            let resposta = Response(data: data,response: response,error: error)
            if error != nil {
                self?.delegate?.callbackError(response: resposta)
            } else {
                self?.delegate?.callbackSuccess(response: resposta)
            }
            }.resume()
    }
}
