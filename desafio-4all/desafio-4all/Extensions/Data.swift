//
//  Data.swift
//  desafio-4all
//
//  Created by Vitor Demenighi on 03/01/21.
//

import Foundation

extension Data {
    
    func getURL() -> Result<URL, CustomError> {
        let temporaryFolder = FileManager.default.temporaryDirectory
        let fileName = "Phi App.pdf"
        let temporaryFileURL = temporaryFolder.appendingPathComponent(fileName)
        
        do {
            try self.write(to: temporaryFileURL)
            return .success(temporaryFileURL)
        } catch {
            return .failure(CustomError.writeFileError)
        }
    }
}
