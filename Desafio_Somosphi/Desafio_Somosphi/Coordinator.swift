//
//  Coordinator.swift
//  Desafio_Somosphi
//
//  Created by Suh on 04/08/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
