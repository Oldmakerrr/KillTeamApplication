//
//  SceneDelegate.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit
import Instructions

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func ifAppLaunchedFirstTime() -> Bool {
        if let data = UserDefaults.standard.value(forKey: "isAppAlreadyLaunchedOnce") as? Bool {
            return data
        } else {
            UserDefaults.standard.set(false, forKey: "isAppAlreadyLaunchedOnce")
            return true
        }
    }
    
    func configureNavigatinBar() {
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().tintColor = ColorScheme.shared.theme.selectedView
        
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            let tabAppearance = UITabBarAppearance()
            let blure = UIBlurEffect(style: .dark)
            appearance.configureWithOpaqueBackground()
            appearance.backgroundEffect = blure
            appearance.backgroundColor = .clear
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            tabAppearance.backgroundEffect = blure
            tabAppearance.backgroundColor = .clear
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UITabBar.appearance().standardAppearance = tabAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        configureNavigatinBar()
        let isAppAlreadyLaunchedOnce = true
        //let isAppAlreadyLaunchedOnce = ifAppLaunchedFirstTime()
        let userSettings = UserSettings(firstTimeLaunch: isAppAlreadyLaunchedOnce)
        let gameStore = GameStore()
        let store = Store()
        let storage = Storage(store: store)
        let builder = ModuleBuilder(store: store,
                                    gameStore: gameStore,
                                    storage: storage,
                                    userSettings: userSettings)
        let router = MainRouter(builder: builder)
        DispatchQueue.global(qos: .utility).async {
            storage.loadSavedKillTeam()
            store.killTeamFromJson()
        }
        gameStore.parseTacOps()
        let rootViewController = MainTabBarController(mainRouter: router, builder: builder, complition: storage.loadLastUsedKillTeam)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

