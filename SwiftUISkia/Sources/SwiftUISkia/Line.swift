import SwiftUI

public struct Line<Content: View>: View {
    var p1: [UInt32]
    var p2: [UInt32]
    var strokeWidth: UInt32
    var color: String
    let content: Content
    @EnvironmentObject var ffi: FFI;

    public init(p1: [UInt32], p2: [UInt32], strokeWidth: UInt32, color: String, @ViewBuilder builder: () -> Content) {
        self.p1 = p1
        self.p2 = p2
        self.strokeWidth = strokeWidth
        self.color = color
        self.content = builder()
    }
    
    public var body: some View {
        ZStack {
            content
        }.onAppear{
            let id = AutoIncrementID.id();
            self.ffi.soft.create(UInt(id))
            ;
            self.ffi.soft.set_line_attr(UInt(id), self.p1.withUnsafeBufferPointer({ initalPtr in
                
                initalPtr
            }), self.p2.withUnsafeBufferPointer({ initalPtr in
                
                initalPtr
            }), self.strokeWidth, self.color)
            self.ffi.willChange();
        }
    }
}
