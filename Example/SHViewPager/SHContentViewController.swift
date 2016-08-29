//
//  SHContentViewController.swift
//  SHViewPager
//
//  Created by Shabib Hossain on 8/29/16.
//  Copyright © 2016 shabib87. All rights reserved.
//

import UIKit

class SHContentViewController: UIViewController {

    var selectionIndicatorString: String!
    @IBOutlet private var indicatorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorLabel.text = selectionIndicatorString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
