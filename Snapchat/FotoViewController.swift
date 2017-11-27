//
//  FotoViewController.swift
//  Snapchat
//
//  Created by Bruno Lopes de Mello on 26/11/2017.
//  Copyright © 2017 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import Firebase

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var proximoButton: UIButton!
    
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        self.proximoButton.isEnabled = false
        self.proximoButton.backgroundColor = UIColor.gray
    }
    
    @IBAction func selecionarFoto(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let imagemRecuperada = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imagem.image = imagemRecuperada.fixedOrientation()
        imagePicker.dismiss(animated: true, completion: nil)
        self.proximoButton.isEnabled = true
    }
    
    
    @IBAction func proximoPasso(_ sender: Any) {
        salvarImagem()
    }
    
    private func salvarImagem() {
        self.proximoButton.isEnabled = false
        self.proximoButton.setTitle("carregando...", for: .normal)
        
        let armazenamento = Storage.storage().reference()
        let imagens = armazenamento.child("imagens")
        
        if let  imageSelecionada = imagem.image {
            if  let imagemDados = UIImageJPEGRepresentation(imageSelecionada, 0.5) {
                imagens.child("imagem.jpg").putData(imagemDados, metadata: nil, completion: { (metaDados, erro) in
                    
                    if erro == nil {
                        self.proximoButton.isEnabled = true
                        self.proximoButton.setTitle("Próximo", for: .normal)
                        print("Sucesso ao fazer upload da imagem")
                        
                    } else {
                        print("Erro ao fazer o upload: \(String(describing: erro?.localizedDescription))")
                    }
                })
            }
            
        }
    }
    
    private func exibirAlerta(_ titulo: String,_ mensagem: String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        alerta.addAction(ok)
        self.present(alerta, animated: true, completion: nil)
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
