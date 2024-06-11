import SwiftUI

@available(macOS 10.15, *)
public struct RoundRect<Content: View>: View {
    var x: UInt32
    var y: UInt32
    var r: UInt32
    var width: UInt32
    var height: UInt32
    var style: String
    var color: String
    let content: Content
    @EnvironmentObject var ffi: FFI;

    public init(x: UInt32, y: UInt32, r: UInt32, width: UInt32, height: UInt32, style: String, color: String, @ViewBuilder builder: () -> Content) {
        self.x = x
        self.y = y
        self.r = r
        self.width = width
        self.height = height
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
            self.ffi.soft.set_round_rect_attr(UInt(id), self.x, self.y, self.r, self.width, self.height, self.style, self.color)
            self.ffi.willChange();
        }
    }
}
