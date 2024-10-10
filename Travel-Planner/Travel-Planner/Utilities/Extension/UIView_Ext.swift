//
//  UIView_Ext.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/8/24.
//

import SwiftUI

extension UIView{
    
    // Dismiss keyboard when tap outside of the textField
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
    }
}
