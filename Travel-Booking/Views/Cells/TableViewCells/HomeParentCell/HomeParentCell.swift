//
//  HomeParentCell.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 17/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import UIKit

class HomeParentCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.register(UINib(nibName: "DestinationsView", bundle: nil), forCellWithReuseIdentifier: "destinationsView")
        }
    }
    
    var destinationsList: [DestResults]? {
        didSet{
            self.collectionView.reloadData()
        }
    }
        
}

extension HomeParentCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return destinationsList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell :DestinationsView = collectionView.dequeueReusableCell(withReuseIdentifier: "destinationsView", for: indexPath) as! DestinationsView
            cell.destinationsName.text = destinationsList![indexPath.item].name
            cell.reference_id = destinationsList![indexPath.item].photos![0].photo_reference
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

