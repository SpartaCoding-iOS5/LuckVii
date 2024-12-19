//
//  ViewController.swift
//  LuckVii
//
//  Created by 손겸 on 12/16/24.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        setupTabBar()
        
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        LoginManager.shared.presentLoginModal(viewController: self)
    }

    // MARK: - set up tab bar controller
    
    private func setupTabBar() {
        let categoryVC: CategoryViewController = CategoryViewController()
        let searchVC: SearchViewController = SearchViewController()
        let myPageVC: MyPageViewController = MyPageViewController()
        
        let categoryNav: UINavigationController = UINavigationController(rootViewController: categoryVC)
        let searchNav: UINavigationController = UINavigationController(rootViewController: searchVC)
        let myPageNav: UINavigationController = UINavigationController(rootViewController: myPageVC)
//        let categoryNav: CategoryViewController = CategoryViewController()
//        let searchNav: SearchViewController = SearchViewController()
//        let myPageNav: MyPageViewController = MyPageViewController()
        //set tab bar item
        categoryNav.tabBarItem = UITabBarItem(
            title: "Category",
            image: UIImage(systemName: "film"),
            selectedImage: UIImage(systemName: "film.fill"))
        searchNav.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass.circle"),
            selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        myPageNav.tabBarItem = UITabBarItem(
            title: "MyPage",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [categoryNav, searchNav, myPageNav]
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }

}
