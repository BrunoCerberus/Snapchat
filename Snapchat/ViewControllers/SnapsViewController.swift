//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Bruno Lopes de Mello on 26/11/2017.
//  Copyright © 2017 Bruno Lopes de Mello. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var snaps: [Snap] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func sair(_ sender: Any) {
        let autenticacao = Auth.auth()

        do {
            try autenticacao.signOut()
            dismiss(animated: true, completion: nil)
        } catch let erro {
            print("Nao foi possivel deslogar o usuario: \(erro.localizedDescription)")
        }
    }
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let autenticacao = Auth.auth()
        
        if let idUsuarioLogado = autenticacao.currentUser?.uid {
            
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            let snaps = usuarios.child(idUsuarioLogado).child("snaps")
            
            //criar ouvinte
            snaps.observe(DataEventType.childAdded, with: { (snapshot) in
                let dados = snapshot.value as? NSDictionary
                
                let snap = Snap()
                snap.identificador = snapshot.key
                snap.nome = dados!["nome"] as! String
                snap.de = dados!["de"] as! String
                snap.descricao = dados!["descricao"] as! String
                snap.urlImagem = dados!["urlImagem"] as! String
                snap.idImagem = dados!["idImagem"] as! String
                self.snaps.append(snap)
                self.tableView.reloadData()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let totalSnaps = self.snaps.count
        if totalSnaps == 0 {
            return 1
        }
        return totalSnaps
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        
        let totalSnaps = self.snaps.count
        if totalSnaps == 0 {
            cell.textLabel?.text = "Nenhum snap para voce :)"
        } else {
            cell.textLabel?.text = self.snaps[indexPath.row].nome
            return cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let totalSnaps = self.snaps.count
        if totalSnaps != 0 {
            self.performSegue(withIdentifier: "segueDetalhesSnap", sender: self.snaps[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetalhesSnap" {
            let controllerDestino = segue.destination as! DetalhesSnapViewController
            controllerDestino.snap = sender as! Snap
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
