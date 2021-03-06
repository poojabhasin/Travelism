//
//  PagerCell.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 19/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import UIKit
import FSPagerView

class PagerCell: UITableViewCell {
    
    var parentVC: UIViewController?
    
    @IBOutlet weak var carouselView: FSPagerView! {
        didSet {
            self.carouselView.register(UINib(nibName: "CardView", bundle: nil), forCellWithReuseIdentifier: "cardView")
            
            self.carouselView.transformer = FSPagerViewTransformer(type: .linear)
            
            
        }
    }
    
    var citiesList: [CityResults]? {
        didSet{
            self.carouselView.reloadData()
        }
    }
    
}

extension PagerCell: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return citiesList?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell
    {
        let cell = carouselView.dequeueReusableCell(withReuseIdentifier: "cardView", at: index) as! CardView
        cell.city = citiesList?[index].name
        cell.reference_id = citiesList?[index].photos?.first?.photo_reference
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let descVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DescriptionViewController") as? DescriptionViewController
        descVC?.citiesList = [citiesList![index]]
        self.parentVC?.navigationController!.pushViewController(descVC!, animated: true)
        
    }
}
