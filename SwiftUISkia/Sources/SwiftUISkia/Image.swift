import SwiftUI

public struct Image<Content: View>: View {
    var image: String
    var x: Int32
    var y: Int32
    var width: UInt32
    var height: UInt32
    var blur: Optional<Float32>
    var grayscale: Optional<Bool>
    var brighten: Optional<Int32>
    var invert: Optional<Bool>
    let content: Content
    @State var b64: String = "";
    @EnvironmentObject var ffi: FFI;

    public init(image: String, x: Int32, y: Int32, width: UInt32, height: UInt32, blur: Optional<Float32>, grayscale: Optional<Bool>, brighten: Optional<Int32>, invert: Optional<Bool>, @ViewBuilder builder: () -> Content) {
        self.image = image
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.blur = blur
        self.grayscale = grayscale
        self.brighten = brighten
        self.invert = invert
        self.content = builder()
    }
    
    public var body: some View {
        ZStack {
            content
        }.onAppear{
            let id = AutoIncrementID.id();
            self.ffi.soft.create(UInt(id))
            
            if (self.image.starts(with: "data:image/png;base64")) {
                self.b64 = self.image.replacingOccurrences(of: "data:image/png;base64,", with: "")
            } else {
                Task {
                    do {
                        let request = URLRequest(url: URL(string: self.image)!)
                        let (data, _) = try await URLSession.shared.data(for: request)
                        b64 = data.base64EncodedString()
                        self.ffi.soft.set_image_attr(UInt(id), self.b64, self.x, self.y, self.width, self.height, self.blur, self.grayscale, self.brighten, self.invert)
                        self.ffi.willChange();
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
            
        }
    }
}
