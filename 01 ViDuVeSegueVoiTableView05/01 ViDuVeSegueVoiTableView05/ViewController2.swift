//
//  ViewController2.swift
//  01 ViDuVeSegueVoiTableView05
//
//  Created by Trương Quang on 6/22/19.
//  Copyright © 2019 Trương Quang. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    var value: Int?
    
    
    @IBOutlet weak var outletValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let value = value {
            outletValue.text = String(value)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let value = Int(outletValue.text!){
            self.value = value
        }
    }
    
    
    
}
