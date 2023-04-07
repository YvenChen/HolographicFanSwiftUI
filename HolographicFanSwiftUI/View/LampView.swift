//
//  LampView.swift
//  HolographicFanSwiftUI
//
//  Created by Yven Chen on 2023/4/6.
//

import SwiftUI

struct LampView: View {
    @EnvironmentObject var modelData: ModelData
    
    var lamp: Lamp
    
    var radius: Double
    var angle: Angle
    
    private var cartesian: CGPoint {
        polarToCartesian()
    }
    
    var body: some View {
        Circle()
            .frame(width: 2, height: 2)
            .foregroundColor(pointInPolygon(point: cartesian, polygon: modelData.polygon) ? .red : .white.opacity(0.2))
    }
}

extension LampView {
    /**
        极坐标转为直角坐标
     */
    private func polarToCartesian() -> CGPoint {
        let x = radius * cos(angle.radians)
        let y = radius * sin(angle.radians)
        return .init(x: x, y: y)
    }
    
    /**
        使用 Winding Number（环绕数）判断点是否在多边形内
     */
    private func pointInPolygon(point: CGPoint, polygon: [CGPoint]) -> Bool {
        
        func isLeft(_ p1: CGPoint, _ p2: CGPoint, _ p3: CGPoint) -> CGFloat {
            return ((p2.x - p1.x) * (p3.y - p1.y) - (p3.x - p1.x) * (p2.y - p1.y))
        }
        
        var windingNumber = 0
        for i in 0..<polygon.count {
            let p1 = polygon[i]
            let p2 = polygon[(i + 1) % polygon.count]
            if p1.y <= point.y {
                if p2.y > point.y && isLeft(p1, p2, point) > 0 {
                    windingNumber += 1
                }
            } else {
                if p2.y <= point.y && isLeft(p1, p2, point) < 0 {
                    windingNumber -= 1
                }
            }
        }
        
        if windingNumber != 0 {
            return true //点在多边形内部
        } else {
            return false //点在多边形外部
        }
    }
}

struct LampView_Previews: PreviewProvider {
    static var previews: some View {
        LampView(lamp: .init(id: "1-1"), radius: 80, angle: .degrees(0))
    }
}
