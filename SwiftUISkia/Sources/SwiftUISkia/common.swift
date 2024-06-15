import SwiftUISkiaBridge
import Foundation

public class AutoIncrementID {
    static private var inc: Int32 = 0;
    
    static func id() -> Int32 {
        inc += 1;
        return inc;
    }
}


@available(macOS 10.15, *)
public class FFI: ObservableObject {
    @Published var soft: SwiftUISkiaBridge.SoftSkia;
    @Published private var count: UInt32;
    
    init(soft: SwiftUISkiaBridge.SoftSkia) {
        self.soft = soft;
        self.count = 0;
    }

    public func willChange() {
        self.count += 1;
    }
}
