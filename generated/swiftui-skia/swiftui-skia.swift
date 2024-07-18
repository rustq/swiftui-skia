
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

    public func set_rect_attr<GenericIntoRustString: IntoRustString>(_ id: UInt, _ x: UInt32, _ y: UInt32, _ width: UInt32, _ height: UInt32, _ style: GenericIntoRustString, _ color: GenericIntoRustString) {
        __swift_bridge__$SoftSkia$set_rect_attr(ptr, id, x, y, width, height, { let rustString = style.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = color.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
    }

    public func set_circle_attr<GenericIntoRustString: IntoRustString>(_ id: UInt, _ cx: UInt32, _ cy: UInt32, _ r: UInt32, _ style: GenericIntoRustString, _ color: GenericIntoRustString) {
        __swift_bridge__$SoftSkia$set_circle_attr(ptr, id, cx, cy, r, { let rustString = style.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = color.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
    }

    public func set_line_attr<GenericIntoRustString: IntoRustString>(_ id: UInt, _ p1: UnsafeBufferPointer<UInt32>, _ p2: UnsafeBufferPointer<UInt32>, _ stroke_width: Optional<UInt32>, _ color: GenericIntoRustString) {
        __swift_bridge__$SoftSkia$set_line_attr(ptr, id, p1.toFfiSlice(), p2.toFfiSlice(), stroke_width.intoFfiRepr(), { let rustString = color.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
    }

    public func set_points_attr<GenericIntoRustString: IntoRustString>(_ id: UInt, _ points: UnsafeBufferPointer<UInt32>, _ stroke_width: Optional<UInt32>, _ style: GenericIntoRustString, _ color: GenericIntoRustString) {
        __swift_bridge__$SoftSkia$set_points_attr(ptr, id, points.toFfiSlice(), stroke_width.intoFfiRepr(), { let rustString = style.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = color.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
    }

    public func set_round_rect_attr<GenericIntoRustString: IntoRustString>(_ id: UInt, _ x: UInt32, _ y: UInt32, _ r: UInt32, _ width: UInt32, _ height: UInt32, _ style: GenericIntoRustString, _ color: GenericIntoRustString) {
        __swift_bridge__$SoftSkia$set_round_rect_attr(ptr, id, x, y, r, width, height, { let rustString = style.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = color.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
    }

    public func set_text_attr<GenericIntoRustString: IntoRustString>(_ id: UInt, _ text: GenericIntoRustString, _ x: Int32, _ y: Int32, _ font_size: Float, _ color: GenericIntoRustString, _ max_width: Optional<Float>) {
        __swift_bridge__$SoftSkia$set_text_attr(ptr, id, { let rustString = text.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), x, y, font_size, { let rustString = color.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), max_width.intoFfiRepr())
    }

    public func set_image_attr<GenericIntoRustString: IntoRustString>(_ id: UInt, _ image: GenericIntoRustString, _ x: Int32, _ y: Int32, _ width: UInt32, _ height: UInt32, _ blur: Optional<Float>, _ grayscale: Optional<Bool>, _ brighten: Optional<Int32>, _ invert: Optional<Bool>) {
        __swift_bridge__$SoftSkia$set_image_attr(ptr, id, { let rustString = image.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), x, y, width, height, blur.intoFfiRepr(), grayscale.intoFfiRepr(), brighten.intoFfiRepr(), invert.intoFfiRepr())
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



