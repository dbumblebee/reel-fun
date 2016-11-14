//
//  MovieCell.swift
//  reel-fun
//
//  Created by Brian Bresen on 11/12/16.
//  Copyright © 2016 BeeHive Productions. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieComment: UILabel!
    @IBOutlet weak var movieLink: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(movie: Movie) {
        movieTitle.text = movie.title
        movieComment.text = movie.comment
        movieLink.text = movie.webpage
        movieImage.image = movie.getMovieImg()
        
//        movieImage.layer.cornerRadius = 5.0
        movieImage.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
