//
//  AppDelegate.swift
//  Ssok
//
//  Created by CHANG JIN LEE on 2023/05/13.
//

import UIKit
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Create the SwiftUI view that provides the window contents.
        let smileView = MissionSmileView()

        // Use a UIHostingController as window root view controller.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: smileView)
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}
