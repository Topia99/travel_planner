//
//  SwiftUIView.swift
//  Travel-Planner
//
//  Created by siye yang on 10/2/24.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        NavigationView{
            
            ZStack(alignment: .bottomLeading) {
                        Text("trips")
                            .frame(height: 200)
                            .cornerRadius(15)
                            .clipped()
                        
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("trips")
//                                .font(.title)
//                                .bold()
//                                .foregroundColor(.white)
//                            
//                            Text("trips")
//                                .font(.subheadline)
//                                .foregroundColor(.white.opacity(0.7))
//                            
//                            HStack {
//                                HStack(spacing: 5) {
//                                    Image(systemName: "heart.fill")
//                                        .foregroundColor(.white)
//                                    Text("trips")
//                                        .foregroundColor(.white)
//                                }
//                                
//                                Spacer()
//                                
//                                HStack(spacing: 5) {
//                                    Image(systemName: "airplane")
//                                        .foregroundColor(.white)
//                                    Text("trips")
//                                        .foregroundColor(.white)
//                                }
//                            }
//                        }
//                        .padding()
                    }
//                    .background(Color.black.opacity(0.3))
//                    .cornerRadius(15)
//                    .shadow(radius: 10)
                    .navigationTitle("Trips")
        }
        
        
        
    }
}

#Preview {
    SwiftUIView()
}
