//
//  UIView+Extension.swift
//  MyDiary
//
//  Created by Hardik on 24/11/20.
//  Copyright © 2020 MyDiary. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD


// MARK: - UIViewController Extension

extension UIViewController{
    func showHUD() {
        SVProgressHUD.show()
    }
    
    func HideHUD() {
        SVProgressHUD.dismiss()
    }
}
