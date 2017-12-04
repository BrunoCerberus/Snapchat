//
//  DetalhesSnapViewController.swift
//  Snapchat
//
//  Created by Bruno Lopes de Mello on 03/12/2017.
//  Copyright © 2017 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import SDWebImage

class DetalhesSnapViewController: UIViewController {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var timer: UILabel!
    
    
    var snap: Snap!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descricao.text = self.snap.descricao
        let url = URL(string: self.snap.urlImagem)
        self.imagem.sd_setImage(with: url) { (image, erro, cache, url) in
            
            if erro == nil {
                print("imagem exibida")
            }
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
