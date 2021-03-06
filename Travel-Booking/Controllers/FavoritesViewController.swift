//
//  FavoritesViewController.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 28/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesList: UICollectionView!
    
    let userDefaults = UserDefaults.standard
    var favorites: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        favorites = userDefaults.value(forKey: "myFavorites") as? [String]
        print(favorites?.count ?? 0)
        self.favoritesList.register(UINib(nibName: "InterestsImagesCell", bundle: nil), forCellWithReuseIdentifier: "InterestsImagesCell")
        
        self.favoritesList.reloadData()
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell :InterestsImagesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestsImagesCell", for: indexPath) as! InterestsImagesCell
        
        if let indexVal = favorites![indexPath.item] as? String {
            let splitStr = indexVal.components(separatedBy: "|")
            let name = splitStr[0]
            let id = splitStr[1]
            
            cell.nameOfInterest.text = name
            cell.reference_id = id
            cell.starBtn.isHidden = true

        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

         let noOfCellsInRow = 2

         let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

         let totalSpace = flowLayout.sectionInset.left
             + flowLayout.sectionInset.right
             + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

         let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

         return CGSize(width: size, height: size)
     }
}
