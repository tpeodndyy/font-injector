//
//  ViewController.swift
//  Example
//
//  Created by Peera Kerdkokaew on 22/2/18.
//  Copyright © 2018 Peera Kerdkokaew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var normalFontLabel: UILabel!
    @IBOutlet weak var boldFontLabel: UILabel!
    @IBOutlet weak var systemFontLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        normalFontLabel.font = InconsolataFont.dynamicFont(textStyle: .title1)
        boldFontLabel.font = InconsolataFont.dynamicFont(textStyle: .title2, weight: .bold)
        systemFontLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

