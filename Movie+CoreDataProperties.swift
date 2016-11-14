//
//  Movie+CoreDataProperties.swift
//  reel-fun
//
//  Created by Brian Bresen on 11/12/16.
//  Copyright © 2016 BeeHive Productions. All rights reserved.
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie");
    }

    @NSManaged public var comment: String?
    @NSManaged public var image: NSData?
    @NSManaged public var plot: String?
    @NSManaged public var title: String?
    @NSManaged public var webpage: String?

}
