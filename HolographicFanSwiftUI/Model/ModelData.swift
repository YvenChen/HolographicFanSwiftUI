//
//  ModelData.swift
//  HolographicFanSwiftUI
//
//  Created by Yven Chen on 2023/4/6.
//

import SwiftUI

final class ModelData: ObservableObject {
    var fanBlades: [[Lamp]]
    
    var polygon: [CGPoint]
    
    init() {
        self.fanBlades = .init(repeating: .init(repeating: Lamp(id: ""), count: 50), count: 11)
        self.polygon = []
        initFanBlades()
        initPolygon()
    }
    
    /**
        初始化所有灯珠
     */
    private func initFanBlades() {
        for i in 0..<fanBlades.count {
            for j in 0..<fanBlades[i].count {
                fanBlades[i][j].id = "\(i + 1)-\(j + 1)"
            }
        }
    }
    
    /**
        初始化一个多边形
     */
    private func initPolygon() {
        polygon = [
            .init(x: -80, y: 0),
            .init(x: -20, y: 80),
            .init(x: -20, y: 20),
            .init(x: 80, y: 20),
            .init(x: 80, y: -20),
            .init(x: -20, y: -20),
            .init(x: -20, y: -80)
        ]
    }
}
