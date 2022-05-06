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
    let restaurantNames = [
        "Burger Monster", "Kitchen", "Bonsai", "Магеллан",
        "Индокитай", "X.O", "Дольче Гриль", "Sherlock Holmes",
        "Speak Easy", "Morris Pub", "Большие города",
        "Классик", "Love&Life", "Шок", "Fish and Cheese"
    ]
    
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
        restaurantNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.customImageView.image = UIImage(named: restaurantNames[indexPath.row])
        cell.customImageView.layer.cornerRadius = cell.customImageView.frame.size.height / 2
        cell.customImageView.clipsToBounds = true
        cell.nameLabel.text = restaurantNames[indexPath.row]
        
        return cell
    }
    
    // MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }

    // MARK: - @IBActions
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
}


