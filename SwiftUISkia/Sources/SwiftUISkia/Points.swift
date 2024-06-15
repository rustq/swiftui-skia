import SwiftUI

public struct Points<Content: View>: View {
    var points: [[UInt32]]
    var strokeWidth: UInt32
    var style: String
    var color: String
    let content: Content
    @EnvironmentObject var ffi: FFI;

    public init(points: [[UInt32]], strokeWidth: UInt32, style: String, color: String, @ViewBuilder builder: () -> Content) {
        self.points = points
        self.strokeWidth = strokeWidth
        self.style = style
        self.color = color
        self.content = builder()
    }
    
    public var body: some View {
        ZStack {
            content
        }.onAppear{
            let id = AutoIncrementID.id()
            self.ffi.soft.create(UInt(id))
            var points = [UInt32]()
            for i in 0..<self.points.count {
                points.append(self.points[i][0])
                points.append(self.points[i][1])
            }
            self.ffi.soft.set_points_attr(UInt(id), points.withUnsafeBufferPointer({ initalPtr in
                
                initalPtr
            }), self.strokeWidth, self.style, self.color)
            self.ffi.willChange()
        }
    }
}
