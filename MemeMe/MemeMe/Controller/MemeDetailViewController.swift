//
//  MemeDetailViewController.swift
//  MemeV1
//
//  Created by Fazakas Loránd on 2020. 04. 11..
//  Copyright © 2020. Lorand Fazakas. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var memeImageView: UIImageView!
    var memeImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeImageView.image = memeImage
    }

}
