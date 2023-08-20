//
//  ProgressBar.swift
//  pokemon
//
//  Created by Argana Phangquestian on 20/08/23.
//

import SwiftUI

struct ProgressBar: View {
    let value: Int
    let width: CGFloat
    let color: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle().frame(width: width, height: 4)
                .opacity(0.3)
                .foregroundColor(color)
            Rectangle().frame(width: width/100*CGFloat(value), height: 4)
                .foregroundColor(color)
        }.cornerRadius(45.0)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 69, width: 250, color: .pink)
    }
}
