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
        
        self.verificaSeUsuarioEstaConectado()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func verificaSeUsuarioEstaConectado() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                //user not conected
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "TelaInicial")
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromRight
                self.view.window!.layer.add(transition, forKey: kCATransition)
                self.present(controller, animated: false, completion: nil)
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

