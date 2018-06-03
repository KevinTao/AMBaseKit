//
//  ViewController.swift
//  AMBaseKit
//
//  Created by deity_magician@aliyun.com on 06/02/2018.
//  Copyright (c) 2018 deity_magician@aliyun.com. All rights reserved.
//

import UIKit
import AMBaseKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let colormanager = ColorManager.init()
        self.view.backgroundColor = colormanager.theme?.background
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

