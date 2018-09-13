//
//  ForgetPwdVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxCocoa

class ForgetPwdVC: NormalBaseVC {

    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func currentConfig() {
        self.saveButton.addBorder(color: nil)
    }

    
    override func bindViewModel() {
        self.saveButton.rx.tap.asObservable()
            .subscribe(onNext: { () in
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: dispose)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
