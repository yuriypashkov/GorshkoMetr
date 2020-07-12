//
//  ViewController.swift
//  GorshkoMetr
//
//  Created by Yuriy Pashkov on 6/1/20.
//  Copyright © 2020 Yuriy Pashkov. All rights reserved.
//

import UIKit


class ConcertMetr: UIViewController {
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    var str = "концертов"
    
    var count = 0 {
        didSet {
            defaults.set(count, forKey: "countKey")
            
            let temp = (count + 10) % 10
            switch temp {
            case 0:
                str = "концертов"
            case 1:
                str = "концерт"
            case 2,3,4:
                str = "концерта"
            default:
                str = "концертов"
            }
            
            if count == 11 || count == 12 || count == 13 || count == 14 {
                str = "концертов"
            }
            
            countLabel.text = "\(count) \(str)"
            if count < 0 {
                count = 0
                countLabel.text = "0 концертов"
            }
        }
    }
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    
    @IBAction func tapPlus(_ sender: UIButton) {
        count += 1
        sender.alpha = 1.0
    }
    
    @IBAction func tapMinus(_ sender: UIButton) {
        count -= 1
        sender.alpha = 1.0
    }
    
    
    @IBAction func tapPlusDown(_ sender: UIButton) {
        sender.alpha = 0.5
    }
    
    @IBAction func tapMinusDown(_ sender: UIButton) {
        sender.alpha = 0.5
    }
    
    @IBAction func tapClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonPlus.layer.cornerRadius = buttonPlus.frame.width / 2
        buttonMinus.layer.cornerRadius = buttonMinus.frame.width / 2
        //buttonPlus.contentVerticalAlignment = .center
        //buttonPlus.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        // get
        count = defaults.integer(forKey: "countKey")
        //countLabel.text = String(count)
    }


}

