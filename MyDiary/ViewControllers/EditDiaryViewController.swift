//
//  EditDiaryViewController.swift
//  MyDiary
//
//  Created by Hardik on 24/11/20.
//  Copyright © 2020 MyDiary. All rights reserved.
//

import UIKit

class EditDiaryViewController: UIViewController {
    @IBOutlet weak var btnSave: UIButton!{
        didSet{
            btnSave.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var tvContent: UITextView!
    
    var dicdiary: RealmDiary?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupViewData()
    }
    
    func setupViewData() {
        
        self.title = self.dicdiary?.title
        
        self.txtTitle.text = self.dicdiary?.title
        self.tvContent.text = self.dicdiary?.content
    }
    
    func isValidate() -> Bool {
        if txtTitle.text!.isEmptyString() {
            UIAlertController.showAlertWithOkButton(self, aStrMessage: R.string.localizable.title_empty(), aStrTitle: appName, completion: nil)
            return false
        }
        
        if tvContent.text!.isEmptyString() {
            UIAlertController.showAlertWithOkButton(self, aStrMessage: R.string.localizable.content_empty(), aStrTitle: appName, completion: nil)
            return false
        }

        return true
    }
    
}

extension EditDiaryViewController{
    @IBAction func onClickSave(_ sender: Any) {
        
        if isValidate() {
            RealmManager.shared.write {
                self.dicdiary?.title = "Test"
                self.dicdiary?.content = "Test"
                
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
