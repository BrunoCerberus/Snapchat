//
//  Alerta.swift
//  Snapchat
//
//  Created by Bruno Lopes de Mello on 27/11/2017.
//  Copyright © 2017 Bruno Lopes de Mello. All rights reserved.
//

import Foundation
import UIKit

class Alerta {
    var titulo: String
    var mensagem: String
    
    init(titulo: String, mensagem: String) {
        self.titulo = titulo
        self.mensagem = mensagem
    }
    
    func getAlerta() -> UIAlertController {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alerta.addAction(ok)
        return alerta
    }
}
