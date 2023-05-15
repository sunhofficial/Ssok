//
//  CircularProgressView.swift
//  Ssok
//
//  Created by 김민 on 2023/05/14.
//

import SwiftUI

struct CircularProgressView: View {
    
    // MARK: - Properties
    
    @State var progress: Float
    @State var limit: Float = 100.0
    @State var progressColor: Color = Color("Bg_bottom2")
    
    var body: some View {
        
//                        .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: -4)
        
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 25.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("Gray"))
                .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: -2)
            Circle()
                .trim(from: 0.0, to: CGFloat(progress/100.0))
                .stroke(style: StrokeStyle(lineWidth: 25.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(progressColor)
        }
//        .onChange(of: progress){ value in
//            print(value)
//            if value <= 50.0 && value > 25.0 {
//                progressColor = Color(.blue)
//            }
//            else if value <= 75.0 && value > 50.0 {
//                progressColor = Color(.red)
//            }
//            else if value <= 100.0 && value > 75.0 {
//                progressColor = Color(.yellow)
//            }
//        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 1.0)
    }
}
