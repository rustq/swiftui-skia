public func hello_rust() -> RustString {
    RustString(ptr: __swift_bridge__$hello_rust())
}
public func hello_soft_skia() -> RustString {
    RustString(ptr: __swift_bridge__$hello_soft_skia())
}

public class SoftSkia: SoftSkiaRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$SoftSkia$_free(ptr)
        }
    }
}
extension SoftSkia {
    public convenience init() {
        self.init(ptr: __swift_bridge__$SoftSkia$new())
    }
}
public class SoftSkiaRefMut: SoftSkiaRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
extension SoftSkiaRefMut {
    public func create(_ id: UInt) -> () {
        __swift_bridge__$SoftSkia$create(ptr, id)
    }

    public func set_attr<GenericIntoRustString: IntoRustString>(_ id: UInt, _ x: UInt32, _ y: UInt32, _ width: UInt32, _ height: UInt32, _ r: UInt32, _ g: UInt32, _ b: UInt32, _ shape: GenericIntoRustString, _ color: GenericIntoRustString, _ style: GenericIntoRustString) {
        __swift_bridge__$SoftSkia$set_attr(ptr, id, x, y, width, height, r, g, b, { let rustString = shape.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = color.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = style.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
    }

    public func to_base64() -> RustString {
        RustString(ptr: __swift_bridge__$SoftSkia$to_base64(ptr))
    }
}
public class SoftSkiaRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension SoftSkia: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_SoftSkia$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_SoftSkia$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: SoftSkia) {
        __swift_bridge__$Vec_SoftSkia$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_SoftSkia$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (SoftSkia(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<SoftSkiaRef> {
        let pointer = __swift_bridge__$Vec_SoftSkia$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return SoftSkiaRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<SoftSkiaRefMut> {
        let pointer = __swift_bridge__$Vec_SoftSkia$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return SoftSkiaRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<SoftSkiaRef> {
        UnsafePointer<SoftSkiaRef>(OpaquePointer(__swift_bridge__$Vec_SoftSkia$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_SoftSkia$len(vecPtr)
    }
}



