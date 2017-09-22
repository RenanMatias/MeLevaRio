//
//  LugaresListTableViewController.swift
//  MeLevaRio
//
//  Created by Renan Matias on 16/08/17.
//  Copyright © 2017 Renan Matias. All rights reserved.
//

import UIKit
import MapKit

struct lugarViewDTO {
    var descricao = ""
    var latitude = 0.0
    var longitude = 0.0
    var mainImage = ""
    var nome = ""
    var images: [String]?
}

class LugaresListTableViewController: UITableViewController, LugaresDelegate, CLLocationManagerDelegate {

    //varRK: - Properties

    lazy var viewModel: LugaresViewModel = LugaresViewModel(delegate: self)
    let locationManager = CLLocationManager()
    var myLocation = CLLocationCoordinate2D()
    var refresher = UIRefreshControl()
    
    
    // MARK: - VC Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        refresher.addTarget(self, action: #selector(self.downloadLugares), for: UIControlEvents.valueChanged)
        tableView.addSubview(refresher)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let lastLocation = locations.last {
            myLocation = lastLocation.coordinate
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        downloadLugares()
    }

    func downloadLugares() {
        viewModel.downloadObjects()
        tableView.reloadData()
        refresher.endRefreshing()
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
        cell.fill(dto: dto, myLocation: myLocation)
        
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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "lugaresDetail" {
    
            if let indexPath = tableView.indexPathForSelectedRow, let detailController = segue.destination as? DetailViewController  {
                let dto = viewModel.getLugaresDTO(at: indexPath.row)
                detailController.dto = dto
            }
            
        }
        
    }

    // MARK: - Supporting
    
    func showAlert() {
        showNativeAlert(title: "Aviso",
                        message: "Erro de conexão",
                        afirmativeAction: "Tentar novamente",
                        negativeAction: "Cancelar") { action in
                            if action.title == "Tentar novamente" {
                                self.downloadLugares()
                            }
        }
    }
    
}
