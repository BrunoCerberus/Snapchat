//
//  CriarViewController.swift
//  Snapchat
//
//  Created by Bruno Lopes de Mello on 24/11/2017.
//  Copyright © 2017 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import Firebase

class CriarViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var senhaField: UITextField!
    @IBOutlet weak var confirmarSenhaField: UITextField!
    @IBOutlet weak var nomeCompleto: UITextField!
    
    //variaveis
    var cadastradoComSucesso: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    @IBAction func criarContaButton(_ sender: Any) {
        criarContaUsuario(emailField.text, senhaField.text, confirmarSenhaField.text, nomeCompleto.text)
    }
    
    private func criarContaUsuario(_ email: String?,_ password: String?,_ confirmPassword: String?,_ nomeCompleto: String?) {
        
        if confirmaSenha(password, confirmPassword) {
            if let _password = password, let _email = email, let _nomeCompleto = nomeCompleto {
                
                Auth.auth().createUser(withEmail: _email, password: _password) { (user, erro) in
                    
                    if erro == nil {
                        
                        if user == nil {
                            self.exibirAlerta("Erro ao autenticar", "Problema ao realizar a autenticaçao, tente novamente mais tarde")
                        } else {
                            
                            self.cadastradoComSucesso = true
                            self.exibirAlerta("Sucesso", "Usuário criado com sucesso, agora basta apenas logar :)")
                        }
                        
                        
                    } else {
//                        self.exibirAlerta("Erro", "Nao foi possivel criar o usario no momento, por favor tente mais tarde!")
                        
                        /*
                         ERROR_INVALID_EMAIL
                         ERROR_WEAK_PASSWORD
                         ERROR_EMAIL_ALREADY_IN_USE
                         */
                        
                        let _erro = erro! as NSError
                        var mensagem: String!
                        switch _erro.userInfo["error_name"] as! String{
                            
                        case "ERROR_INVALID_EMAIL":
                            mensagem = "Digite um email valido!"
                            break
                            
                        case "ERROR_WEAK_PASSWORD":
                            mensagem = "Senha muito fraca, digite uma senha mais forte!"
                            break
                            
                        case "ERROR_EMAIL_ALREADY_IN_USE":
                            mensagem = "Esse email ja foi usado para um cadastro, use outro email!"
                            break
                            
                        default:
                            mensagem = "Algo deu errado, tente novamente mais tarde!"
                            
                        }
                        self.exibirAlerta("Erro", mensagem)
                    }
                }
            }
        } else {
            exibirAlerta("Senhas Diferentes", "Verifique se as senhas estao exatamente iguais!")
        }
        
        
        
    }
    
    private func confirmaSenha(_ password: String?,_ confirmPassword: String?) -> Bool {
        if let _senha = password, let _confirmaSenha = confirmPassword {
            
            if _senha == _confirmaSenha {
                return true
            }
            
            return false
        }
        return false
    }
    
    private func exibirAlerta(_ titulo: String,_ mensagem: String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (action) in
            self.verificaSeFoiCadastrado()
        }
        
        alerta.addAction(ok)
        self.present(alerta, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func verificaSeFoiCadastrado() {
        if self.cadastradoComSucesso {
            self.performSegue(withIdentifier: "segueCadastroLogin", sender: self)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
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
