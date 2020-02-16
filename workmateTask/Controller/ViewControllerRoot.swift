//
//  ViewControllerRoot.swift
//  workmateTask
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import UIKit

class ViewControllerRoot: UIViewController {

    class func get() -> ViewControllerRoot {
           let rootView = ViewControllerRoot(nibName: "ViewControllerRoot", bundle: nil)
            print("rootView  ready")
           return rootView
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationCtrl()


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
    func setupNavigationCtrl() -> Void {
           self.navigationItem.title = "Time Sheet "
           
       }
}
