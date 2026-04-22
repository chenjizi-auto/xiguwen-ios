---
name: run-ios
description: Build, install, and launch the current iOS project on a connected physical iPhone using the real project directory at /Users/cjz/ios_project/xiguwen. Use when the user asks to run-ios, 真机编译, 真机运行, 安装到手机, run on iPhone, or build/run the current iOS app outside the sandbox copy.
---

# Run IOS

Use this skill for this repository when the user wants the app compiled and launched on a connected iPhone.

## Defaults

- Real project directory: `/Users/cjz/ios_project/xiguwen`
- Project entry: `xiguwen.xcodeproj`
- Scheme: `BoYi`
- Bundle identifier: `com.boyi028.app`
- Configuration: `Debug`
- Derived data: `/tmp/run-ios-derived`

## Workflow

1. Run from the real project directory, not the sandbox copy.
2. Use escalated permissions for device discovery, build, install, and launch. These commands need access to Xcode caches, signing assets, USB devices, and files under `/Users/cjz/Library/...`.
3. Prefer `scripts/run-ios.sh`.
4. Pass `--device <UDID>` when the user wants a specific phone. Otherwise let the script auto-pick the first available physical iPhone.
5. If no physical iPhone is detected, report that clearly and stop.
6. If the build fails, report the key `xcodebuild` errors instead of dumping the full log.
7. If install or launch fails, report the exact failing command and any signing or device trust message.

## Commands

```bash
scripts/run-ios.sh
scripts/run-ios.sh --device <UDID>
scripts/run-ios.sh --console
```

## Notes

- Prefer `xcodebuild -project xiguwen.xcodeproj -scheme BoYi`; in this environment `xiguwen.xcworkspace` is not a reliable entry point.
- The script builds first, then installs the generated `.app` with `xcrun devicectl device install app`, then launches the app by bundle identifier with `xcrun devicectl device process launch`.
- Override defaults with environment variables only when needed: `PROJECT_DIR`, `PROJECT_FILE`, `SCHEME`, `BUNDLE_ID`, `CONFIGURATION`, `DERIVED_DATA`.
