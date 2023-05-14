//
//  MissonDecibelView.swift
//  Ssok
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI

struct MissonDecibelView: View {
    var body: some View {
        
        VStack {
            MissonTopView(title: "데시벨 측정기", description: "미션을 성공하려면 데시벨을 충족시켜야 해요", iconImage: "📢")
        }
    }
}

struct MissonDecibelView_Previews: PreviewProvider {
    static var previews: some View {
        MissonDecibelView()
    }
}
