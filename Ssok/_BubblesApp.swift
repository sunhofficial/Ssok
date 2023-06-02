//
//  _BubblesApp.swift
//  6Bubbles
//
//  Created by CHANG JIN LEE on 2023/05/03.
//

import SwiftUI

@main
struct _BubblesApp: App {
    var body: some Scene {
        WindowGroup {
            IntroView()
                .environmentObject(RandomMember())
        }
    }
}
