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
}
