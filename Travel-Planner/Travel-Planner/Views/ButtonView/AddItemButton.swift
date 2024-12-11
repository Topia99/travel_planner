//
//  AddItemButton.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/13/24.
//

import SwiftUI

struct AddItemButton: View {
    var body: some View {
        ZStack {
            BlurView(style: .systemUltraThinMaterial)
                .cornerRadius(8)
                .frame(height: 45)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.1))
                )
            
            Text("Add Activity")
                .foregroundColor(Color.white)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, minHeight: 45, maxHeight: 45)
    }
}

#Preview {
    AddItemButton()
}
