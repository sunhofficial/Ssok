//
//  MissionDescriptionView.swift
//  Ssok
//
//  Created by 김민 on 2023/06/24.
//

import SwiftUI

struct MissionTypeView: View {
    let title: String
    let description: String

    var body: some View {
        VStack(spacing: UIScreen.getHeight(4)) {
            Text(title)
                .font(Font.custom24black())
            Text(description)
                .font(Font.custom13semibold())
        }}
}

struct MissionDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionTypeView(title: "", description: "")
    }
}
