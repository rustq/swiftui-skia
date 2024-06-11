import SwiftUI

@available(macOS 10.15, *)
public struct Circle<Content: View>: View {
    var cx: UInt32
    var cy: UInt32
    var r: UInt32
    var style: String
    var color: String
    let content: Content
    @EnvironmentObject var ffi: FFI;

    public init(cx: UInt32, cy: UInt32, r: UInt32, style: String, color: String, @ViewBuilder builder: () -> Content) {
        self.cx = cx
        self.cy = cy
        self.r = r
        self.style = style
        self.color = color
        self.content = builder()
    }
    
    public var body: some View {
        ZStack {
            content
        }.onAppear{
            let id = AutoIncrementID.id();
            self.ffi.soft.create(UInt(id))
            self.ffi.soft.set_circle_attr(UInt(id), self.cx, self.cy, self.r, self.style, self.color)
            self.ffi.willChange();
        }
    }
}
