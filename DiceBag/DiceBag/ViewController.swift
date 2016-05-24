//
//  ViewController.swift
//  DiceBag
//
//  Created by Donny Davis on 5/24/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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

