//
//  VerticalLine.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/1/24.
//

import SwiftUI

struct VerticalLine: View {
    var body: some View {
        //Vertical Line in HStack
        HStack{
            Color.gray.frame(width: 1 / UIScreen.main.scale)
        }
    }
}

#Preview {
    VerticalLine()
}
