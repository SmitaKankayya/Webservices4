//
//  ProductDetailsViewController.swift
//  Webservices4
//
//  Created by Smita Kankayya on 08/01/24.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionPDLabel: UILabel!
    @IBOutlet weak var ratingPDLabel: UILabel!
    @IBOutlet weak var pricePDLabel: UILabel!
    
    var productContainer : Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    func bindData(){
        self.titleLabel.text = productContainer?.title
        self.descriptionPDLabel.text = productContainer?.description
        self.ratingPDLabel.text = "\(productContainer?.rating ?? 0.0)"
        self.pricePDLabel.text = "\(productContainer?.price ?? 0)"
    }
   

}
