//
//  LugarView.swift
//  MeLevaRio
//
//  Created by Renan Matias on 17/08/17.
//  Copyright © 2017 Renan Matias. All rights reserved.
//

import UIKit

class LugarView: UIView {

    // MARK: Outlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nomeLabel: UILabel!
    
    override func awakeFromNib() { // DID LOAD
        super.awakeFromNib()
        self.setFormatImageView()
    }
    
    private func setFormatImageView() {
        
        // método para arredondar as imagens via código
        mainImageView.layer.cornerRadius = 50 // Half the imageView size
        mainImageView.clipsToBounds = true // Cut to the edges

        mainImageView.layer.borderWidth = 1
        mainImageView.layer.borderColor = UIColor(red: 32/255.0, green: 92/255.0, blue: 222/255.0, alpha: 1.0).cgColor
        
    }
    
    func fill(dto: lugarViewDTO) {
        mainImageView.downloadImage(with: dto.mainImage)
        nomeLabel.text = dto.nome
    }

}
