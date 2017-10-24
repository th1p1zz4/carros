//
//  ViewController.swift
//  iCarros Test
//
//  Created by Thiago Freitas Oliveira on 20/10/17.
//  Copyright © 2017 iCarros. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Variables
    var service = ServiceManager()
    //MARK: - Outlets
    @IBOutlet weak var carrosTableView: UITableView!
    @IBOutlet weak var spin: UIActivityIndicatorView!
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.service.delegate = self
        self.carrosTableView.dataSource = self
        self.carrosTableView.delegate = self
        self.callService()
    }

    //MARK: - Methods
    func createAlert(message : String){
        let title = "Erro"
        let message = message
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        let actionTitle = "Tentar Novamente"
        let ok = UIAlertAction(title: actionTitle, style: .default, handler: { [weak self] (alert : UIAlertAction!) in
            self?.callService()
        })
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func callService(){
        self.start()
        service.invokeGet(urlString: .SEARCH)
    }
    
    func start(){
        DispatchQueue.main.async { [weak self] in
            self?.spin.hidesWhenStopped = true
            self?.spin.startAnimating()
        }
    }
    
    func stop(){
        DispatchQueue.main.async { [weak self] in
            self?.spin.stopAnimating()
        }
    }
}

extension ViewController : ServiceManagerDelegate {
    // MARK: - Callback da service
    func callbackSuccess(response: Response) {
        self.stop()
        guard let data = response.data,
            let carros = try? iCarrosResponse.decode(data: data),
            let deals  = carros.deals
        else {
                DispatchQueue.main.async { [weak self] in
                    self?.createAlert(message: String(data: response.data!, encoding: .utf8)!)
                }
                return
        }
        
        // Guarda response no Singleton para nao chamar de novo o serviço
        App.shared.icarrosResponse = carros
        
        //Desempacota os valores para exibir na lista
        for deal in deals {
            if let marca = deal.makeDescription,
                let modelo = deal.modelDescription,
                let ano = deal.modelYear,
                let preco = deal.price,
                let nomeAnunciante = deal.sellerName,
                let foneAnunciante = deal.sellerPhoneNumber,
                let imagens = deal.images {
                let carro = CarroPreview(marcaModeloAno: "\(marca) \(modelo) \(ano)", imagem: imagens[0], preco: preco, nomeAnunciante: nomeAnunciante, foneAnunciante: foneAnunciante, carroResponse: deal)
                
                App.shared.listaDeCarros.append(carro)
                DispatchQueue.main.async { [weak self] in
                    self?.carrosTableView.reloadData()
                }
            }
        }
    }
    
    func callbackError(response: Response) {
        self.stop()
        self.createAlert(message: "Infelizmente não foi possível carregar os carros, vamos tentar novamente?")
        print(response)
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return App.shared.listaDeCarros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Desempacotando a célula e o response
        guard let cell = carrosTableView.dequeueReusableCell(withIdentifier: "Carro") as? CarroTableViewCell
        else {
             return UITableViewCell()
        }
        
        // Desempacotando o conteúdo a ser exibido na tela
        let itemAtual = App.shared.listaDeCarros[indexPath.row]
        let price = NSNumber.init(value: itemAtual.preco)
        
        cell.marcaAnoModelo.text = itemAtual.marcaModeloAno.uppercased()
        cell.nomeDoAnunciante.text = itemAtual.nomeAnunciante.capitalized
        cell.precoDoCarro.text = "\(price.format())"
        cell.telefoneDoAnunciante.text = itemAtual.foneAnunciante
        cell.imagemDoCarro.downloadedFrom(link: "\(Endpoint.IMAGES.rawValue)\(itemAtual.imagem)")
        cell.imagemDoCarro.contentMode = .scaleAspectFill
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        App.shared.carIndex = indexPath.row
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "Detalhes") else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
