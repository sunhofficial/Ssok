//
//  ProgressbarView.swift
//  Ssok
//
//  Created by 김용주 on 2023/05/14.
//

import SwiftUI

struct ProgressbarView: View {
    
    @State var progress = 0.3
    
    var body: some View {
        ZStack{
            
            Circle().stroke(lineWidth: 20).opacity(0.2)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(lineWidth: 20)
                .rotationEffect(Angle(degrees: 270))
        }
    }
}

struct ProgressbarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressbarView()
    }
}
