//
//  ShowMovieVC.swift
//  reel-fun
//
//  Created by Brian Bresen on 11/12/16.
//  Copyright © 2016 BeeHive Productions. All rights reserved.
//

import UIKit

class ShowMovieVC: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showDesc: UILabel!
    @IBOutlet weak var showLink: UILabel!
    @IBOutlet weak var showPlot: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    
    var movie: Movie!
//    var receivedCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showTitle.text = movie.title
        showDesc.text = movie.comment
        showLink.text = movie.webpage
        showPlot.text = movie.plot
        showImage.image = movie.getMovieImg()
    }

    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
