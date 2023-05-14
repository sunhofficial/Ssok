//
//  DecibelView.swift
//  Ssok
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI

struct MissonTopView: View {
    
    // MARK: - Properties
    
    @State var title: String
    @State var description: String
    @State var iconImage: String
    
    var body: some View {
        VStack {
            ZStack {
                Image("Ellipse")
                    .frame(width: 390, height: 168)
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold))
                        
                        Text(description)
                            .foregroundColor(.white)
                            .font(.system(size: 13, weight: .semibold))
                    }
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 50, height: 50)
                        Text(iconImage)
                            .font(.system(size: 24))
                    }
                }
                .padding([.leading, .trailing], 20)
            }
            .ignoresSafeArea()
            
            Spacer()
        }
    }
}

struct MissonTopView_Previews: PreviewProvider {
    static var previews: some View {
        MissonTopView(title: "데시벨 측정기", description: "미션을 성공하려면 데시벨을 충족시켜야해요", iconImage: "📢")
    }
}
