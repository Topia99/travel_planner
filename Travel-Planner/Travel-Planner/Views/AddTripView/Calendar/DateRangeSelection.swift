//
//  DateRangeSelection.swift
//  Travel-Planner
//
//  Created by sam yang on 12/1/24.
//

import SwiftUI

struct DateRangeSelection: View {
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    @Binding var isCalendarVisible: Bool
    let calendar: Calendar
    

    var body: some View {
        Section(header: Text("Select Date Range")) {
            Button(action: {
                withAnimation {
                    isCalendarVisible.toggle()
                }
            }) {
                HStack {
                    Text("Date")
                    Spacer()
                    if let startDate = startDate, let endDate = endDate {
                        if calendar.isDate(startDate, inSameDayAs: endDate) {
                            Text("\(DateUtils.formattedDate(startDate))")
                                .foregroundColor(.blue)
                        } else {
                            Text("\(DateUtils.formattedDateRange(start: startDate, end: endDate))")
                                .foregroundColor(.blue)
                        }
                    } else {
                        Text("Select Date Range")
                            .foregroundColor(.gray)
                    }
                }
            }

            if isCalendarVisible {
                CustomCalendarView(startDate: $startDate, endDate: $endDate)
                    .frame(height: 400)
            }
        }
    }
}
