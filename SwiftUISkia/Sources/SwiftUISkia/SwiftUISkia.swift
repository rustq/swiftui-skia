// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import MyCrabLib

class AutoIncrementID {
    static private var inc: Int32 = 0;
    
    static func id() -> Int32 {
        inc += 1;
        return inc;
    }
}


@available(macOS 10.15, *)
public struct Hello: View {

    public init() {
    }
    
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

@available(macOS 10.15, *)
class FFI: ObservableObject {
    @Published var soft: MyCrabLib.SoftSkia;
    @Published var count: UInt32;
    
    init(soft: MyCrabLib.SoftSkia) {
        self.soft = soft;
        self.count = 0;
    }
}

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
        self.ffi = FFI(soft: MyCrabLib.SoftSkia());
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
