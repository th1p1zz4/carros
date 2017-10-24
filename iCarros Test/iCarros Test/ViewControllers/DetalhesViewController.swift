//
//  DetalhesViewController.swift
//  iCarros Test
//
//  Created by Thiago Freitas Oliveira on 22/10/17.
//  Copyright © 2017 iCarros. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var marcaAnoModelo: UILabel!
    @IBOutlet weak var trimDescription: UILabel!
    @IBOutlet weak var labelKm: UILabel!
    @IBOutlet weak var labelCombustivel: UILabel!
    @IBOutlet weak var labelCor: UILabel!
    @IBOutlet weak var labelFinalPlaca: UILabel!
    @IBOutlet weak var labelPreco: UILabel!
    @IBOutlet weak var textAreaOpcionais: UITextView!
    @IBOutlet weak var textAreaSobreVeiculo: UITextView!
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldTelefone: UITextField!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var superView: UIView!
    
    //MARK: - Variables
    let carList = App.shared.listaDeCarros
    var carIndex = App.shared.carIndex
    var imageLista : [String] = []
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurePageControl()
        self.configureTextView()
        self.loadImages()
        self.loadValues()
        self.imageScrollView.delegate = self
        self.superView.layer.cornerRadius = 8
    }
    //MARK: - Methods
    func configurePageControl() {
        guard let carroResponse = carList[carIndex].carroResponse,
            let images = carroResponse.images else {
                return
        }
        self.pageController.numberOfPages = images.count
        self.pageController.currentPage = 0
        self.pageController.currentPageIndicatorTintColor = UIColor(red: 34 / 255, green: 98 / 255, blue: 204 / 255, alpha: 1)
        self.pageController.pageIndicatorTintColor = UIColor.gray
        self.pageController.addTarget(self, action: Selector(("changePage:")), for: UIControlEvents.valueChanged)
    }
    
    func loadImages(){
        var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
        guard let carroResponse = carList[carIndex].carroResponse,
            let images = carroResponse.images else {
                return
        }
        for (i, imageId) in images.enumerated() {
            DispatchQueue.main.async {
                frame.origin.x = self.imageScrollView.frame.size.width * CGFloat(i)
                frame.size = self.imageScrollView.frame.size
                let imageView = UIImageView(frame: frame)
                let link = "\(Endpoint.IMAGES.rawValue)\(imageId)"
                imageView.downloadedFrom(link: link)
                imageView.contentMode = .scaleAspectFill
                self.imageScrollView.addSubview(imageView)
            }
        }
        
        self.imageScrollView.contentSize = CGSize(width: self.imageScrollView.frame.size.width * CGFloat(images.count), height: self.imageScrollView.frame.size.height)
    }
    
    func loadValues(){
        self.textAreaOpcionais.text = ""
        self.textAreaSobreVeiculo.text = ""
        guard let carroResponse = carList[carIndex].carroResponse,
            let trimDescription = carroResponse.trimDescription,
            let km = carroResponse.km,
            let combustivel = carroResponse.fuelDescription,
            let cor = carroResponse.colorDescription,
            let placa = carroResponse.plateLastNumber,
            let opcionais = carroResponse.equipments,
            let dealText = carroResponse.dealText
        else {
                return
        }
        
        let car = carList[carIndex]
        
        self.marcaAnoModelo.text = car.marcaModeloAno.uppercased()
        self.trimDescription.text = trimDescription.uppercased()
        let kilometers = NSNumber.init(value: km)
        self.labelKm.text = kilometers.formatNumber()
        self.labelCor.text = cor.capitalized
        self.labelFinalPlaca.text = placa
        let price = NSNumber.init(value: car.preco)
        self.labelPreco.text = String(price.format())
        self.labelCombustivel.text = combustivel.capitalized
        self.textAreaSobreVeiculo.text = dealText
        for texto in opcionais {
            let trimTexto = texto.trimmingCharacters(in: .whitespaces).capitalized
            let textoAnterior = self.textAreaOpcionais.text ?? ""
            if texto == opcionais.last {
                self.textAreaOpcionais.text = "\(textoAnterior)\(trimTexto)"
            } else {
                self.textAreaOpcionais.text = "\(textoAnterior)\(trimTexto)\n"
            }
        }
        let conteudo = self.textAreaOpcionais.text ?? ""
        self.textAreaOpcionais.text = (conteudo != "") ? conteudo : "Não há opcionais :("
        let descritivo = self.textAreaSobreVeiculo.text ?? ""
        self.textAreaSobreVeiculo.text = (descritivo != "") ? descritivo : "N/A"
        self.textFieldNome.text = car.nomeAnunciante.capitalized
        self.textFieldTelefone.text = car.foneAnunciante
    }
    
    func configureTextView(){
        self.textAreaOpcionais.layer.borderWidth = 1
        self.textAreaOpcionais.layer.borderColor        = UIColor(red: 200 / 255.0,
                                                          green: 200 / 255.0,
                                                          blue: 200 / 255.0,
                                                          alpha: 0.5).cgColor
        self.textAreaSobreVeiculo.layer.borderWidth = 1
        self.textAreaSobreVeiculo.layer.borderColor        = UIColor(red: 200 / 255.0,
                                                                  green: 200 / 255.0,
                                                                  blue: 200 / 255.0,
                                                                  alpha: 0.5).cgColor
        
    }
    
}

extension DetalhesViewController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(imageScrollView.contentOffset.x / scrollView.frame.size.width)
        pageController.currentPage = Int(pageNumber)
    }
}

extension DetalhesViewController {
    // MARK: Delegate Page View Controller quando o valor mudar
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageController.currentPage) * imageScrollView.frame.size.width
        imageScrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
}
