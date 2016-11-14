//
//  AddMovieVC.swift
//  reel-fun
//
//  Created by Brian Bresen on 11/12/16.
//  Copyright © 2016 BeeHive Productions. All rights reserved.
//

import UIKit

class AddMovieVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UISearchBarDelegate, OMDBAPIControllerDelegate {

    @IBOutlet weak var addImgBtn: UIButton!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UITextField!
    @IBOutlet weak var movieDesc: UITextField!
    @IBOutlet weak var movieLink: UITextField!
    @IBOutlet weak var moviePlot: UITextField!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var imagePicker: UIImagePickerController!
    
    lazy var apiController: OMDBAPIController = OMDBAPIController(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        movieImage.layer.cornerRadius = 5.0
        movieImage.clipsToBounds = true
        
        searchBar.delegate = self
        apiController.delegate = self
        
    }
    
    //Hide keyboard when user touch outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        imagePicker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            movieImage.image = image
            addImgBtn.titleLabel?.text = ""
        }
    }
    
    @IBAction func addImgPressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func cancelPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearPressed(_ sender: Any) {
        movieTitle.text = ""
        movieDesc.text = ""
        movieLink.text = ""
        moviePlot.text = ""
        addImgBtn.titleLabel?.text = "ADD IMG"
        movieImage.image = UIImage()
    }
    
    @IBAction func addPressed(_ sender: Any) {
        if let title = movieTitle.text, title != "" {
            let app = UIApplication.shared.delegate as! AppDelegate
            let context = app.persistentContainer.viewContext
            let movie = Movie(context: context)
            movie.title = title
            movie.comment = movieDesc.text
            movie.webpage = movieLink.text
            movie.plot = moviePlot.text
            movie.setMovieImage(img: movieImage.image!)
            
            context.insert(movie)
            
            do {
                try context.save()
            } catch {
                print("Could not save movie")
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func didFinishOMDBSearch(result: Dictionary<String, String>) {
      print("In didFinishOMDBSearch: sent reponse of: \(result["Response"])")
        if result["Response"] == "True" {
            if let hasTitle = result["Title"] {
                movieTitle.text = hasTitle
            }
            if let hasLink = result["imdbID"]{
                movieLink.text = "http://www.imdb.com/title/\(hasLink)"
            }
            if let hasPlot = result["Plot"] {
               moviePlot.text = hasPlot
            }
            if let hasPoster = result["Poster"], hasPoster != "N/A" {
    print("Did we get Here??? hasPoster is: \(hasPoster)")
                if let posterURL = URL(string: hasPoster), let posterImageData = NSData(contentsOf: posterURL) {
                    movieImage.image = UIImage(data: posterImageData as Data)
                    addImgBtn.titleLabel?.text = ""
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "nil" {
            apiController.searchOMDB(forContent: searchBar.text!)
        }
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
}
