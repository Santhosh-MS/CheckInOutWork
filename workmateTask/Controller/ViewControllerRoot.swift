//
//  ViewControllerRoot.swift
//  workmateTask
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import UIKit

class ViewControllerRoot: UIViewController {
    
    
    @IBOutlet weak var positionName: UILabel!
    @IBOutlet weak var titleCo: UILabel!
    @IBOutlet weak var wageAmt: UILabel!
    @IBOutlet weak var wageTyp: UILabel!
    @IBOutlet weak var locationADDs: UILabel!
    @IBOutlet weak var managerName: UILabel!
    @IBOutlet weak var mangerPhn: UILabel!
    
    
    let ViewModel = ViewRootModel()
    class func get() -> ViewControllerRoot {
        let rootView = ViewControllerRoot(nibName: "ViewControllerRoot", bundle: nil)
        print("rootView  ready")
        return rootView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewModel.rootViewDelegate = self
        setupNavigationCtrl()
        ViewModel.getLoginDetails()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func actionCheckInOut(_ sender: Any) {
        
        let Vc =  ProgressController.get()
        self.present(Vc, animated: true, completion: { ()-> Void in
            print("present open ")
        })
    }
    func setupNavigationCtrl() -> Void {
        self.navigationItem.title = "Time Sheet "
    }
    
}

extension ViewControllerRoot : getDetailsTechInfoDelegate {
    func TechInfoServiceDetails(infoTech: Techdetails) {
        
        
        guard let name = infoTech.position.name,let Location = infoTech.location.address.street_1,let title = infoTech.title,let amount = infoTech.wage_amount,let amountType = infoTech.wage_type,let managerName = infoTech.manager.name,let phoneNumaber = infoTech.manager.phone  else{
            return
        }
        print("Name : \(name)")
        positionName.text = name;
        print("Name : \(title)")
        titleCo.text = title
        print("Name : \(Location)")
        locationADDs.text = Location
        print("Name : \(amount)")
        wageAmt.text = amount
        print("Name : \(amountType)")
        wageTyp.text = amountType
        print("ManagerName  :\(managerName)")
        self.managerName.text = managerName
        print("ManagerName  :\(phoneNumaber)")
        self.mangerPhn.text = phoneNumaber
    }
    
    
}
