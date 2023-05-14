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
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, y: 4)
    }
}

struct WhiteRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        WhiteRectangleView()
    }
}
