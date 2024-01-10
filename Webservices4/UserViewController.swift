//
//  UserViewController.swift
//  Webservices4
//
//  Created by Smita Kankayya on 07/01/24.
//

import UIKit
import SDWebImage

class UserViewController: UIViewController {
    
    @IBOutlet weak var userCollectionView: UICollectionView!
    
    private let userCollectionViewCellIdentifier = "UserCollectionViewCell"
    var userDetailsViewController : UserDetailsViewController?

    
    var url : URL?
    var urlRequest : URLRequest?
    
    var userCollectionViewCell : UserCollectionViewCell?
    var user = Users(data: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeCollectionView()
        registerXIBWithCV()
        jsonParsingUsingDecoder()
        
        func registerXIBWithCV(){
            let uiNib = UINib(nibName: userCollectionViewCellIdentifier, bundle: nil)
            userCollectionView.self.register(uiNib, forCellWithReuseIdentifier: userCollectionViewCellIdentifier)
            
        }
        
        func initializeCollectionView(){
            userCollectionView.dataSource = self
            userCollectionView.delegate = self
            
        }
        
        func jsonParsingUsingDecoder(){
            url = URL(string: "https://reqres.in/api/users?page=2")
            urlRequest = URLRequest(url: url!)
            let dataTask = URLSession.shared.dataTask(with: urlRequest!) { data, response, error in
                
                let jsonDecoder = JSONDecoder()
                self.user = try! jsonDecoder.decode(Users.self, from: data!)
                print(self.user)
                
                DispatchQueue.main.async{
                    self.userCollectionView.reloadData()
                }
            }
            dataTask.resume()
        }
        
    }

}
    
//MARK : UICollectionViewDataSource
extension UserViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        user.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        userCollectionViewCell = self.userCollectionView.dequeueReusableCell(withReuseIdentifier: userCollectionViewCellIdentifier, for: indexPath) as? UserCollectionViewCell
        userCollectionViewCell?.firstNameLabel.text = String(user.data[indexPath.row].first_name)
        userCollectionViewCell?.lastNameLabel.text = user.data[indexPath.row].last_name
        userCollectionViewCell?.emailLabel.text = user.data[indexPath.row].email
        userCollectionViewCell?.avatarImage.sd_setImage(with: URL(string: user.data[indexPath.row].avatar))
        return userCollectionViewCell!
    }
    
}

//MARK : UICollectionViewDelegate
extension UserViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController") as? UserDetailsViewController
        userDetailsViewController?.dataContainer = user.data[indexPath.row]
        navigationController?.pushViewController(userDetailsViewController!, animated: true)
    }
}
//MARK : UICollectionViewDelegateFlowLayout
extension UserViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 220)
        
    }
}



    


