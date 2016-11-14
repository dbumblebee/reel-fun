//
//  OMDBAPIController.swift
//  Films
//
//  Created by Dulio Denis on 8/14/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//
//  Modified by Brian Bresen to work on Swift 3 and just do title search with short plot

import UIKit


// Specify the OMDB API Protocol
protocol OMDBAPIControllerDelegate {
    func didFinishOMDBSearch(result: Dictionary<String, String>)
}

class OMDBAPIController {
    // Optional delegate property adheres to OMDB API protocol
    var delegate: OMDBAPIControllerDelegate?
    
    // initializer accepts optional delegate and sets it
    init(delegate: OMDBAPIControllerDelegate?) {
        self.delegate = delegate
    }
    
    func searchOMDB(forContent:String) {
        let spacelessString = forContent.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
       
        let urlPath = URL(string: "http://www.omdbapi.com/?t=\(spacelessString!)&plot=short")!
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlPath) {
            data, response, error -> Void in
            
            if ((error) != nil) {
                print(error!.localizedDescription)
            }
            
            var jsonResult = Dictionary<String, String>()

            do {
                jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, String>
            } catch {
                print("JSON reading error")
            }
            
            // Optional Binding to check to see that we do have the optional delegate
            if let apiDelegate = self.delegate {

                DispatchQueue.main.async {
                    apiDelegate.didFinishOMDBSearch(result: jsonResult)
                }
            }
            
        }
        task.resume()
    }
}
