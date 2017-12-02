//
//  Usuario.swift
//  Snapchat
//
//  Created by Bruno Lopes de Mello on 02/12/2017.
//  Copyright © 2017 Bruno Lopes de Mello. All rights reserved.
//

import Foundation

class Usuario {
    var email: String
    var nome: String
    var uid: String
    
    init(email: String, nome: String, uid: String) {
        self.email = email
        self.nome = nome
        self.uid = uid
    }
}
