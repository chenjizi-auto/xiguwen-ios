import Foundation
import NIMSDK
import NEChatKit
import NEChatUIKit
import NEContactUIKit
import NEConversationUIKit
import UIKit

@objcMembers
final class CwChatUIKitBootstrap: NSObject {
    private static var hasRegistered = false

    @objc class func registerBuildersIfNeeded() {
        guard !hasRegistered else { return }

        ChatKitClient.shared.setupInit(isFun: false)
        ChatKitClient.shared.registerInit(NEConversationService.shared)
        ChatKitClient.shared.registerInit(NEContactService.shared)
        ChatKitClient.shared.registerInit(NEChatService.shared)

        NEConversationLoaderService.shared.setupInit()
        NEContactLoaderService.shared.setupInit()
        NEChatLoaderService.shared.setupInit()

        NEConversationService.shared.setupInit(nil)
        NEConversationService.shared.registerRouter(nil)
        NEContactService.shared.setupInit(nil)
        NEContactService.shared.registerRouter(nil)
        NEChatService.shared.setupInit(nil)
        NEChatService.shared.registerRouter(nil)

        ConversationRouter.register()
        ContactRouter.register()
        ChatRouter.register()

        CwChatManager.registerSessionViewControllerBuilder { session in
            guard let session else {
                return UIViewController()
            }
            let viewController = self.sessionViewController(for: session)
            viewController.hidesBottomBarWhenPushed = true
            return viewController
        }
        CwChatManager.registerSessionListViewControllerBuilder {
            ConversationController(nibName: nil, bundle: nil)
        }
        CwChatManager.registerContactListViewControllerBuilder {
            ContactViewController(nibName: nil, bundle: nil)
        }

        hasRegistered = true
    }

    private class func sessionViewController(for session: NIMSession) -> UIViewController {
        switch session.sessionType.rawValue {
        case 0:
            let normalizedSessionId = CwChatManager.normalizedIMUserId(fromValue: session.sessionId) ?? session.sessionId
            let conversationId = V2NIMConversationIdUtil.p2pConversationId(normalizedSessionId) ?? normalizedSessionId
            NSLog("[CwChat] openP2P sessionId=%@ normalizedSessionId=%@ conversationId=%@", session.sessionId, normalizedSessionId, conversationId)
            return P2PChatViewController(conversationId: conversationId)
        case 1:
            let conversationId = V2NIMConversationIdUtil.teamConversationId(session.sessionId) ?? session.sessionId
            NSLog("[CwChat] openTeam sessionId=%@ conversationId=%@", session.sessionId, conversationId)
            return TeamChatViewController(sessionId: conversationId)
        default:
            NSLog("[CwChat] openDefault sessionId=%@ sessionType=%ld", session.sessionId, session.sessionType.rawValue)
            return ChatViewController(conversationId: session.sessionId)
        }
    }
}
