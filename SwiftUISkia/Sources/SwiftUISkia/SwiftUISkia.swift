// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct SwiftUISkia: View {

    @available(macOS 10.15, *)
    public init() {
    }
    
    @available(macOS 10.15, *)
    public var body: some View {
        VStack {
            Button {
                print("Button pressed");
            } label: {
                Text("Hello World")
                    .padding(20)
            }
        }
    }
}
