# NIM UIKit Migration Audit

## Current state

- Chat stack in use:
  - `NIMSDK_LITE ~> 10.9.76`
  - `NEConversationUIKit ~> 10.9.11`
  - `NEContactUIKit ~> 10.9.11`
  - `NEChatUIKit ~> 10.9.11`
  - `NECommonUIKit 9.8.4`
  - standalone `TZImagePickerController 3.8.12`
- The project is Objective-C based.
- The app target now has Swift enabled:
  - `xiguwen/Common/CwChatUIKitBootstrap.swift`
  - `xiguwen/xiguwen-Bridging-Header.h`
  - `SWIFT_VERSION = 5.0`
  - `SWIFT_OBJC_BRIDGING_HEADER = xiguwen/xiguwen-Bridging-Header.h`
  - `ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES`

## Why this was not a direct version bump

- Legacy `NIMKit` had been wired deeply into the app.
- `TZImagePickerController` was also used outside chat, so removing `NIMKit` alone was not enough.
- The newer Netease UIKit stack is Swift-based and split across:
  - `NECommonUIKit`
  - `NEConversationUIKit`
  - `NEContactUIKit`
  - `NEChatUIKit`
- That required:
  - Swift support in the app target
  - a stable adapter seam in `CwChatManager`
  - decoupling business pages from `NTES*` implementations

## Progress in this branch

- Completed:
  - Centralized business-side chat entry into `CwChatManager`
  - Centralized session list / contact list / session push creation into `CwChatManager`
  - Replaced `NIMKit`-based `CwChatManager` fallback with builder-based runtime registration
  - Added `CwChatUIKitBridge` and `CwChatUIKitBootstrap`
  - `CwChatUIKitBootstrap` now does real registration:
    - `ChatKitClient.shared.setupInit(isFun: false)`
    - registers `NEConversationService`, `NEContactService`, `NEChatService`
    - calls `ConversationRouter.register()`
    - calls `ContactRouter.register()`
    - calls `ChatRouter.register()`
    - registers `CwChatManager` builders to:
      - `ConversationController`
      - `ContactViewController`
      - `P2PChatViewController`
      - `TeamChatViewController`
  - Updated `Podfile` and reinstalled pods:
    - removed `NIMKit`
    - upgraded `NIMSDK_LITE` to `10.9.76`
    - added `NECommonUIKit`
    - added `NEConversationUIKit`
    - added `NEContactUIKit`
    - added `NEChatUIKit`
    - kept standalone `TZImagePickerController`
    - raised `MJRefresh` to `3.7.5`
    - raised `CocoaLumberjack` to `3.9.0`
    - raised `SDWebImage` to `5.21.7`
  - Removed old chat-only `NTES*` implementation files from the target build:
    - `NTESAttachment.m`
    - `NTESAttachmentDecoder.m`
    - `NTESContentView.m`
    - `NTESCellLayoutConfig.m`
    - `NTESContactViewController.m`
    - `NTESSessionConfig.m`
    - `NTESSessionListViewController.m`
    - `NTESSessionViewController.m`
  - Removed direct `NIMKit` imports from:
    - `xiguwen/Define/PrefixHeader.pch`
    - `xiguwen/Common/CwChatManager.h`
    - `xiguwen/Sections/Message/Common/Controller/NTESMainTabController.h`
    - `xiguwen/Sections/Message/Common/NTES/NTESViewController.m`

- Current adapter entry points:
  - `+ pushP2PSessionWithIMUserId:fromViewController:`
  - `+ pushSession:fromViewController:`
  - `+ sessionViewControllerWithSession:`
  - `+ sessionListViewController`
  - `+ contactListViewController`
  - `+ registerSessionViewControllerBuilder:`
  - `+ registerSessionListViewControllerBuilder:`
  - `+ registerContactListViewControllerBuilder:`

- Remaining legacy scope:
  - `xiguwen/Sections/Message/Common/NTES/*` source files still exist on disk for reference
  - some wrapper files still keep `NTES` naming even though chat runtime has switched to `CwChatManager`

## Validation

- `pod install` now completes with the new dependency graph.
- `Podfile.lock` confirms:
  - `NIMKit` removed
  - `TZImagePickerController` no longer comes from `NIMKit`
  - `NEConversationUIKit`, `NEContactUIKit`, `NEChatUIKit`, `NECommonUIKit` installed
- `xcodebuild -project xiguwen.xcodeproj -scheme BoYi -derivedDataPath /tmp/xiguwen-dd -showBuildSettings` confirms Swift is enabled.
- `xcodebuild -project xiguwen.xcodeproj -scheme BoYi -configuration Debug -sdk iphonesimulator -derivedDataPath /tmp/xiguwen-derived CODE_SIGNING_ALLOWED=NO build` now reaches resource and XIB compilation without failing on:
  - `NIMKit`
  - `NE*UIKit`
  - Swift bridge compile/link setup
- Current build failure remains unrelated to chat migration:
  - `xiguwen/Sections/WeddingCard/MakeWeddingCard/MakeWeddingCardViewController.xib: error: iOS 26.2 Platform Not Installed.`
  - `xiguwen/Sections/WeddingCard/AllWeddingCard/AllWeddingCardViewController.xib: error: iOS 26.2 Platform Not Installed.`

## Next real blocker

- The next blocker is no longer dependency migration.
- To continue, the project needs:
  - the local XIB / simulator platform issue fixed so the app can finish building
  - runtime verification that the new conversation list, contact list, and chat pages behave correctly
  - UI and behavior regression checks around unread count, navigation, and custom message handling

## Practical note

- `xcodebuild -workspace xiguwen.xcworkspace ...` currently reports the workspace is not a valid workspace file in this environment.
- `xcodebuild -project xiguwen.xcodeproj ...` is the reliable validation path used in this branch.
