// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import SoftSkiaSwift

@available(macOS 14, *)
public struct Surface<Content: View>: View {
    var width: UInt32
    var height: UInt32
    let content: Content
    let ffi: FFI
    @State var show: Bool = false;
    @State var rasterlization: String = "";

    public init(width: UInt32, height: UInt32, @ViewBuilder builder: () -> Content) {
        self.width = width
        self.height = height
        self.content = builder()
        self.ffi = FFI(soft: SoftSkiaSwift.SoftSkia());
        self.ffi.soft.set_rect_attr(0, 0, 0, width, height, "fill", "transparent")
    }
    
    public var body: some View {
        ZStack {
            if show {
                AsyncImage(url: URL(string: rasterlization))
            }
            content
        }
        .frame(width: CGFloat(self.width), height: CGFloat(self.height)).environmentObject(self.ffi).onReceive(self.ffi.objectWillChange){
            show = true
            rasterlization = ffi.soft.to_base64().toString()
        }
    }
}

