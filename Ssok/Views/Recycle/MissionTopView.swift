//
//  DecibelView.swift
//  Ssok
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI

struct MissionTopView: View {

    @State var title: String
    @State var description: String
    @EnvironmentObject var arViewModel: ARViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        ZStack(alignment: .top) {
            Image("imgEllipse")
                .resizable()
                .frame(width: UIScreen.screenWidth, height: UIScreen.getHeight(160))
                .ignoresSafeArea()
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
                            .frame(width: UIScreen.getWidth(20), height: UIScreen.getWidth(20))
                    }
                    Text(title)
                        .font(Font.custom24black())
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding(.trailing,UIScreen.getWidth(20))
                }
                .padding(.horizontal, UIScreen.getWidth(16))
                .padding(.top, UIScreen.getHeight(16))
                Text(description)
                    .foregroundColor(.white)
                    .font(Font.custom13semibold())
            }
        }
    }
}

struct MissionTopView_Previews: PreviewProvider {
    static var previews: some View {
        MissionTopView(title: "따라읽기", description: "주어진 문장을 정확하게 따라 읽어서 인식시켜요")
    }
}
