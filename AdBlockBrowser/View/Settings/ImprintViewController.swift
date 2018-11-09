//
//  ImprintViewController.swift
//  AdblockBrowser
//
//  Created by Andy Shephard on 09/11/2018.
//  Copyright © 2018 eyeo GmbH. All rights reserved.
//

import MessageUI
import UIKit
import WebKit

class ImprintViewController: UIViewController, WKNavigationDelegate, MFMailComposeViewControllerDelegate {

    var viewModel: ImprintViewModel!
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ImprintViewModel()
        setupWebView()
    }

    // MARK: - MFMailComposeViewControllerDelegate

    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true,
                           completion: nil)
    }

    // MARK: - WKNavigationDelegate

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let mailScheme = "mailto"
        switch navigationAction.request.url?.scheme {
        case mailScheme?:
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients([viewModel!.eyeoInfoEmail])
            composeVC.setSubject(viewModel!.mailSubject)
            composeVC.setMessageBody(viewModel!.mailBody,
                                     isHTML: false)
            if MFMessageComposeViewController.canSendText() {
                self.present(composeVC,
                             animated: true,
                             completion: nil)
            }
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }

    // MARK: - Private

    private func setupWebView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        view.addConstraints(webView.sideMarginFullVertical(to: view))
        guard let imprint = viewModel!.imprint else {
            return
        }
        webView.load(imprint)
    }
}
