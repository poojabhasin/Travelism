//
//  AirportListViewController.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 01/03/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import UIKit

protocol FlightsViewControllerDelegate {
    func saveOriginData(placesObj: AirportsPlaces)
}

class AirportListViewController: UIViewController {
    
    @IBOutlet weak var airportList: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedAirport: String?
    
    var airportsDataList: [AirportsTopResponse]?
    
    var delegate: FlightsViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        self.airportList.register(UINib(nibName: "AirportListCell", bundle: nil), forCellReuseIdentifier: "airportListCell")
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AirportListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airportsDataList?.first?.places?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirportListCell", for: indexPath) as! AirportListCell

        cell.airportCityName.text = airportsDataList?.first?.places?[indexPath.row].placeName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAirport = airportsDataList?.first?.places?[indexPath.row].placeName
        
        if selectedAirport != nil {
            self.delegate?.saveOriginData(placesObj: (airportsDataList?.first?.places?[indexPath.row])!)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

}

extension AirportListViewController: UISearchBarDelegate {
    //MARK: UISearchbar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        
        guard !searchText.isEmpty  else { airportsDataList?.removeAll(); self.airportList.reloadData(); return }
        
        ServerManager.sharedInstance.getAirportsData(searchVal: searchText) { [weak self] (details, error) in
            if let error = error {
                print(error)
            }
            else {
                if let val = details {
                    self?.airportsDataList = [val]
                    self?.airportList.reloadData()
                }
            }
        }
    }
    
}

class AirportListCell: UITableViewCell {
    
    @IBOutlet weak var airportCityName: UILabel!

}
