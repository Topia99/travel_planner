//
//  AddItemButton.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/13/24.
//

import SwiftUI

struct AddItemButton: View {
    var body: some View {
        Text("Add Activity")
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 300, height: 50)
            .background(Color.brandPrimary)
            .foregroundColor(.white)
            .cornerRadius(10.0)
    }
}

#Preview {
    AddItemButton()
}
