/*
 * This file is part of Adblock Plus <https://adblockplus.org/>,
 * Copyright (C) 2006-present eyeo GmbH
 *
 * Adblock Plus is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * Adblock Plus is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Adblock Plus.  If not, see <http://www.gnu.org/licenses/>.
 */

import Foundation

class AboutViewController: SettingsTableViewController<AboutViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false

        switch indexPath.row {
        case 0, 1:
            let url = URL(string: (self.viewModel?.links[indexPath.row])!)
            self.openURL(url!)
        default:
            break
        }
    }
}

extension UIViewController {
    /// Open a URL in Safari using the appropriate call for the current iOS version.
    /// - Parameter url: A URL.
    func openURL(_ url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url,
                                      options: [:])
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
