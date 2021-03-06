//
//  BaseTabViewController.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 22/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import UIKit

class BaseTabViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc func onClickHome(sender: UIButton){
    }
    
    @objc func onClickFavorites(sender: UIButton){
        let favoritesVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FavoritesViewController") as? FavoritesViewController
        
        self.navigationController?.pushViewController(favoritesVC!, animated: true)
    }
    
    func addBottomBar() {
        
        let customView = (Bundle.main.loadNibNamed("BottomView", owner:
            self, options: nil)?.first as? BottomView)
        customView!.bottomBar.frame = CGRect(x:20, y: 782, width:340, height:116)

        customView!.bottomBar.layer.cornerRadius = 35

        self.view.addSubview(customView!)
        
        customView?.homeButton.addTarget(self, action:#selector(onClickHome(sender:)), for: .touchUpInside)
        customView?.favouritesButton.addTarget(self, action:#selector(onClickFavorites(sender:)), for: .touchUpInside)

        customView!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: customView!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 0.94, constant: 8).isActive = true
        NSLayoutConstraint(item: customView!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 0.94, constant: 8).isActive = true

        
        NSLayoutConstraint(item: customView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 0.94, constant: 12).isActive = true

        NSLayoutConstraint(item: customView!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 374).isActive = true
        NSLayoutConstraint(item: customView!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 72).isActive = true
    }

}
