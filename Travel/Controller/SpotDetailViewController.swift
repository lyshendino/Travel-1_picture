//
//  SpotDetailViewController.swift
//  Travel
//
//  Created by NDHU_CSIE on 2020/11/5.
//  Copyright © 2020 NDHU_CSIE. All rights reserved.
//

import UIKit

class SpotDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: SpotDetailHeaderView!
    
    var spot = Spot()

    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
                    
        case 0:
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SpotDetailIconTextCell.self), for: indexPath) as! SpotDetailIconTextCell
//        cell.iconImageView.image = UIImage(systemName: "map")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        cell.iconImageView.image = UIImage(named: "map")
        cell.shortTextLabel.text = spot.location
        cell.selectionStyle = .none
                    
        return cell
        case 1:
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SpotDetailTextCell.self), for: indexPath) as! SpotDetailTextCell
        cell.descriptionLabel.text = spot.summary
        cell.selectionStyle = .none
        
        return cell
         
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SpotDetailSeparatorCell.self), for: indexPath) as! SpotDetailSeparatorCell
            cell.titleLabel.text = "HOW TO GET HERE"
            cell.selectionStyle = .none
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SpotDetailMapCell.self), for: indexPath) as! SpotDetailMapCell
            cell.selectionStyle = .none
            cell.configure(location: spot.location)
            
            return cell
            
        default:
        fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
    
    // MARK: - Table view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        // Configure header view
        headerView.nameLabel.text = spot.name
        headerView.typeLabel.text = spot.type
        headerView.headerImageView.image = UIImage(named: spot.image)
        headerView.heartImageView.isHidden = (spot.isVisited) ? false : true
        if !spot.rating.isEmpty {
            headerView.ratingImageView.image = UIImage(named: spot.rating)
        }

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapViewController
            destinationController.spot = spot
        }
        else if segue.identifier == "showReview" {
            let destinationController = segue.destination as! ReviewViewController
            destinationController.spot = spot
        }
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rateSpot(segue: UIStoryboardSegue) {
        if let rating = segue.identifier {
            self.spot.rating = rating
            self.headerView.ratingImageView.image = UIImage(named: rating)
        }

    dismiss(animated: true, completion: nil)
    }

    

}
