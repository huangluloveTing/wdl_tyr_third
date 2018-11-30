
//
//  WordLocationPathsVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/30.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class WordLocationPathsVC: NormalBaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    public var locations:[ZbnLocation]?

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        self.addLeftBarbuttonItem(withTitle: "运输轨迹")
        self.addRightBarbuttonItem(withTitle: "关闭")
    }
    
    override func zt_leftBarButtonAction(_ sender: UIBarButtonItem!) {
        
    }

    override func zt_rightBarButtonAction(_ sender: UIBarButtonItem!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configTableView() {
        self.registerCell(nibName: "\(LocationLineCell.self)", for: tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
    }

}

extension WordLocationPathsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(LocationLineCell.self)") as! LocationLineCell
        let row = indexPath.row
        let info = self.locations![row]
        let top = row == 0
        let bottom = (row == ((self.locations?.count ?? 0) - 1))
        cell.showLineInfo(address: info.location ?? "", time: info.createTime ?? 0 , top: top , bottom: bottom)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations?.count ?? 0
    }
}
