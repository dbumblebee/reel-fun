//
//  Movie+CoreDataClass.swift
//  reel-fun
//
//  Created by Brian Bresen on 11/12/16.
//  Copyright © 2016 BeeHive Productions. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class Movie: NSManagedObject {
    
    func setMovieImage(img: UIImage) {
        let data = UIImagePNGRepresentation(img)
        self.image = data as NSData?
    }
    
    func getMovieImg() -> UIImage {
        let img = UIImage(data: self.image! as Data)!
        return img
    }

}
