//
//  FileManagerPersistence.swift
//  desafio-ios-phi
//
//  Created by Lidiane Gomes Barbosa on 11/05/21.
//

import UIKit

class FileManagerPersistence {
    
    static let shared = FileManagerPersistence()
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveImage(image: UIImage, imageName: String) {
        if let data = image.pngData() {
            let filename = getDocumentsDirectory().appendingPathComponent(imageName)
            try? data.write(to: filename)
        }
    }
    
    func getFileURL(fileName: String) -> URL? {
        if fileExists(fileName: fileName) {
            return getDocumentsDirectory().appendingPathComponent(fileName)
        }
        return nil
    }
    
    func fileExists(fileName: String) -> Bool {
        let filename = getDocumentsDirectory().appendingPathComponent(fileName)
        return FileManager.default.fileExists(atPath: filename.path)
    }
}
