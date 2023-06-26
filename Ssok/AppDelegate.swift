//
//  AppDelegate.swift
//  Ssok
//
//  Created by CHANG JIN LEE on 2023/05/13.
//

import UIKit
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {
    @Binding var state: Bool
    var window: UIWindow?

    init(state: Binding<Bool>){
        self._state = state
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let smileView = MissionSmileView(state: $state)

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: smileView)
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}
