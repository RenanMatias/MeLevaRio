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
    @IBOutlet weak var meLevaRioButton: UIButton!
    @IBOutlet weak var descricaoTextView: UITextView!

    // MARK: - Circle Life
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sliderScrollView.isPagingEnabled = true
        sliderScrollView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
