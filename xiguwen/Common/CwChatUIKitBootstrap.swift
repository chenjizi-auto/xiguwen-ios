import Foundation
import BMPlayer
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

@objcMembers
final class CwBMPlayerViewController: UIViewController {
    private let player = BMPlayer()
    private let urlString: String
    private let titleText: String?

    @objc init(urlString: String, titleText: String?) {
        self.urlString = urlString
        self.titleText = titleText
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupPlayer()
        playVideoIfNeeded()
    }

    override var prefersStatusBarHidden: Bool {
        true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NSLog("[BMPlayer] viewDidDisappear fullscreen title=%@ url=%@", titleText ?? "", urlString)
        player.pause()
    }

    private func setupPlayer() {
        BMPlayerConf.shouldAutoPlay = true
        BMPlayerConf.allowLog = false
        BMPlayerConf.topBarShowInCase = .always
        BMPlayerConf.loaderType = .ballRotateChase

        player.translatesAutoresizingMaskIntoConstraints = false
        player.backBlock = { [weak self] _ in
            self?.closePlayer()
        }
        view.addSubview(player)
        NSLayoutConstraint.activate([
            player.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            player.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            player.topAnchor.constraint(equalTo: view.topAnchor),
            player.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func playVideoIfNeeded() {
        guard let url = URL(string: urlString), !urlString.isEmpty else {
            NSLog("[BMPlayer] invalid fullscreen url=%@", urlString)
            return
        }
        NSLog("[BMPlayer] start fullscreen title=%@ url=%@", titleText ?? "", urlString)
        let resource = BMPlayerResource(url: url, name: titleText ?? "")
        player.setVideo(resource: resource)
    }

    private func closePlayer() {
        NSLog("[BMPlayer] close fullscreen title=%@ url=%@", titleText ?? "", urlString)
        if let navigationController, navigationController.viewControllers.first != self {
            navigationController.popViewController(animated: true)
        } else if presentingViewController != nil {
            dismiss(animated: true)
        }
    }
}

@objcMembers
final class CwBMPlayerContainerView: UIView {
    private let player = BMPlayer()

    @objc override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayer()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPlayer()
    }

    @objc func play(urlString: String, titleText: String?) {
        guard let url = URL(string: urlString), !urlString.isEmpty else {
            NSLog("[BMPlayer] invalid embedded url=%@", urlString)
            return
        }
        NSLog("[BMPlayer] start embedded title=%@ url=%@", titleText ?? "", urlString)
        let resource = BMPlayerResource(url: url, name: titleText ?? "")
        player.setVideo(resource: resource)
    }

    @objc func pausePlayback() {
        NSLog("[BMPlayer] pause embedded")
        player.pause()
    }

    private func setupPlayer() {
        backgroundColor = .black
        BMPlayerConf.shouldAutoPlay = true
        BMPlayerConf.allowLog = false
        BMPlayerConf.topBarShowInCase = .none
        BMPlayerConf.loaderType = .ballRotateChase

        player.translatesAutoresizingMaskIntoConstraints = false
        addSubview(player)
        NSLayoutConstraint.activate([
            player.leadingAnchor.constraint(equalTo: leadingAnchor),
            player.trailingAnchor.constraint(equalTo: trailingAnchor),
            player.topAnchor.constraint(equalTo: topAnchor),
            player.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
