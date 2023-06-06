//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by endava-bootcamp on 27.03.2023..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene
        else{ return }
        window = UIWindow(windowScene: windowScene)
        
        let dataSource = MovieDataSource()
        let categorisedViewModel = MovieCategorisedViewModel(movieDataSource: dataSource)
        let favoritesViewModel = FavoritesViewModel(dataSource: dataSource)
        
        let movieDetailsNavigationController = UINavigationController()
        let router = MovieDetailsRouter(with: movieDetailsNavigationController, dataSource: dataSource, favViewModel: favoritesViewModel)
        let movieListController = MovieCategorisedViewController(router: router, viewModel: categorisedViewModel, favViewModel: favoritesViewModel)
        movieDetailsNavigationController.pushViewController(movieListController, animated: true)

        movieDetailsNavigationController.tabBarItem = UITabBarItem(title: "Movie list", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let favoritesController = FavoritesViewController(router: router, viewModel: favoritesViewModel)
        favoritesController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.viewControllers = [ movieDetailsNavigationController, favoritesController ]

        window?.rootViewController = tabBarController
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

