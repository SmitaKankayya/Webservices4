//
//  UserDetailsViewController.swift
//  Webservices4
//
//  Created by Smita Kankayya on 08/01/24.
//

import UIKit

class UserDetailsViewController: UIViewController {
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    var dataContainer : Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
      }
    
    func bindData(){
        self.firstName.text = dataContainer!.first_name
        self.lastName.text = dataContainer?.last_name
        self.email.text = dataContainer?.email
        avatarImage.sd_setImage(with: URL(string: dataContainer!.avatar))
    }

    

}
