//
//  LugaresListTableViewController.swift
//  MeLevaRio
//
//  Created by Renan Matias on 16/08/17.
//  Copyright © 2017 Renan Matias. All rights reserved.
//

import UIKit

struct lugarViewDTO {
    var descricao = ""
    var latitude = 0
    var longitude = 0
    var mainImage = ""
    var nome = ""
    var images: [String]?
}

class LugaresListTableViewController: UITableViewController, LugaresDelegate {

    // MARK: - Properties

    lazy var viewModel: LugaresViewModel = LugaresViewModel(delegate: self)
    
    // MARK: - VC Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadLugares()
    }

    func downloadLugares() {
        viewModel.downloadObjects()
    }


    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.numberOfLugares
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LugarTableViewCell.self), for: indexPath) as! LugarTableViewCell

        // Configure the cell...
        let dto = viewModel.getLugaresDTO(at: indexPath.row)
        cell.fill(dto: dto)
        
        return cell
    }
    
    // Change cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145.0
    }

    func updateInterface(success: Bool) {
        
        // Atualização de Interface
        DispatchQueue.main.async {
            
            if success {
                self.tableView.reloadData()
            } else {
                self.showAlert()
            }
            
        }
        
    }
    
    func showAlert() {
        showNativeAlert(title: "Aviso",
                        message: "Erro de conexão",
                        afirmativeAction: "Tentar novamente",
                        negativeAction: "Cancelar") { action in
                            if action.title == "Tentar novamente" {
                                self.downloadLugares()
                            } else if action.title == "Cancelar" {
                                // code
                            }
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
