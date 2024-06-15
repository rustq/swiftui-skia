swift-bridge-cli create-package \
  --bridges-dir ./generated \
  --out-dir SwiftUISkiaBridge \
  --ios target/aarch64-apple-ios/debug/libswiftui_skia.a \
  --simulator target/universal-ios/debug/libswiftui_skia.a \
  --macos target/universal-macos/debug/libswiftui_skia.a \
  --name SwiftUISkiaBridge