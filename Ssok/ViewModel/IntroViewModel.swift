//
//  IntroControl.swift
//  6Bubbles
//
//  Created by CHANG JIN LEE on 2023/05/04.
//

import Foundation
import SwiftUI

class IntroViewModel: ObservableObject {

    @Published var selectedPage = 0
    @Published var isFirst = false
    @Published var path = NavigationPath()
    @AppStorage("Tutorial") var isIntroActive = true

    func setPageLast() {
        isIntroActive = false
        path.append(ViewType.addMemberView)
    }
}
