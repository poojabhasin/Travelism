//
//  DescriptionViewController.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 25/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityDescText: UITextView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var imageParentView: UIView!
    @IBOutlet weak var navigateToBookBtn: UIButton!
    
    @IBOutlet weak var listOfInterests: UICollectionView!
    
    var citiesList = [CityResults]()
    var interestsList: [DestResults]?
    
    let userDefaults = UserDefaults.standard
    
    var favoritesDest = [String]()
    
    var vSpinner : UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        favoritesDest = userDefaults.value(forKey: "myFavorites") as? [String] ?? []
        
        self.listOfInterests.register(UINib(nibName: "InterestsImagesCell", bundle: nil), forCellWithReuseIdentifier: "InterestsImagesCell")
        
        if let reference_id = citiesList.first?.photos?.first?.photo_reference {
            
            let urlStr = ServerRequestRouter.getImageFromReferenceId(reference_id).path
            let url = NSURL(string: urlStr)! as URL
            self.cityImage.kf.setImage(with: url)
        }
        self.cityImage.layer.cornerRadius = 40
        self.cityImage.layer.masksToBounds = true
        
        self.imageParentView.applyShadow()
        
        self.navigateToBookBtn.layer.cornerRadius = 40
        
        let btnText = Common.getAttributedString(spacing: 1.0, val1: Common.currentDate(), val2: "Flights")
        
        self.navigateToBookBtn.setAttributedTitle(btnText, for: .normal)
        
        self.navigateToBookBtn.applyShadow()
        
        self.cityName.text = citiesList[0].name!
        
        fetchDetailsAndInterests()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        userDefaults.set(favoritesDest, forKey: "myFavorites")
    }
    
    func fetchDetailsAndInterests() {
        
        vSpinner = showSpinner(onView: self.view)
        
        if let _ = citiesList.first?.name {
            
            ServerManager.sharedInstance.getCityDesc(cityVal: Common.removeWhitespaces(val: citiesList.first!.name!)) { [weak self] (details, error) in
                if let error = error {
                    print(error)
                }
                else {
                    if let details = details {
                        self?.cityDescText.text = details.extract
                    }
                }
            }
            
            ServerManager.sharedInstance.getPointOfInterestData(cityVal: Common.removeWhitespaces(val: citiesList.first!.name!)) { [weak self] (details, error) in
                if let error = error {
                    print(error)
                }
                else {
                    if let details = details {
                        self?.interestsList = details.destResults!
                        self?.listOfInterests.reloadData()
                    }
                }
                
                self?.removeSpinner(spinner: self?.vSpinner)
                self?.vSpinner = nil
            }
        }
    }
    
    @IBAction func searchFlightsBtnClicked(_ sender: Any) {
        
        let searchVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FlightsViewController") as? FlightsViewController
        searchVC?.dest = self.cityName.text
        searchVC?.modalPresentationStyle = UIModalPresentationStyle.popover
        self.present(searchVC!, animated: true, completion: nil)
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension DescriptionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.interestsList?.count ?? 0
        
    }
    
    @objc func onClickFavorites(sender: UIButton){
        
        if let name = self.interestsList?[sender.tag].name {
            if let ref_id = self.interestsList![sender.tag].photos?.first?.photo_reference {
                if (self.favoritesDest.contains("\(name)|\(ref_id)") ) {
                    if let index = favoritesDest.firstIndex(of: name) {
                        self.favoritesDest.remove(at: index)
                    }
                    sender.tintColor = UIColor.white
                }else {
                    let value = "\(name)|\(ref_id)"
                    self.favoritesDest.append(value)
                    sender.tintColor = UIColor.red
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell :InterestsImagesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestsImagesCell", for: indexPath) as! InterestsImagesCell
        cell.nameOfInterest.text = self.interestsList?[indexPath.item].name
        
        if let refId = self.interestsList?[indexPath.item].photos?.first?.photo_reference {
            cell.reference_id = refId
        }
        cell.starBtn.tag = indexPath.item
        
        if let name = self.interestsList?[indexPath.item].name {
            if let ref_id = self.interestsList?[indexPath.item].photos?.first?.photo_reference {
                if (self.favoritesDest.contains("\(name)|\(ref_id)") ) {
                    cell.starBtn.tintColor = UIColor.red
                } else{
                    cell.starBtn.tintColor = UIColor.white
                }
            }
        }
        cell.starBtn.addTarget(self, action:#selector(onClickFavorites(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(collectionView.frame.size.height)
        return CGSize(width: 234, height: collectionView.frame.size.height )
    }
}

