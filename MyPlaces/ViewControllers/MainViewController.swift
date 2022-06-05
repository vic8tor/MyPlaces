//
//  ViewController.swift
//  MyPlaces
//
//  Created by Victor on 26.04.2022.
//

import UIKit

class MainViewController: UITableViewController {
    // MARK: - @IBOutlets
    
    // MARK: - Public Properties
    
    var places = Place.getPlaces()
    
    // MARK: - Private Properties
    
    // MARK: - Initializers
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Restaurants"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.customImageView.image = UIImage(named: places[indexPath.row].restaurantImage!)
        cell.customImageView.layer.cornerRadius = cell.customImageView.frame.size.height / 2
        cell.customImageView.clipsToBounds = true
        cell.nameLabel.text = places[indexPath.row].name
        
        return cell
    }
    
    // MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    
    // MARK: - @IBActions
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newPlaceVC = segue.source as? NewPlaceViewController else { return }
        newPlaceVC.saveNewPlace()
        places.append(newPlaceVC.newPlace!)
        tableView.reloadData()
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
}


