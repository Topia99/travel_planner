//
//  ItemViewModel.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/3/24.
//

import SwiftUI

final class ItemViewModel: ObservableObject, Identifiable {
    @Published var item: Item
    
    var id: UUID {
        item.id
    }
    
    init(item: Item) {
        self.item = item
    }
}
