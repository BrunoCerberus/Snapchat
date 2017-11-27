//
//  ViewController.swift
//  Snapchat
//
//  Created by Bruno Lopes de Mello on 21/11/2017.
//  Copyright © 2017 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let autenticacao = Auth.auth()
        
        do {
            try autenticacao.signOut()
        } catch let erro {
            print("Erro: \(erro.localizedDescription)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.verificaSeUsuarioEstaConectado()
    }
    
    private func verificaSeUsuarioEstaConectado() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if user == nil {
                //user not conected
                print("Usuario nao existe")
            } else {
                self.performSegue(withIdentifier: "segueLoginAutomatico", sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }


}

