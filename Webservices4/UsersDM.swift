//
//  UsersDM.swift
//  Webservices4
//
//  Created by Smita Kankayya on 07/01/24.
//

import Foundation


struct Users : Decodable{
    var data : [Data]
}

struct Data : Decodable{
    var first_name : String
    var last_name : String
    var email : String
    var avatar : String
}

struct ProuductData : Decodable{
    let products : [Product]
}
struct Product : Decodable{
    var title : String
    var description : String
    var rating : Double
    var price : Int
}
