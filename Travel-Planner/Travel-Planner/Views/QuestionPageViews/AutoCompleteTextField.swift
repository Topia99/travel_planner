//
//  AutoCompleteTextField.swift
//  TravelPlanner
//
//  Created by siye yang on 9/24/24.
//

import SwiftUI

struct AutoCompleteTextField: View {
    @Binding var text: String
    var suggestions: [String]
    var onSelection: (String) -> Void

    @State private var filteredSuggestions: [String] = []
    @State private var showSuggestions: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField("Destination", text: $text)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onChange(of: text) { newValue in
                    filterSuggestions()
                }
                .onTapGesture {
                    self.showSuggestions = true
                }

            if showSuggestions && !filteredSuggestions.isEmpty {
                VStack(alignment: .leading, spacing: 0) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(filteredSuggestions, id: \.self) { suggestion in
                                Button(action: {
                                    selectSuggestion(suggestion)
                                }) {
                                    Text(suggestion)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .buttonStyle(PlainButtonStyle())
                                Divider()
                            }
                        }
                    }
                    .frame(maxHeight: 150) // Adjust as needed
                }
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5))
                )
                .transition(.opacity)
                .animation(.default, value: filteredSuggestions)
            }
        }
        .zIndex(1) // Ensure the suggestion list appears above other content
    }

    private func filterSuggestions() {
        if text.isEmpty {
            filteredSuggestions = []
            showSuggestions = false
        } else {
            filteredSuggestions = suggestions.filter {
                $0.lowercased().hasPrefix(text.lowercased())
            }
            showSuggestions = !filteredSuggestions.isEmpty
        }
    }

    private func selectSuggestion(_ suggestion: String) {
        text = suggestion
        onSelection(suggestion)
        // Delay hiding the suggestion list slightly to ensure the tap gesture completes
        DispatchQueue.main.async {
            self.filteredSuggestions = []
            self.showSuggestions = false
        }
    }
}
