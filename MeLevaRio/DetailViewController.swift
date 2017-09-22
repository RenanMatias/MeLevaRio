//
//  DetailViewController.swift
//  MeLevaRio
//
//  Created by Renan Matias on 02/09/17.
//  Copyright © 2017 Renan Matias. All rights reserved.
//

import UIKit

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
            let mapsAction = UIAlertAction(title: "Maps", style: .default, handler: nil)
            let googleMapsAction = UIAlertAction(title: "Google Maps", style: .default, handler: nil)
            let wazeAction = UIAlertAction(title: "Waze", style: .default, handler: nil)
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            
            alertController.addAction(mapsAction)
            alertController.addAction(googleMapsAction)
            alertController.addAction(wazeAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }

}
