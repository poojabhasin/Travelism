//
//  ViewController.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 17/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import UIKit

class HomeViewController: BaseTabViewController {
    
    @IBOutlet weak var namesCollection: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var citiesList = [CityResults]()
    var destList = [DestResults]()
    var selectedIndex: Int! = 0
    var vSpinner : UIView?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addBottomBar()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension

        self.title = "Discover"
        self.navigationController?.navigationBar.backgroundColor = UIColor(named:
        "BackgroundColor")

        self.tableView.register(UINib(nibName: "HomeParentCell", bundle: nil), forCellReuseIdentifier: "HomeParentCell")

        self.tableView.register(UINib(nibName: "PagerCell", bundle: nil), forCellReuseIdentifier: "PagerCell")

        self.namesCollection.register(UINib(nibName: "NamesView", bundle: nil), forCellWithReuseIdentifier: "namesView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false

        fetchData(indexStr: Constants.countriesList[selectedIndex])
        
    }
    
    func fetchData(indexStr: String) {
        vSpinner = showSpinner(onView: self.view)
        ServerManager.sharedInstance.getAllCities(cityVal: Common.removeWhitespaces(val: indexStr)) { [weak self] (details, error) in
            if let error = error {
                print(error)
            }
            else {
                if let details = details {
                    self?.citiesList = details.cityResults!
                    self?.tableView.reloadData()
                }
            }
        }
        
        ServerManager.sharedInstance.getAllDestinations(destVal: Common.removeWhitespaces(val: indexStr)) { [weak self] (details, error) in
            if let error = error {
                print(error)
                self?.showErrorAlertWithTitle("Error", message: "Something went wrong.")
            }
            else {
                if let details = details {
                    self?.destList = details.destResults ?? []
                    self?.tableView.reloadData()
                    self?.removeSpinner(spinner: self?.vSpinner)
                    self?.vSpinner = nil
                }
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
           let cell = tableView.dequeueReusableCell(withIdentifier: "PagerCell") as? PagerCell
            cell?.setNeedsUpdateConstraints()
            cell?.updateConstraintsIfNeeded()

            cell?.citiesList = citiesList
            cell?.parentVC = self
            return cell ?? UITableViewCell()
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeParentCell") as? HomeParentCell
            cell?.destinationsList = destList
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.row == 0 {
           return 386
        }
        return 186.0;//Choose your custom row height
    }


}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.countriesList.count
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell :NamesView = collectionView.dequeueReusableCell(withReuseIdentifier: "namesView", for: indexPath) as! NamesView
        cell.countriesName.text = Constants.countriesList[indexPath.item]

        if selectedIndex == indexPath.item {
            cell.countriesName.textColor = UIColor(named: "PrimaryColor")
            cell.dottedLbl.isHidden = false
        }else {
            cell.countriesName.textColor = UIColor.lightGray
            cell.dottedLbl.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            let label = UILabel(frame: CGRect.zero)
            label.text = " \(Constants.countriesList[indexPath.item]) "
            label.sizeToFit()
            return CGSize(width: label.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        self.fetchData(indexStr: Constants.countriesList[indexPath.item])
        collectionView.reloadData()
        
    }
}

extension UIImage {
    func getImageRatio() -> CGFloat {
        let imageRatio = CGFloat(self.size.width / self.size.height)
        return imageRatio
    }
}

