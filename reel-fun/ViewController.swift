//
//  ViewController.swift
//  reel-fun
//
//  Created by Brian Bresen on 11/11/16.
//  Copyright © 2016 BeeHive Productions. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchAndSetResults()
        tableView.reloadData()
    }

    func fetchAndSetResults() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        do {
            let results = try context.fetch(fetchRequest)
            self.movies = results as! [Movie]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell {
            let movie = movies[indexPath.row]
            cell.configureCell(movie: movie)
            return cell
        } else {
            return MovieCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovie", let destination = segue.destination as? ShowMovieVC {
            if let cell = sender as? MovieCell, let indexPath = tableView.indexPath(for: cell) {
                let movie = movies[indexPath.row]
                destination.movie = movie
            }
        }
    }
}

