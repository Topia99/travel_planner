//
//  ItemAccommodationView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/2/24.
//
//
//import SwiftUI
//
//struct ItemAccommodationView: View {
//    
//    
//    @Binding var item: AccommodationItem
//    
////    var hotelName: String
////    var checkInDate: Date?
////    var checkOutDate: Date?
////    var time: String
////    var location: String = ""
////    var description: String = ""
//    
//    var body: some View {
//        VStack (alignment: .leading){
//            
//            // Activity heading
//            HStack() {
//                // Activity Symbol
//                Image(systemName: "house.circle.fill")
//                    .resizable()
//                    .symbolRenderingMode(.palette)
//                    .foregroundStyle(.white, .cyan)
//                    .frame(width: 30, height: 30)
//                
//                // Activity Title
//                Text(item.title)
//                    .font(.title3)
//                    .fontWeight(.semibold)
//                    .padding(.leading, 3)
//                
//                Spacer()
//                
//                if let checkInTime = item.time {
//                    Text("Check-In:")
//                    Text(checkInTime)
//                }
//            }
//            .font(.headline)
//            
//            
//            VStack (alignment: .leading) {
//                
//                
//                // CheckIn date and CheckOut date
//                if let checkInDate = item.checkInDate, let checkOutDate = item.checkOutDate {
//            
//                    HStack{
//                        Text(DateUtilities.formattedDate_WeekDay_Date(checkInDate))
//                            .font(.footnote)
//                            .fontWeight(.medium)
//                        HorizontalLine()
//                        Text(DateUtilities.formattedDate_WeekDay_Date(checkOutDate))
//                            .font(.footnote)
//                            .fontWeight(.medium)
//                    }
//                }
//                
//                if let location = item.location {
//                    Text("📍\(location)")
//                        .font(.subheadline)
//                        .fixedSize(horizontal: false, vertical: true)
//                        .padding(.top, 2)
//                }
//                
//                if let description = item.description {
//                    Text(description)
//                        .font(.body)
//                        .fixedSize(horizontal: false, vertical: true)
//                        .padding(.top, 2)
//                }
//            }
//        }
//        .padding()
//        .frame(width: 350)
//        .background(
//            RoundedRectangle(cornerRadius: 10)
//                .fill(.white)
//                .opacity(0.5)
//                .shadow(radius: 2)
//            )
//    }
//}
//
