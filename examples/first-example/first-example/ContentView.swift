//
//  ContentView.swift
//  first-example
//
//  Created by m2 on 2024/6/9.
//

import SwiftUI
import SwiftUISkia

struct ContentView: View {
    var body: some View {
        SwiftUISkia.Surface(width: 400, height: 400) {
            SwiftUISkia.Rect(x: 10, y: 10, width: 100, height: 100, style: "fill", color: "#ff3333") {}
            SwiftUISkia.Rect(x: 210, y: 110, width: 100, height: 100, style: "stroke", color: "cyan") {}
            SwiftUISkia.Circle(cx: 205, cy: 45, r: 20, style: "fill", color: "purple") {}
            SwiftUISkia.Circle(cx: 205, cy: 45, r: 30, style: "stroke", color: "purple") {}
            SwiftUISkia.Line(p1: [133, 44], p2: [160, 188], strokeWidth: 4, color: "black") {}
        }
    }
}

#Preview {
    ContentView()
}
