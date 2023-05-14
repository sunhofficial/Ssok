//
//  MissonTitleView.swift
//  Ssok
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI

struct MissonTitleView: View {
    
    @State var missonTitle: String
    @State var backgroundColor: Color
    @State var borderColor: Color
    
    var body: some View {
        
        Text(missonTitle)
            .font(.system(size: 20, weight: .semibold))
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(backgroundColor.cornerRadius(15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(borderColor, lineWidth: 1.5)
            )
    }
}

struct MissonTitleView_Previews: PreviewProvider {
    static var previews: some View {
        MissonTitleView(missonTitle: "소리 지르기 💥", backgroundColor: Color("MissonOrange"), borderColor: Color("MissonOrangeBorder"))
    }
}
