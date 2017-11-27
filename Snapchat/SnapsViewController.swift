//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Bruno Lopes de Mello on 26/11/2017.
//  Copyright © 2017 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController {

    
    @IBAction func sair(_ sender: Any) {
        let autenticacao = Auth.auth()

        do {
            try autenticacao.signOut()
            dismiss(animated: true, completion: nil)           
        } catch let erro {
            print("Nao foi possivel deslogar o usuario: \(erro.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
