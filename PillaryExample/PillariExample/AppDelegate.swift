//  Created by Anton Popkov on 29.09.17.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = createWindow()
        window?.makeKeyAndVisible()

        return true
    }

    private func createWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)

        let rootController = UINavigationController(rootViewController: MainViewController())

        window.addSubview(rootController.view)
        window.rootViewController = rootController

        return window
    }
}
