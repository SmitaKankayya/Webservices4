//
//  ProductViewController.swift
//  Webservices4
//
//  Created by Smita Kankayya on 07/01/24.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    
    private let productTableViewCellIdentifier = "ProductTableViewCell"
    var productDetailsViewController : ProductDetailsViewController?

    
    var url : URL?
    var urlRequest1: URLRequest?
    
    var productTableViewCell : ProductTableViewCell?
    var products : [Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerXIBWithTV()
        initializeTableView()
        josonParsingProduct()
        
    }
    
    func registerXIBWithTV(){
        let uiNib = UINib(nibName:"ProductTableViewCell", bundle: nil)
        productTableView.self.register(uiNib, forCellReuseIdentifier: "ProductTableViewCell")
    }
    func initializeTableView(){
        productTableView.dataSource = self
        productTableView.delegate = self
    }
    
    func josonParsingProduct(){
        url = URL(string: "https://dummyjson.com/products")
        urlRequest1 = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: urlRequest1!) { data, response, error in
            
            let jsonDecoder = JSONDecoder()
            let productData = try! jsonDecoder.decode(ProuductData.self, from: data!)
            self.products = productData.products
            print(self.products)
            
            DispatchQueue.main.async{
                self.productTableView.reloadData()
            }
        }
        dataTask.resume()
    }
    
}
//MARK : UITableViewDataSource
extension ProductViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        productTableViewCell = self.productTableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell
        productTableViewCell?.titleLabel.text = products[indexPath.row].title
        productTableViewCell?.descriptionLabel.text = products[indexPath.row].description
        productTableViewCell?.ratingLabel.text = String(products[indexPath.row].rating)
        productTableViewCell?.priceLabel.text = String( products[indexPath.row].price)
        return productTableViewCell!
    }
}

//MARK : UITableViewDelegate
extension ProductViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController
        productDetailsViewController?.productContainer = products[indexPath.row]
        navigationController?.pushViewController(productDetailsViewController!, animated: true)
    }
}
