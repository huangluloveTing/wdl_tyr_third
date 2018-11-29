//
//  ConsignorAuthedVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/2.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class ConsignorAuthedVC: NormalBaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    public var zbnConsignor:ZbnConsignor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
        self.registerAllCells()
        self.configRightNavigationBar()
    }
    
    override func zt_rightBarButtonAction(_ sender: UIBarButtonItem!) {
        self.toCarriorAth(consignor: zbnConsignor, title:"变更认证信息")
    }
}

//MARK: - config
extension ConsignorAuthedVC {
    
    func configTableView() -> Void {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
    }
    
    func registerAllCells() -> Void {
        self.registerCell(nibName: "\(EnterpriseInfoCell.self)", for: tableView)
        self.registerCell(nibName: "\(LegalPeronInfoCell.self)", for: tableView)
    }
    
    func configRightNavigationBar() -> Void {
        self.addRightBarbuttonItem(withTitle: "申请变更")
    }
}

//MARK: - UITableViewDelegate , UITableViewDataSource
extension ConsignorAuthedVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(EnterpriseInfoCell.self)") as! EnterpriseInfoCell
            cell.showEnterpriceInfo(name: zbnConsignor?.companyName,
                                    intro: zbnConsignor?.companyAbbreviation,
                                    linkName: zbnConsignor?.consignorName,
                                    address: zbnConsignor?.officeAddress,
                                    lienceCode: zbnConsignor?.businessLicenseNo,
                                    lienceImage: zbnConsignor?.businessLicense)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(LegalPeronInfoCell.self)") as! LegalPeronInfoCell
        cell.showLegalPersonInfo(legalName: zbnConsignor?.legalPerson,
                                 id: zbnConsignor?.legalPersonId,
                                 idMainImage: zbnConsignor?.legalPersonIdFrontage,
                                 idOppositeImage: zbnConsignor?.legalPersonIdOpposite)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
}
