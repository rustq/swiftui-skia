<img width="1439" alt="截屏2024-06-15 18 19 44" src="https://github.com/rustq/SwiftUISkia/assets/11075892/f1dcb6b6-3fed-4571-bac1-bbcf1e7350a2">

# SwiftUI Skia

[![license](https://img.shields.io/badge/license-MIT-cyan)](https://revolunet.mit-license.org/) [![crates](https://img.shields.io/crates/v/swiftui-skia)](https://crates.io/crates/swiftui-skia)

The `swiftui-skia` is a skia based 2d graphics `SwiftUI` rendering library. It is based on `Rust` to implement software rasterization to perform rendering. It takes up less memory than the hardware rasterization, however it is still an experimental project. And it's based entirely on `SwiftUI` syntax.

基于 Skia 的 2D 图形 SwiftUI 渲染库 —— 使用 Rust 语言实现纯软件光栅化渲染，相比原生光栅化占用更少的内存，不过目前仍然是一个实验项目；此外使用层面完全基于 SwiftUI 语法。

## Installation in Rust workspace

```shell
$ cargo add swiftui-skia
```

```shell
$ ln -s ~/.cargo/registry/src/index.crates.io-{YOUR CRATE HASH}/swiftui-skia-0.0.1 swiftui-skia
```

```shell
$ cargo install cargo-lip

$ cargo install swift-bridge-cli
```

```shell
$ cd swiftui-skia

$ rustup target add x86_64-apple-darwin aarch64-apple-darwin aarch64-apple-ios x86_64-apple-ios aarch64-apple-ios-sim

$ ./build-rust.sh

$ ./build-rust.sh
```

## Add Package Dependency

Frameworks, Libraries, and Embedded Content

血 SwiftUISkia

血 SwiftUISkiaBridge


## Usage

```swift
import SwiftUI
import SwiftUISkia

struct ContentView: View {
    var body: some View {
        SwiftUISkia.Surface(width: 360, height: 360) {
            SwiftUISkia.Rect(x: 10, y: 220, width: 30, height: 30, style: "fill", color: "cyan") {}
            SwiftUISkia.Line(p1: [100, 260], p2: [50, 285], strokeWidth: 8, color: "black") {}
            SwiftUISkia.RoundRect(x: 220, y: 50, r: 10, width: 80, height: 80, style: "stroke", color: "fuchsia") {}
            SwiftUISkia.Points(points: [
                [138, 10],
                [178, 90],
                [266, 103],
                [202, 165],
                [217, 254],
                [138, 212],
                [59, 254],
                [74, 165],
                [10, 103],
                [98, 90],
                [138, 10],
              ], strokeWidth: 1, style: "fill", color: "rgba(200, 255, 0, 0.7)") {}
            SwiftUISkia.Circle(cx: 200, cy: 220, r: 70, style: "stroke", color: "violet") {}
            SwiftUISkia.Circle(cx: 200, cy: 220, r: 50, style: "fill", color: "violet") {}
            SwiftUISkia.Text(text: "Hello SwiftUI Skia!",x: 80, y: 0, fontSize: 16, color: "black", maxWidth: 60) {}
        }
    }
}
```

## License

[MIT](https://opensource.org/licenses/MIT)