//
//  MoreScreenSelectionVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/12/12.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class MoreScreenSelectionVC: NormalBaseVC {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func resetHandle(_ sender: Any) {
    }
    
    @IBAction func sureHandle(_ sender: Any) {
    }
}

extension MoreScreenSelectionVC {
    
    //MARK: - config tableView
    func initTableView() -> Void {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MoreScreenSelectionVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init(style: .default, reuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
