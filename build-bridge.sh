swift-bridge-cli create-package \
  --bridges-dir ./generated \
  --out-dir SoftSkiaSwift \
  --ios target/aarch64-apple-ios/debug/libsoft_skia_swift.a \
  --simulator target/universal-ios/debug/libsoft_skia_swift.a \
  --macos target/universal-macos/debug/libsoft_skia_swift.a \
  --name SoftSkiaSwift