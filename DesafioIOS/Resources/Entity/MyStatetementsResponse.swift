//
//  MyStatementResponse.swift
//  DesafioIOS
//
//

import Foundation



struct MyStatetementsResponse : Codable{
    let items : [MyStatetmentResponse]
}

struct MyStatetmentResponse : Codable{
    let id : String
    let createdAt : String
    let tType : String
    let amount : Double
    let to : String?
    let bankName : String?
    let description : String
}

