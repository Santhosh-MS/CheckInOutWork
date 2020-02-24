//
//  ProgressController.swift
//  workmateTask
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import UIKit

protocol  mainDataReturnINOUTDelegate {
    func clockInData(ClockIN : [String : Any]?) -> Void
    func clockOutData(ClockOUT: [String : Any]?) -> Void
    func ErrorMsg(mssg : String) -> Void
}

class ProgressController: UIViewController {
    
    @IBOutlet weak var checkLbl: UILabel!
    
    @IBOutlet weak var prograssBar: UIProgressView!
    
    @IBOutlet weak var progressBtn: UIButton!
    
    var progressBarTimer : Timer!
    var ViewModel = ProgressViewModel()
    var ClockDelegate : mainDataReturnINOUTDelegate?
    var btnStatus : Bool?
    
    class func Present(){
        let progressViewCtrl = ProgressController(nibName: "ProgressController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: progressViewCtrl)
        UIApplication.shared.keyWindow?.rootViewController?.present(
            navigationController, animated: true, completion: nil)
    }
    class func get() -> ProgressController{
        let progressViewCtrl = ProgressController(nibName: "ProgressController", bundle: nil)
        return progressViewCtrl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewModel.CheckInOutDeleget = self
        
        if CommonDatas.ClockStatus {
            self.checkLbl.text = "Checking Out"
        }else{
            self.checkLbl.text = "Checking In"
        }
        progressBtn.addTarget(self, action: #selector(clacelBtnaction), for:.touchUpInside)
        setUPProgressBar()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func  setUPProgressBar() -> Void {
        
        prograssBar.progress = 0.0
        prograssBar.transform =  prograssBar.transform.scaledBy(x: 1, y: 8)
        prograssBar.progressTintColor = UIColor.white
        prograssBar.progressViewStyle = .bar
        prograssBar.layer.cornerRadius = 10
        prograssBar.clipsToBounds = true
        prograssBar.layer.sublayers![1].cornerRadius = 10
        prograssBar.subviews[1].clipsToBounds = true
        
        self.progressBarTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateProgressView), userInfo: nil, repeats: true)
        
    }
    @objc func clacelBtnaction() -> Void{
        progressBarTimer.invalidate()
        self.presentingViewController?.dismiss(animated: true, completion:{ () -> Void in
            
            
        })
    }
    
    @objc func updateProgressView(){
        prograssBar.progress += 0.01
        //          print("progress count  --> \(prograssBar.progress)")
        prograssBar.setProgress(prograssBar.progress, animated: true)
        if prograssBar.progress == 1.0 {
            progressBarTimer.invalidate()
            self.dismiss(animated: true, completion: { () -> Void in
                print("present close : ")
                print("Clock Status : \(CommonDatas.ClockStatus)")
                self.ViewModel.sendCheckInCheckOutStatus(status : CommonDatas.ClockStatus )
            })
        }
    }
}

extension ProgressController : TimeReturnDelegate {
    func errorMessage(msg: String) {
        self.ClockDelegate?.ErrorMsg(mssg : msg)
    }
    
    func timeRetunsChekin(times: [String : Any]?) {
        self.ClockDelegate?.clockInData(ClockIN: times)
    }
    
    func timeRerurnsCheckOut(times: [String : Any]?) {
        self.ClockDelegate?.clockOutData(ClockOUT: times)
    }
}
