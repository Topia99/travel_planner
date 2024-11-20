//
//  DateCapsuleView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import SwiftUI

struct DateCapsuleView: View {
    
    var date: Date
    var isSelected: Bool
    
    var body: some View {
        Text(DateUtils.formattedDate(date))
            .font(.system(size: 18))
            .fontWeight(.semibold)
            .frame(width: 145, height: 35)
            .background(isSelected ? Color.brandPrimary : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(100)
            .padding(3)
    }
}

#Preview {
    DateCapsuleView(date: Date.now,
                    isSelected: true)
}
