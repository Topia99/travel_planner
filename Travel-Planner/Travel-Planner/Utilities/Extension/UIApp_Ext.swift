//
//  UIApp_Ext.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/8/24.
//

import SwiftUI

extension UIApplication {
    // A helper method to dismiss the keyboard
    func endEditing(_ force: Bool = false) {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
