//
//  ViewController.swift
//  DiceBag
//
//  Created by Donny Davis on 5/24/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: Properties
    
    var diceBag = [[Die]]()
    var d4Array = [Die]()
    var d6Array = [Die]()
    var d10Array = [Die]()
    var d20Array = [Die]()
    let numberOfD4 = 5
    let numberOfD6 = 6
    let numberOfD10 = 3
    let numberOfD20 = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create our dice bag
        var index = 0
        while index < numberOfD4 {
            d4Array.append(Die(type: DiceType.D4))
            index += 1
        }
        
        index = 0
        while index < numberOfD6 {
            d6Array.append(Die(type: DiceType.D6))
            index += 1
        }
        
        index = 0
        while index < numberOfD10 {
            d10Array.append(Die(type: DiceType.D10))
            index += 1
        }
        
        index = 0
        while index < numberOfD20 {
            d20Array.append(Die(type: DiceType.D20))
            index += 1
        }
        
        diceBag = [d4Array, d6Array, d10Array, d20Array]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return diceBag.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diceBag[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DiceCell", forIndexPath: indexPath)
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        let die = diceBag[indexPath.section][indexPath.row]
        
        let label = UILabel(frame: cell.bounds)
        label.text = String(die.roll())
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = die.color
        label.layer.cornerRadius = 45.0
        
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var reusableView: UICollectionReusableView?
        
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SectionHeader", forIndexPath: indexPath) as? DiceTypeCollectionReusableView
            headerView?.headerTitle.text = "Section"
            reusableView = headerView
        }
        
        return reusableView!
    }
    
}

