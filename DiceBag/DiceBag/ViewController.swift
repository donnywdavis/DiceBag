//
//  ViewController.swift
//  DiceBag
//
//  Created by Donny Davis on 5/24/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit
import AVFoundation

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
    var audioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create our dice bag
        var index = 0
        while index < numberOfD4 {
            d4Array.append(Die(type: DiceType.D4, currentValue: 0, locked: false))
            index += 1
        }
        
        index = 0
        while index < numberOfD6 {
            d6Array.append(Die(type: DiceType.D6, currentValue: 0, locked: false))
            index += 1
        }
        
        index = 0
        while index < numberOfD10 {
            d10Array.append(Die(type: DiceType.D10, currentValue: 0, locked: false))
            index += 1
        }
        
        index = 0
        while index < numberOfD20 {
            d20Array.append(Die(type: DiceType.D20, currentValue: 0, locked: false))
            index += 1
        }
        
        diceBag = [d4Array, d6Array, d10Array, d20Array]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }

    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            if let audioFilePath = NSBundle.mainBundle().pathForResource("dice-roll", ofType: "mp3") {
                let audioURL = NSURL(fileURLWithPath: audioFilePath)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOfURL: audioURL)
                    audioPlayer.play()
                } catch {
                    print("Not able to play audio")
                }
            }
            collectionView.reloadData()
        }
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
        
        var die = diceBag[indexPath.section][indexPath.row]
        
        cell.bounds.size.width = 60
        cell.bounds.size.height = 60
        cell.layer.cornerRadius = 10.0
        
        let label = UILabel(frame: cell.bounds)
        if !die.locked {
            die.currentValue = die.roll()
            diceBag[indexPath.section][indexPath.row] = die
        }
        label.text = String(die.currentValue)
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = die.color
        
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var reusableView: UICollectionReusableView?
        
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SectionHeader", forIndexPath: indexPath) as? DiceTypeCollectionReusableView
            let diceType = diceBag[indexPath.section][indexPath.row]
            headerView?.headerTitle.text = String(diceType.type)
            for index in 0...diceBag[indexPath.section].count-1 {
                var die = diceBag[indexPath.section][index]
                die.locked = (headerView?.lockDiceSwitch.on)!
                diceBag[indexPath.section][index] = die
            }
            reusableView = headerView
        }
        
        return reusableView!
    }
    
}

