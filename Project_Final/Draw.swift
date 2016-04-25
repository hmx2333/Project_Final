//
//  Draw.swift
//  Project_Final
//
//  Created by haha on 16/4/21.
//  Copyright © 2016年 haha. All rights reserved.
//

import UIKit

class Draw: UIView {
    
    

    override func drawRect(rect: CGRect) {
        _ = UIGraphicsGetCurrentContext()
        let backGround_1 = UIImage( named: "Back1.jpg")
        let entireScreen = UIScreen.mainScreen().bounds
        backGround_1?.drawInRect(entireScreen)
    }
   
}
