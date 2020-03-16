//
//  ViewControllerRoot.swift
//  workmateTask
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import UIKit
import Foundation

class ViewControllerRoot: UIViewController {
    
    
    @IBOutlet weak var positionName: UILabel!
    @IBOutlet weak var titleCo: UILabel!
    @IBOutlet weak var wageAmt: UILabel!
    @IBOutlet weak var wageTyp: UILabel!
    @IBOutlet weak var locationADDs: UILabel!
    @IBOutlet weak var managerName: UILabel!
    @IBOutlet weak var mangerPhn: UILabel!
    @IBOutlet weak var ClockBtnStatus: CircleButton!
    @IBOutlet weak var clockInLbl: UILabel!
    @IBOutlet weak var cloclkOutLbl: UILabel!
    
    
    let ViewModel = ViewRootModel()
    //    let progViewModel = ProgressViewModel()
    
    class func get() -> ViewControllerRoot {
        let rootView = ViewControllerRoot(nibName: "ViewControllerRoot", bundle: nil)
        print("rootView  ready")
        return rootView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewModel.rootViewDelegate = self
        //        progViewModel.CheckInOutDeleget = self
        
        if !CommonDatas.ClockStatus  {
            print("check -->  : \(CommonDatas.ClockStatus)" )
            self.ClockBtnStatus.setTitle("ClockIn", for: .normal)
        }else{
            print("check -->  : \(CommonDatas.ClockStatus)" )
            self.ClockBtnStatus.setTitle("ClockOut", for: .normal)
        }
        SampleCheckREsp()
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
        Vc.btnStatus = CommonDatas.ClockStatus
        Vc.ClockDelegate = self
        self.present(Vc, animated: true, completion: { ()-> Void in
            print("present open ")
        })
    }
    func setupNavigationCtrl() -> Void {
        self.navigationItem.title = "Time Sheet "
    }
    
    
    
    func SampleCheckREsp() -> Void {
//    let url = URL(string: "https://httpbin.org/get")!
         let url = URL(string: "http://www.mocky.io/v2/5e6f126b3300009b1df0766b")!
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("error: \(error)")
        } else {
            if let response = response as? HTTPURLResponse {
                print("statusCode: \(response.statusCode)")
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                   let Mytechdetails = try? JSONDecoder().decode(Techdetails1.self, from: data) as Techdetails1

                print("Mytechdetails: \(Mytechdetails! )")
            }
        }
    }
    task.resume()
    }
}

extension ViewControllerRoot : getDetailsTechInfoDelegate {
    func TechInfoServiceDetails(infoTech: Techdetails) {
        print(infoTech)
        
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

extension ViewControllerRoot : mainDataReturnINOUTDelegate {
    
    
    
    func clockInData(ClockIN: [String : Any]?) {
        print(ClockIN ?? "data")
        
        self.ClockBtnStatus.setTitle("CheckOut", for: .normal)
        CommonDatas.ClockStatus = !CommonDatas.ClockStatus
        guard let INTimeS = ClockIN   else {
            return
        }
        guard let INTime = INTimeS["clockIn"]   else {
            return
        }
        print( UTCToLocal(date: INTime as! String))
        self.clockInLbl.text = UTCToLocal(date: INTime as? String ?? "-")
        
        guard let OUTTime = INTimeS["clockOut"] else {
            return
        }
        print( UTCToLocal(date: OUTTime as! String))
        self.cloclkOutLbl.text = UTCToLocal(date: OUTTime as? String ?? "-")
    }
    
    func clockOutData(ClockOUT: [String : Any]?) {
        print(ClockOUT ?? "data")
        CommonDatas.ClockStatus = !CommonDatas.ClockStatus
        self.ClockBtnStatus.setTitle("CheckIN", for: .normal)
        
        guard let OUTTimeS = ClockOUT   else {
            return
        }
        guard let Outime = OUTTimeS["clockIn"]   else {
            return
        }
        print( UTCToLocal(date: Outime as! String))
        self.clockInLbl.text = UTCToLocal(date: Outime as? String ?? "-")
        guard let Outimes = OUTTimeS["clockOut"] else {
            return
        }
        print( UTCToLocal(date: Outimes as! String))
        self.cloclkOutLbl.text = UTCToLocal(date: Outimes as? String ?? "-")
        
        
    }
    
    func UTCToLocal(date:String) -> String {
        if date == "" {
            return "-"
        }else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            
            let dt = dateFormatter.date(from: date)
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: dt!)
        }
    }
    func ErrorMsg(mssg: String) {
        if mssg == "400"{
            if CommonDatas.ClockStatus {
                //you can already clocked In
                UIAlertController.show("you can already clocked Out", from: self)
            }else {
                UIAlertController.show("you can already clocked In", from: self)
            }
        }
    }
}
