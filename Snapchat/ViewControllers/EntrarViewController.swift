//
//  EntrarViewController.swift
//  Snapchat
//
//  Created by Bruno Lopes de Mello on 24/11/2017.
//  Copyright © 2017 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import Firebase

class EntrarViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var senhaField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
    
    private func logarUsuario(_ email: String?,_ senha: String?) {
        
        if let _email = email, let _senha = senha {
            Auth.auth().signIn(withEmail: _email, password: _senha) { (user, erro) in
                
                if erro == nil {
                    if user == nil {
                        let alerta = Alerta(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar a autenticacao, tente novamente!")
                        self.present(alerta.getAlerta(), animated: true, completion: nil)
                    } else {
                        self.performSegue(withIdentifier: "segueLogin", sender: nil)
                        
                    }
                } else {
                    let _erro = erro! as NSError
                    let mensagem: String!
                    
                    /*
                     ERROR_WRONG_PASSWORD
                     ERROR_INVALID_EMAIL
                     ERROR_USER_NOT_FOUND
                     */
                    
                    switch _erro.userInfo["error_name"] as! String {
                    case "ERROR_WRONG_PASSWORD":
                        mensagem = "Senha incorreta, tente outra senha!"
                        break
                        
                    case "ERROR_INVALID_EMAIL":
                        mensagem = "Email invalido, tente user um email valido!"
                        break
                        
                    case "ERROR_USER_NOT_FOUND":
                        mensagem = "Parece que esse email nao esta em nossa base da dados, tente outro email ou faça um novo cadastro!"
                        break
                        
                    default:
                        mensagem = "Algo errado aconteceu, tente novamente mais tarde!"
                    }
                    
                    let alerta = Alerta(titulo: "Erro", mensagem: mensagem)
                    self.present(alerta.getAlerta(), animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @IBAction func logarButton(_ sender: UIButton) {
        self.logarUsuario(emailField.text, senhaField.text)
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
