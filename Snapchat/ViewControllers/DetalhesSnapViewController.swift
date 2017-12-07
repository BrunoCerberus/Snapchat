//
//  DetalhesSnapViewController.swift
//  Snapchat
//
//  Created by Bruno Lopes de Mello on 03/12/2017.
//  Copyright © 2017 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class DetalhesSnapViewController: UIViewController {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var timer: UILabel!
    
    
    var snap: Snap!
    var tempo = 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descricao.text = "Carregando..."
        let url = URL(string: self.snap.urlImagem)
        self.imagem.sd_setImage(with: url) { (image, erro, cache, url) in
            
            if erro == nil {
                
                self.descricao.text = self.snap.descricao
                
                //Inicializar o Timer
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                    //decrementar o timer
                    self.tempo -= 1
                    
                    //Exibir timer na tela
                    self.timer.text = String(self.tempo)
                    
                    //caso o timer execute até o zero, invalida
                    if self.tempo == 0 {
                        timer.invalidate()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let autenticacao = Auth.auth()
        
        if let idUsuarioLogado = autenticacao.currentUser?.uid {
            
            //remover nó do database
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            
            let snaps = usuarios.child(idUsuarioLogado).child("snaps")
            
            snaps.child(snap.identificador).removeValue()
            
            //remover a imagem do snap
            let storage = Storage.storage().reference()
            let imagens = storage.child("imagens")
            
            
            imagens.child("\(snap.idImagem).jpg").delete(completion: { (erro) in
                if erro == nil {
                    print("Sucesso ao excluir a imagem")
                } else {
                    print("Erro ao excluir a imagem")
                }
            })
        }
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
