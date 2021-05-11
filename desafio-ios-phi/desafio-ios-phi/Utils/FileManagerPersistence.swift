//
//  FileManager.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes Barbosa on 11/05/21.
//

import UIKit

class FileManagerPersistence {
    
    let shared = FileManagerPersistence()
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveImage(image: UIImage, imageName: String) {
        if let data = image.pngData() {
            let filename = getDocumentsDirectory().appendingPathComponent(imageName)
            try? data.write(to: filename)
        }
    }
    
    func loadImage() {
        
    }
}
