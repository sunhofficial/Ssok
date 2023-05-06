//
//  ViewExtension.swift
//  6Bubbles
//
//  Created by 235 on 2023/05/06.
//

import SwiftUI
extension View {
    
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
