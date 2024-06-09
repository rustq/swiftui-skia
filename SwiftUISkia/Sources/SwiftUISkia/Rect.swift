import SwiftUI

@available(macOS 10.15, *)
public struct Rect<Content: View>: View {
    var x: UInt32
    var y: UInt32
    var width: UInt32
    var height: UInt32
    let content: Content
    @EnvironmentObject var ffi: FFI;

    public init(x: UInt32, y: UInt32, width: UInt32, height: UInt32, @ViewBuilder builder: () -> Content) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.content = builder()
    }
    
    public var body: some View {
        ZStack {
            content
        }.onAppear{
            let id = AutoIncrementID.id();
            self.ffi.soft.create(UInt(id))
            self.ffi.soft.set_attr(UInt(id), self.x, self.y, self.width, self.height, 255, 0, 0, "rect")
            self.ffi.count += 1;
        }
    }
}
