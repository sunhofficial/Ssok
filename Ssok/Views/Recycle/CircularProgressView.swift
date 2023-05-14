//
//  CircularProgressView.swift
//  Ssok
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI

struct CircularProgressView: View {
    
    // MARK: - Properties
    
    @State var progress: Float = 30.0
    @State var limit: Float = 70.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .foregroundColor(Color("Gray"))
            Circle()
                .trim(from: 0.0, to: CGFloat(progress / limit))
                .stroke(style: StrokeStyle(lineWidth: 25.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("Bg_bottom2"))
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView()
    }
}
