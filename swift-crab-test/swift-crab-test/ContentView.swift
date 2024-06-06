//
//  ContentView.swift
//  swift-crab-test
//
//  Created by m2 on 2024/6/2.
//

import SwiftUI
import MyCrabLib;

struct ContentView: View {
    var body: some View {
        VStack {
            Text(MyCrabLib.hello_rust().toString())
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello Soft Skia Swift!")
//            AsyncImage(url: URL(string: MyCrabLib.hello_soft_skia().toString()))
            SKSurface {

                SKStack(x: 10, y: 10, width: 10, height: 10, r: 255, g: 0, b: 0, shape: "rect") {
                    SKStack(x: 100, y: 100, width: 30, height: 70, r: 0, g: 100, b: 0, shape: "line") {
                    }
                    SKStack(x: 200, y: 40, width: 100, height: 20, r: 0, g: 0, b: 0, shape: "line") {
                    }
                    SKStack(x: 200, y: 240, width: 100, height: 20, r: 255, g: 255, b: 255, shape: "line") {
                    }
                    SKButton()
                    
                }
            }.environmentObject(ParentID(id: 0)).environmentObject(FFI(soft: MyCrabLib.SoftSkia()))
        }
        .padding()
    }
}
//
//#Preview {
//    ContentView()
//}



class AutoIncrementID {
    static private var inc: Int32 = 0;
    
    static func id() -> Int32 {
        inc += 1;
        return inc;
    }
}

class ParentID: ObservableObject {
    @Published var id: Int32;
    
    init(id: Int32) {
        self.id = id;
    }
}


class FFI: ObservableObject {
    @Published var soft: MyCrabLib.SoftSkia;
    
    init(soft: MyCrabLib.SoftSkia) {
        self.soft = soft;
    }
}

struct SKSurface<Content: View>: View {
    @EnvironmentObject var ffi: FFI;
    let content: Content;
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content();
    }
    
    var body: some View {
        VStack {
            content
        }.padding().onAppear{
            //
            }
    }
}

struct SKStack<Content: View>: View {
    @EnvironmentObject var parentID: ParentID;
    @EnvironmentObject var ffi: FFI;
    let content: Content;
    let id: Int32;
    let x: UInt32;
    let y: UInt32;
    let width: UInt32;
    let height: UInt32;
    let r: UInt32;
    let g: UInt32;
    let b: UInt32;
    let shape: String;
    
    init(x: UInt32, y: UInt32, width: UInt32, height: UInt32, r: UInt32, g: UInt32, b: UInt32, shape: String, @ViewBuilder content: () -> Content) {
        self.content = content();
        self.id = AutoIncrementID.id();
        self.x = x;
        self.y = y;
        self.width = width;
        self.height = height;
        self.r = r;
        self.g = g;
        self.b = b;
        self.shape = shape;
    }
    
    var body: some View {
        VStack {
            content
            Text("id = " + String(self.id))
            Text("parent = " + String(parentID.id))
        }.padding().environmentObject(ParentID(id: self.id)).onAppear{
                self.ffi.soft.create(UInt(self.id));
                self.ffi.soft.set_attr(UInt(self.id), self.x, self.y, self.width, self.height, self.r, self.g, self.b, self.shape)
            }
    }
}

struct SKButton: View {
    @EnvironmentObject var ffi: FFI;
    @State var show: Bool = false;
    @State var rasterlization: String = "";
    
    var body: some View {
        VStack {
            
            Button {
                print("Button pressed");
                show = true;
                rasterlization = self.ffi.soft.to_base64().toString();
            } label: {
                Text("Press Me")
                    .padding(20)
            }
            .contentShape(Rectangle())
            if show {
                AsyncImage(url: URL(string: rasterlization))
            }
        }
    }
}
