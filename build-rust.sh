# build-rust.sh

#!/bin/bash

set -e

THISDIR=$(dirname $0)
cd $THISDIR

# Build the project for the desired platforms:
cargo build --target x86_64-apple-darwin
cargo build --target aarch64-apple-darwin
mkdir -p ./target/universal-macos/debug

lipo \
    ./target/aarch64-apple-darwin/debug/libswiftui_skia.a \
    ./target/x86_64-apple-darwin/debug/libswiftui_skia.a -create -output \
    ./target/universal-macos/debug/libswiftui_skia.a

cargo build --target aarch64-apple-ios

cargo build --target x86_64-apple-ios
cargo build --target aarch64-apple-ios-sim
mkdir -p ./target/universal-ios/debug

lipo \
    ./target/aarch64-apple-ios-sim/debug/libswiftui_skia.a \
    ./target/x86_64-apple-ios/debug/libswiftui_skia.a -create -output \
    ./target/universal-ios/debug/libswiftui_skia.a
