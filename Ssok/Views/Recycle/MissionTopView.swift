//
//  DecibelView.swift
//  Ssok
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI

struct MissionTopView: View {
    
    // MARK: - Properties
    
    @State var title: String
    @State var description: String
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ZStack {
                Image("Ellipse")
                    .resizable()
                    .frame(width: wid, height: 180)
                VStack(spacing: 4) {
                    HStack {
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 20, height: 20)
                        }
                        Spacer()
                        Text(title)
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold))
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.clear)
                                .bold()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 56)
                    Text(description)
                        .foregroundColor(.white)
                        .font(.system(size: 13, weight: .semibold))
                }
            }
            .ignoresSafeArea()
            
            Spacer()
        }
    }
}

struct MissionTopView_Previews: PreviewProvider {
    static var previews: some View {
        MissionTopView(title: "따라읽기", description: "주어진 문장을 정확하게 따라 읽어서 인식시켜요")
    }
}
