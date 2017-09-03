//
//  DetailViewController.swift
//  MeLevaRio
//
//  Created by Renan Matias on 02/09/17.
//  Copyright © 2017 Renan Matias. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var sliderScrollView: UIScrollView!
    @IBOutlet weak var detailPageControl: UIPageControl!
    @IBOutlet weak var meLevaRioButton: UIButton!
    @IBOutlet weak var descricaoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fill(dto: lugarViewDTO) {
        DispatchQueue.main.async {
            self.descricaoTextView.text = dto.descricao
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
