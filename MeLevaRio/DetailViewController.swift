//
//  DetailViewController.swift
//  MeLevaRio
//
//  Created by Renan Matias on 02/09/17.
//  Copyright © 2017 Renan Matias. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var sliderScrollView: UIScrollView!
    @IBOutlet weak var detailPageControl: UIPageControl!
    @IBOutlet weak var descricaoTextView: UITextView!
    
    // MARK: - Properties
    var dto = lugarViewDTO()

    // MARK: - Circle Life
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sliderScrollView.isPagingEnabled = true
        sliderScrollView.delegate = self
        
        fill(dto: dto)
        
    }
    
    // MARK: - DTO
    
    func fill(dto: lugarViewDTO) {
        
        DispatchQueue.main.async {
        
            self.descricaoTextView.text = dto.descricao
            self.title = dto.nome
            
            if let imagesUrls = dto.images {
                
                self.sliderScrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(imagesUrls.count), height: 259)
                self.sliderScrollView.showsHorizontalScrollIndicator = false
                self.detailPageControl.numberOfPages = imagesUrls.count
                
                for (index, imageUrl) in imagesUrls.enumerated() {
                    
                    if let imageView = Bundle.main.loadNibNamed("ImageView", owner: self, options: nil)?.first as? ImageView {
                        
                        imageView.pictureImageView.downloadImage(with: imageUrl)
                        self.sliderScrollView.addSubview(imageView)
                        imageView.frame.size.width = self.view.bounds.size.width
                        imageView.frame.origin.x = CGFloat(index) * self.view.bounds.width
                    }
                    
                }
                
            }

        }
        
    }
    
    // MARK: - Supporting
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        detailPageControl.currentPage = Int(page)
    }
    
    // MARK: - ACTIONS
    @IBAction func meLevaRioButton(_ sender: Any) {
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: "Me Leva Rio", message: nil, preferredStyle: .actionSheet)
            
            let mapsAction = UIAlertAction(title: "Mapas", style: .default, handler: { action in self.meLevaRioMaps() })
            let googleMapsAction = UIAlertAction(title: "Google Maps", style: .default, handler: { action in self.meLevaRioApps(url: "comgooglemaps://")})
            let wazeAction = UIAlertAction(title: "Waze", style: .default, handler: { action in self.meLevaRioApps(url: "waze://") })
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            
            alertController.addAction(mapsAction)
            alertController.addAction(googleMapsAction)
            alertController.addAction(wazeAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    private func meLevaRioMaps() {
        
        let regionDistance: CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(dto.latitude, dto.longitude)
        let regionReach = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionReach.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionReach.span)]
        
        let mark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: mark)
        
        // Adicionando nome ao lugar
        mapItem.name = String(dto.nome)
        
        // Abrindo o app Mapa com o marcador no local indicado
        mapItem.openInMaps(launchOptions: options)
        
    }
    
    func meLevaRioApps(url: String) {
        
//         A partir do iOS 9, o aplicativo deve declarar os esquemas de URL no Info.plist.
//        <key>LSApplicationQueriesSchemes</key>
//        <array>
//          <string>googlechromes</string>
//          <string>comgooglemaps</string>
//          <string>waze</string>
//        </array>
        
        let urlOpen: String
        let appName: String
        let itunesLink: String
        let application = UIApplication.shared
        
        switch url {
        case "comgooglemaps://":
            urlOpen =   "comgooglemaps://?" +
                        "daddr=\(dto.latitude),\(dto.longitude)" +
                        "&zoom=16" +
                        "&views=traffic&" +
                        "directionsmode=driving"
            appName = "Google Maps"
            itunesLink = "http://itunes.apple.com/us/app/id585027354"
            
        default:
            
            urlOpen = "https://waze.com/ul?ll=\(dto.latitude),\(dto.longitude)&navigate=yes"
            appName = "Waze"
            itunesLink = "http://itunes.apple.com/us/app/id323229106"
            
        }
        
        
        if (UIApplication.shared.canOpenURL(URL(string: url)!)) {
            
            application.open(URL(string: urlOpen)!,
                             options: [:],
                             completionHandler: nil)
            
        } else {
            
            showNativeAlert(title: "\(appName) não encontrado",
                            message: "Para usar o \(appName), será necessário instalar o aplicativo em seu device.",
                            afirmativeAction: "Instalar",
                            negativeAction: "Cancelar",
                            completeBlock: { (action) in
                                application.open(NSURL(string: itunesLink)! as URL,
                                                 options: [:],
                                                 completionHandler: nil)
            })
            
        }
        
    }
    
}
