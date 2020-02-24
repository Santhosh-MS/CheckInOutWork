//
//  ButtonUtility.swift
//  workmateTask
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import UIKit

@IBDesignable class CircleButton : UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        self.backgroundColor  = UIColor.white
        self.setTitleColor(UIColor.lightGray, for: .normal)
        layer.shadowColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.5
        layer.borderWidth = 13
        layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        layer.shadowOffset = CGSize(width: 0, height: 0)
        
        //        layer.masksToBounds = true
        //        clipsToBounds = true
        //        myButton.setTitle("Clockin", for: .normal)
        //        layer.cornerRadius = 75
        
    }
}

extension UIAlertController {
    static func show(_ message: String, from viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}


