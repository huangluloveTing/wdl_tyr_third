//
//  PersonSettingVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/3.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class PersonSettingVC: NormalBaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let settingTitles = ["修改密码","修改手机号","关于织布鸟","联系客服"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension PersonSettingVC {
    
    func configTableView() -> Void {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "infoCell")
    }
}

extension PersonSettingVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell");
        if section == 0 {
            cell?.textLabel?.text = settingTitles[row]
            cell?.detailTextLabel?.text = ""
            cell?.textLabel?.textColor = UIColor(hex: "333333")
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel?.textAlignment = .left
        }
        if section == 1 {
            cell?.accessoryType = .none
            cell?.textLabel?.text = "退出登录"
            cell?.textLabel?.textColor = UIColor(hex: "06C06F")
            cell?.textLabel?.textAlignment = .center
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
        }
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        return settingTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 20
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            self.loginOutHanle()
        }
        else {
            let row = indexPath.row
            if row == 0 {
                self.modifyPassword()
            }
            if row == 1 {
                self.modifyPhone()
            }
            if row == 2 {
                self.toZbnIntroduction()
            }
            if row == 3 {
                self.linkService()
            }
        }
    }
}

//MARK: - Handles
extension PersonSettingVC {
    
    // 退出登录
    func loginOutHanle() -> Void {
        AlertManager.showTitleAndContentAlert(context:self, title: "提示", content: "是否退出登录") { (index) in
            if index == 1 {
                let loginVC = LoginVC()
                let naviVC = UINavigationController(rootViewController: loginVC)
                WDLCoreManager.shared().userInfo = nil
                self.tabBarController?.selectedIndex = 0
                self.present(naviVC, animated: true, completion: nil)
                self.pop(toRootViewControllerAnimation: false)
            }
        }
    }
    
    // 修改密码
    func modifyPassword() -> Void {
        let modify = ModityPasswordVC()
        self.push(vc: modify, title: "修改密码")
    }
    
    // 修改手机号码
    func modifyPhone() -> Void {
        let modify = ModifyPhoneVC()
        self.push(vc: modify, title: "修改手机号码")
    }
    
    // 关于织布鸟
    func toZbnIntroduction() -> Void {
        let about = AboutZbnVC()
        self.push(vc: about, title: "关于织布鸟")
    }
    // 联系客服
    func linkService() -> Void {
        self.toLinkKF()
    }
}
