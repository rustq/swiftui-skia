import SwiftUI

public struct Text<Content: View>: View {
    var text: String
    var x: Int32
    var y: Int32
    var fontSize: Float32
    var color: String
    var maxWidth: Optional<Float32>
    let content: Content
    @EnvironmentObject var ffi: FFI;

    public init(text: String, x: Int32, y: Int32, fontSize: Float32, color: String, maxWidth: Optional<Float32>, @ViewBuilder builder: () -> Content) {
        self.text = text
        self.x = x
        self.y = y
        self.fontSize = fontSize
        self.color = color
        self.maxWidth = maxWidth
        self.content = builder()
    }
    
    public var body: some View {
        ZStack {
            content
        }.onAppear{
            let id = AutoIncrementID.id();
            self.ffi.soft.create(UInt(id))
            self.ffi.soft.set_text_attr(UInt(id), self.text, self.x, self.y, self.fontSize, self.color, self.maxWidth)
            self.ffi.willChange();
        }
    }
}
