#!/bin/bash

set -euo pipefail

PROJECT_DIR="${PROJECT_DIR:-/Users/cjz/ios_project/xiguwen}"
PROJECT_FILE="${PROJECT_FILE:-xiguwen.xcodeproj}"
SCHEME="${SCHEME:-BoYi}"
BUNDLE_ID="${BUNDLE_ID:-com.boyi028.app}"
CONFIGURATION="${CONFIGURATION:-Debug}"
DERIVED_DATA="${DERIVED_DATA:-/tmp/run-ios-derived}"

DEVICE_ID=""
ATTACH_CONSOLE=0

usage() {
  cat <<'EOF'
Usage:
  run-ios.sh [--device <UDID>] [--console]

Options:
  --device <UDID>  Use a specific physical device.
  --console        Attach console output after launch.
  -h, --help       Show this help.

Environment overrides:
  PROJECT_DIR PROJECT_FILE SCHEME BUNDLE_ID CONFIGURATION DERIVED_DATA
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --device)
      [[ $# -ge 2 ]] || { echo "Missing value for --device" >&2; exit 1; }
      DEVICE_ID="$2"
      shift 2
      ;;
    --console)
      ATTACH_CONSOLE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing required command: $1" >&2
    exit 1
  }
}

require_cmd xcodebuild
require_cmd xcrun
require_cmd python3

[[ -d "$PROJECT_DIR" ]] || { echo "Project directory not found: $PROJECT_DIR" >&2; exit 1; }
[[ -e "$PROJECT_DIR/$PROJECT_FILE" ]] || { echo "Project file not found: $PROJECT_DIR/$PROJECT_FILE" >&2; exit 1; }

detect_device_id() {
  xcrun xcdevice list | python3 -c '
import json
import sys

raw = sys.stdin.read()
start = raw.find("[")
if start == -1:
    sys.exit(1)

devices = json.loads(raw[start:])
candidates = []
for item in devices:
    if item.get("simulator"):
        continue
    if not item.get("available"):
        continue
    if item.get("platform") != "com.apple.platform.iphoneos":
        continue
    identifier = item.get("identifier")
    if identifier:
        candidates.append((item.get("name", "Unknown iPhone"), identifier))

if not candidates:
    sys.exit(1)

name, identifier = candidates[0]
print(identifier)
print(name, file=sys.stderr)
'
}

if [[ -z "$DEVICE_ID" ]]; then
  echo "Detecting connected physical iPhone..." >&2
  if ! detected_output="$(detect_device_id 2> >(tee /tmp/run-ios-device-name.txt >&2))"; then
    echo "No available physical iPhone detected. Connect and trust a device, then retry." >&2
    exit 1
  fi
  DEVICE_ID="$(printf '%s' "$detected_output" | tail -n 1)"
fi

echo "Using device: $DEVICE_ID"
echo "Building $SCHEME from $PROJECT_DIR/$PROJECT_FILE"

mkdir -p "$DERIVED_DATA"

(
  cd "$PROJECT_DIR"
  xcodebuild \
    -project "$PROJECT_FILE" \
    -scheme "$SCHEME" \
    -configuration "$CONFIGURATION" \
    -destination "id=$DEVICE_ID" \
    -derivedDataPath "$DERIVED_DATA" \
    build
)

APP_PATH="$(find "$DERIVED_DATA/Build/Products" -maxdepth 2 -type d -name '*.app' | sort | grep '/'"$CONFIGURATION"'-iphoneos/' | head -n 1 || true)"
[[ -n "$APP_PATH" ]] || { echo "Built app not found under $DERIVED_DATA/Build/Products" >&2; exit 1; }

echo "Installing app: $APP_PATH"
xcrun devicectl device install app --device "$DEVICE_ID" "$APP_PATH"

echo "Launching bundle id: $BUNDLE_ID"
if [[ "$ATTACH_CONSOLE" -eq 1 ]]; then
  xcrun devicectl device process launch --device "$DEVICE_ID" --console --terminate-existing "$BUNDLE_ID"
else
  xcrun devicectl device process launch --device "$DEVICE_ID" --terminate-existing "$BUNDLE_ID"
fi
