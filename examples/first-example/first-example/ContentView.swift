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
        SwiftUISkia.Surface(width: 360, height: 360) {
            SwiftUISkia.Rect(x: 10, y: 220, width: 30, height: 30, style: "fill", color: "cyan") {}
            SwiftUISkia.Image(image: "https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png", x: 70, y: 70, width: 48, height: 48, blur: 5, brighten: 80) {}
            SwiftUISkia.Image(image: "https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png", x: 0, y: 0, width: 48, height: 48) {}
            SwiftUISkia.Line(p1: [100, 260], p2: [50, 285], strokeWidth: 8, color: "black") {}
            SwiftUISkia.RoundRect(x: 220, y: 50, r: 10, width: 80, height: 80, style: "stroke", color: "fuchsia") {}
            SwiftUISkia.Points(points: [
                [138, 10],
                [178, 90],
                [266, 103],
                [202, 165],
                [217, 254],
                [138, 212],
                [59, 254],
                [74, 165],
                [10, 103],
                [98, 90],
                [138, 10],
              ], strokeWidth: 1, style: "fill", color: "rgba(200, 255, 0, 0.7)") {}
            SwiftUISkia.Circle(cx: 200, cy: 220, r: 70, style: "stroke", color: "violet") {}
            SwiftUISkia.Circle(cx: 200, cy: 220, r: 50, style: "fill", color: "violet") {}
            SwiftUISkia.Text(text: "Hello SwiftUI Skia!",x: 80, y: 0, fontSize: 16, color: "black", maxWidth: 60) {}
            SwiftUISkia.Text(text: "Hello SwiftUI Skia!",x: 80, y: 60, fontSize: 16, color: "black") {}
        }
    }
}
