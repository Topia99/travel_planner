//
//  TextFieldStyle.swift
//  Travel-Planner
//
//  Created by siye yang on 10/14/24.
//


import SwiftUI

struct StarbucksTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.brandPrimary.opacity(0.3), lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    )
            )
            .padding(.horizontal)
           
    }
}
