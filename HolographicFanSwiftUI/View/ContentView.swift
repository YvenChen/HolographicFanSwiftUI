//
//  ContentView.swift
//  HolographicFanSwiftUI
//
//  Created by Yven Chen on 2023/4/6.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    
    private let repeatTimer = RepeatTimer()
    private var fps: Double = 60
    
    @State private var isStart = false
    
    @State private var fanBladeCnt: Int = 5
    private var fanBlades: [[Lamp]] {
        modelData.fanBlades.dropLast(modelData.fanBlades.count - fanBladeCnt)
    }
    
    @State private var angle: Double = 0
    
    /**
     当前实时车速（km/h）
     */
    @State private var speed: Double = 0
    
    /**
     计算轮胎转速（转每秒）
     */
    private var rps: Double {
        // speed / (Double.pi * 轮胎外径:0.6m * 3.6)
        speed / (Double.pi * 2.16)
    }
    
    /**
     计算轮胎转角（角度每帧）
     */
    private var dpf: Double {
        rps / fps * 360
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("刷新率：**\(Int(fps))** fps\n轮胎外径：**0.6** m\n\n转速：**\(String(format: "%.1f", rps))** rps\n转角：**\(String(format: "%.1f", dpf))** dpf")
                    Spacer()
                }
                
                HStack(alignment: .bottom) {
                    Text(String(format: "%.1f", speed))
                        .font(.largeTitle)
                        .bold()
                    Text("km/h")
                        .padding(.bottom, 5)
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                Spacer()
                
                Divider()
                
                Picker("叶片数", selection: $fanBladeCnt) {
                    ForEach(1...modelData.fanBlades.count, id: \.self) { num in
                        Text("\(num)")
                    }
                }
                .pickerStyle(.segmented)
                
                HStack {
                    Slider(value: $speed, in: 0...120, step: 0.1) {
                        Text("speed")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("120")
                    }
                    
                    Stepper(value: $speed, in: 0...120, step: 0.1) {
                        Text("")
                    }
                    .frame(width: 100)
                }
                .padding()
                
                Divider()
                
                Button {
                    isStart.toggle()
                } label: {
                    Text(isStart ? "停止" : "启动")
                        .frame(width: 200, height: 20)
                        .padding()
                        .background(.ultraThinMaterial, in: Capsule(style: .continuous))
                        .padding(.top)
                    
                }
            }
            .padding(.horizontal)
            
            ZStack {
                Circle()
                    .foregroundColor(.black)
                    .frame(width: 350, height: 350)
                
                Circle()
                    .stroke(style: .init(lineWidth: 20))
                    .foregroundColor(.gray)
                    .frame(width: 260, height: 260)
                
                Circle()
                    .foregroundColor(.secondary)
                    .frame(width: 180, height: 180)
                
                Circle()
                    .frame(width: 100, height: 100)
                
                Circle()
                    .foregroundColor(.secondary)
                    .frame(width: 30, height: 30)
            }
            
            ZStack {
                ForEach(Array(fanBlades.enumerated()), id: \.element) { index, element in
                    let angleOffset: Angle = .degrees(angle + Double(index * 360 / fanBlades.count))
                    
                    FanBladeView(lamps: element, angle: angleOffset)
                        .offset(x: 80, y: 0)
                        .rotationEffect(angleOffset)
                }
            }
        }
        .onChange(of: isStart) { value in
            if value {
                //模拟启动
                if speed == 0 {
                    speed = 3
                }
                
                //模拟轮胎转动
                repeatTimer.start(timeInterval: 1 / fps) {
                    angle += rps * 360 / fps
                }
            } else {
                //模拟停止
                repeatTimer.stop()
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
