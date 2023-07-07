//
//  BottleView.swift
//  6Bubbles
//
//  Created by CHANG JIN LEE on 2023/05/04.
//

import SwiftUI
import SpriteKit

struct BottleView: View {

    var scene = Bottle(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    var body: some View {
        ZStack {
            SpriteView(
                scene: scene,
                options: [.allowsTransparency],
                shouldRender: {_ in return true}
            )
            .ignoresSafeArea().frame(width: wid, height: hei).aspectRatio(contentMode: .fit).offset(y: 17)
        }
        .ignoresSafeArea(.all)
    }
}

struct BottleView_Previews: PreviewProvider {

    static var previews: some View {
        BottleView()
    }
}
