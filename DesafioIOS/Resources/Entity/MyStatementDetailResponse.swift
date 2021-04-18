//
//  MyStatementDetailResponse.swift
//  DesafioIOS
//
//

import Foundation

struct MyStatetementDetailResponse : Codable{
    let id : String
    let authentication : String
    let tType : String
    let createdAt : String
    let amount : Double
    let to : String
    let description : String
}
