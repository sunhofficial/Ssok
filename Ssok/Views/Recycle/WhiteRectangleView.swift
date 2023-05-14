//
//  WhiteRectangleView.swift
//  Ssok
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI

struct WhiteRectangleView: View {
    var body: some View {
        Rectangle()
            .fill(.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.25), radius: 4, y: 4)
    }
}

struct WhiteRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        WhiteRectangleView()
    }
}
