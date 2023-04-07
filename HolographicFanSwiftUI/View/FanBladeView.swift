//
//  FanBladeView.swift
//  HolographicFanSwiftUI
//
//  Created by Yven Chen on 2023/4/6.
//

import SwiftUI

struct FanBladeView: View {
    var lamps: [Lamp]
    var angle: Angle
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(lamps.enumerated()), id: \.element) { index, element in
                LampView(lamp: element, radius: Double(20 + index * 2), angle: angle)
            }
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .background {
            Capsule(style: .circular)
        }
    }
}

struct FanBladeView_Previews: PreviewProvider {
    static var previews: some View {
        FanBladeView(lamps: [
            .init(id: "1-1"),
            .init(id: "1-2"),
            .init(id: "1-3"),
            .init(id: "1-4"),
            .init(id: "1-5"),
            .init(id: "1-6"),
            .init(id: "1-7"),
            .init(id: "1-8"),
            .init(id: "1-9"),
            .init(id: "1-10")
        ], angle: .degrees(72))
        .offset(x: 80, y: 0)
        .rotationEffect(.degrees(72))
    }
}
