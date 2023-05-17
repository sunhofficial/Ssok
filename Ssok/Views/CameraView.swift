//
//  CameraView.swift
//  Ssok
//
//  Created by 김용주 on 2023/05/16.
//

import SwiftUI

struct CameraView: View {
    
    @State var arstate : String = ""
    @Binding var sta: Bool
    
    var body: some View {
        ZStack{
            MissionSmileView(ARstate: arstate)
                .onDisappear{
                    sta = true
                }
        }
    }
}

//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}
