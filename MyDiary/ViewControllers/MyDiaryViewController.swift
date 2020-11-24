//
//  MyDiaryViewController.swift
//  MyDiary
//
//  Created by Hardik on 24/11/20.
//  Copyright © 2020 MyDiary. All rights reserved.
//

import UIKit

class MyDiaryViewController: UIViewController {
    // MARK: - IBOutlate's
    
    @IBOutlet weak var tblMyDiary: UITableView!
    
    // MARK: - Objects
    
    var arrDiaryList = [RealmDiary]() {
        didSet {
            filterUserList()
        }
    }
    
    var dayList = [String]()
    var dayWiseDiary = [String: [RealmDiary]]()
    
    // MARK: - View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setUpTable()
        
        // Add Realm Observer for data refresh.
        
        RealmDiaryManager.shared.addObserver { [weak self] (diaryList) in
            guard let self = self else {return}
            self.arrDiaryList = diaryList
        }
        self.getAPIDairy()
    }
}

// MARK: - Private Methos

extension MyDiaryViewController{
    private func setUpTable() {
        tblMyDiary.register(UINib(nibName: "MyDiaryCell", bundle: nil), forCellReuseIdentifier: "MyDiaryCell")
        tblMyDiary.register(UINib(nibName : "MyDiaryHeader", bundle: nil), forCellReuseIdentifier: "MyDiaryHeader")
        tblMyDiary.tableFooterView = UIView()
        
        tblMyDiary.delegate = self
        tblMyDiary.dataSource = self
    }
    
    private func filterUserList() {
        print("List update")
        
        dayList = arrDiaryList.map({$0.day})
        dayList.removeDuplicates()
        dayWiseDiary.removeAll()
        dayWiseDiary = Dictionary(grouping: arrDiaryList, by: {$0.day})
        
        self.tblMyDiary.reloadData()
    }
    
    func getAPIDairy() {
        if !Connectivity.isConnectedToInternet {
            UIAlertController.showAlertWithOkButton(self, aStrMessage:R.string.localizable.internet_error() , aStrTitle: "Networkerror", completion: nil)
        }
        else{
            APIManager.shared.APICallGetMyDiary() { (statuscode) in
                print(statuscode)
            }
        }
    }
    
    func diaryForIndexPath(_ indexPath: IndexPath) -> RealmDiary? {
        let day = dayList[indexPath.section]
        let dateMessages = dayWiseDiary[day]!
        return dateMessages[indexPath.row]
    }
    
    func onClickEdit(_ indexPath: IndexPath) {
        let dicDiary = diaryForIndexPath(indexPath)!
        
        let scrEdit = R.storyboard.main.editDiaryViewController()!
        scrEdit.dicdiary = dicDiary
        self.navigationController?.pushViewController(scrEdit, animated: true)
    }
}

// MARK: - TableView Delegate and DataSource

extension MyDiaryViewController: UITableViewDelegate, UITableViewDataSource{
    // number of rows in table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return dayList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayWiseDiary[dayList[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyDiaryHeader") as! MyDiaryHeader
        cell.contentView.backgroundColor = .white
        
        var day = dayList[section]
        
        if day == Date().toHeaderFormate() {
            day = "Today"
        }
        print("day:-", day)
        cell.lblDate.text = day.headerDisplayDate()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyDiaryCell", for: indexPath) as! MyDiaryCell
        
        let dicDiary = diaryForIndexPath(indexPath)!
        
        cell.lblTitle.text = dicDiary.title
        cell.lblContent.text = dicDiary.content
        cell.lblDate.text = dicDiary.date.timeAgoDisplay(.long)
        
        cell.selectionStyle = .none
        
        cell.onEdit = { [weak self] in
            guard let self = self, let index = tableView.indexPath(for: cell) else {return}
            self.onClickEdit(index)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
