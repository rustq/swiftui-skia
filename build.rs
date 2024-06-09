// build.rs

use std::path::PathBuf;
use std::collections::HashMap;

extern crate swift_bridge_build;
use swift_bridge_build::{CreatePackageConfig, ApplePlatform};

fn main() {
    let out_dir = PathBuf::from("./generated");

    let bridges = vec!["src/lib.rs"];
    for path in &bridges {
        println!("cargo:rerun-if-changed={}", path);
    }

    swift_bridge_build::parse_bridges(bridges)
        .write_all_concatenated(out_dir, env!("CARGO_PKG_NAME"));

    swift_bridge_build::create_package(CreatePackageConfig {
        bridge_dir: PathBuf::from("./generated"),
        paths: HashMap::from([
            (ApplePlatform::IOS, "target/aarch64-apple-ios/debug/libsoft_skia_swift.a".into()),
            (ApplePlatform::Simulator, "target/universal-ios/debug/libsoft_skia_swift.a".into()),
            (ApplePlatform::MacOS, "target/universal-macos/debug/libsoft_skia_swift.a".into()),
        ]),
        out_dir: PathBuf::from("SoftSkiaSwift"),
        package_name: "SoftSkiaSwift".to_owned()
    });
}
