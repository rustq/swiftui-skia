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
            SwiftUISkia.Rect(x: 10, y: 10, width: 100, height: 100) {}
            SwiftUISkia.Rect(x: 210, y: 110, width: 100, height: 100) {}
        }
    }
}

#Preview {
    ContentView()
}
