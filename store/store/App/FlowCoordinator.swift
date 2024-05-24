//
//  FlowCoordinator.swift
//  store
//
//  Created by Evelina on 10.07.2023.
//

import UIKit

final class FlowCoordinator {
    private var navigationController: UINavigationController
    private var tabBarControllers: [UINavigationController]
    private let assembly: AssemblyProtocol
    private let userManager: UserManagerProtocol
    private let cartManager: CartManagerProtocol
    private let cart: [CartProduct] = []
    init(navigationController: UINavigationController, assembly: AssemblyProtocol,
         userManager: UserManagerProtocol, cartManager: CartManagerProtocol) {
        self.navigationController = navigationController
        self.assembly = assembly
        self.userManager = userManager
        self.cartManager = cartManager
        self.tabBarControllers = []
    }
    func start() {
        // проверка авторизован ли юзер
        if userManager.isAutorize {
            wantsToOpenTabBar()
        } else {
            wantsToStart()
        }
    }
}
extension FlowCoordinator {
    func wantsToStart() {
        let presenter = AuthPresenter(keychainService: assembly.keychainService, validator: assembly.textValidator,
                                      networkManager: assembly.networkManager, userDefaultsManager: assembly.userDefaultsManager)
        presenter.didTapToOpenAutorizationScreen = wantsToOpenAutorization
        presenter.didTapToOpenRegistrationScreen = wantsToOpenRegistration
        let viewController = StartViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
    func wantsToOpenRegistration() {
        let presenter = AuthPresenter(keychainService: assembly.keychainService, validator: assembly.textValidator,
                                      networkManager: assembly.networkManager, userDefaultsManager: assembly.userDefaultsManager)
        presenter.didTapToRegister = wantsToOpenTabBar
        let viewController = RegistrationViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
    func wantsToOpenAutorization() {
        let presenter = AuthPresenter(keychainService: assembly.keychainService,
                                      validator: assembly.textValidator,
                                      networkManager: assembly.networkManager,
                                      userDefaultsManager: assembly.userDefaultsManager)
        let viewController = AuthViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
    func wantsToOpenTabBar() {
        let iconSize = CGSize(width: 25, height: 25)
        let tabBarViewController = MainTabBarViewController()
        let catalogPresenter = CatalogPresenter(networkManager: assembly.networkManager)
        catalogPresenter.didTapToOpenProducts = wantsToOpenProductList
        catalogPresenter.didTapToAddToCart = wantsToAddProductToCart
        let catalogVC = CatalogViewController(presenter: catalogPresenter)
        catalogVC.tabBarItem = UITabBarItem(title: Text.Catalog.title,
                                            image: UIImage(named: "catalogIcon")?.scaledToSize(iconSize), tag: 0)
        let orderHistoryPresenter = OrderHistoryPresenter(networkManager: assembly.networkManager)
        orderHistoryPresenter.didTapToOpenOrder = wantsToOpenOrder
        let ordersVC = OrderHistoryViewController(presenter: orderHistoryPresenter)
        ordersVC.tabBarItem = UITabBarItem(title: Text.OrderHistory.orders,
                                           image: UIImage(named: "ordersIcon")?.scaledToSize(
                                            CGSize(width: 30, height: 30)), tag: 1)
        let catalogNavigationController = UINavigationController(rootViewController: catalogVC)
        let ordersNavigationController = UINavigationController(rootViewController: ordersVC)
        let profilePresenter = ProfilePresenter(networkManager: assembly.networkManager)

        switch userManager.userRole {
        case .admin:
            let adminPresenter = AdminPresenter(networkManager: assembly.networkManager)
            adminPresenter.didTapToAddCategory = wantsToOpenChooseCategoryScreen
            adminPresenter.didTapToAddPhotos = wantsToOpenChooseImagesScreen
            adminPresenter.didTapToAddName = wantsToOpenChooseNameScreen
            adminPresenter.didTapToAddDescription = wantsToOpenChooseDescriptionScreen
            adminPresenter.didTapToAddCost = wantsToOpenChooseCostScreen
            adminPresenter.didTapToReturnToProducts = {
                self.tabBarControllers[2].popToRootViewController(animated: false)
            }
            let productsVC = AdminProductViewController(presenter: adminPresenter)
            productsVC.tabBarItem = UITabBarItem(title: Text.Admin.myProducts,
                                                image: UIImage(named: "productsIcon")?.scaledToSize(iconSize), tag: 4)
            let productsNavigationController = UINavigationController(rootViewController: productsVC)
            let profileVC = ProfileViewController(isAdminProfile: true, presenter: profilePresenter)
            profileVC.tabBarItem = UITabBarItem(title: Text.Profile.tabbarTitle,
                                                image: UIImage(named: "profileIcon")?.scaledToSize(iconSize), tag: 3)
            let profileNavigationController = UINavigationController(rootViewController: profileVC)
            tabBarViewController.viewControllers = [ordersNavigationController, catalogNavigationController,
                                                    productsNavigationController, profileNavigationController]
            tabBarControllers = [ordersNavigationController, catalogNavigationController,
                                 productsNavigationController, profileNavigationController]
        case .user:
            let cartPresenter = CartPresenter(networkManager: assembly.networkManager, products: cartManager.cart)
            cartPresenter.didTapToMakeOrder = wantsToMakeOrder
            cartPresenter.didTapToDeleteProduct = wantsToDeleteProductFromCart
            cartPresenter.didTapToChangeAmount = wantsToChangeProductAmount
            cartPresenter.didTapToDeleteAllProducts = wantsToDeleteAllProducts
            cartPresenter.didTapToGetCartProducts = wantsToGetCart
            let cartVC = CartViewController(presenter: cartPresenter)
            cartPresenter.view = cartVC
            cartVC.tabBarItem = UITabBarItem(title: Text.Cart.title,
                                             image: UIImage(named: "cartIcon")?.scaledToSize(iconSize), tag: 2)
            let cartNavigationController = UINavigationController(rootViewController: cartVC)
            let profileVC = ProfileViewController(isAdminProfile: false, presenter: profilePresenter)
            profileVC.tabBarItem = UITabBarItem(title: Text.Profile.tabbarTitle,
                                                image: UIImage(named: "profileIcon")?.scaledToSize(iconSize), tag: 3)
            let profileNavigationController = UINavigationController(rootViewController: profileVC)
            tabBarViewController.viewControllers = [ordersNavigationController, catalogNavigationController,
                                                    cartNavigationController, profileNavigationController]
            tabBarControllers = [ordersNavigationController, catalogNavigationController,
                                 cartNavigationController, profileNavigationController]
        }
        tabBarViewController.selectedIndex = 1
        navigationController.setViewControllers([tabBarViewController], animated: true)
    }
    func wantsToOpenProductList(with products: [ShortProduct], presenter: CatalogPresenter) {
        presenter.didTapToAddFilters = wantsToOpenFilterScreen
        let searchVC = SearchViewController(presenter: presenter)
        tabBarControllers[1].pushViewController(searchVC, animated: true)
//        navigationController.pushViewController(searchVC, animated: true)
    }
    func wantsToOpenFilterScreen() {
        let filterVC = FilterViewController()
        filterVC.hidesBottomBarWhenPushed = true
        tabBarControllers[1].pushViewController(filterVC, animated: true)
//        navigationController.pushViewController(filterVC, animated: true)
    }
    func wantsToOpenOrder(with order: Order) {
        let orderPresenter = OrderPresenter(networkManager: assembly.networkManager, order: order)
        orderPresenter.didTapToReviewOrder = wantsToPostReview
        switch userManager.userRole {
        case .user:
            switch order.status {
            case .done:
                let makingOrderVC = MakingOrderViewController(screenState: .makeReturn, presenter: orderPresenter)
                makingOrderVC.hidesBottomBarWhenPushed = true
                tabBarControllers[0].pushViewController(makingOrderVC, animated: true)
//                navigationController.pushViewController(makingOrderVC, animated: true)
            case .assembly, .canceled, .delivery, .new:
                let makingOrderVC = MakingOrderViewController(screenState: .viewOrder, presenter: orderPresenter)
                makingOrderVC.hidesBottomBarWhenPushed = true
                tabBarControllers[0].pushViewController(makingOrderVC, animated: true)
//                navigationController.pushViewController(makingOrderVC, animated: true)
            }
        case .admin:
            let makingOrderVC = MakingOrderViewController(screenState: .changeOrderStatus, presenter: orderPresenter)
            makingOrderVC.hidesBottomBarWhenPushed = true
            tabBarControllers[0].pushViewController(makingOrderVC, animated: true)
//            navigationController.pushViewController(makingOrderVC, animated: true)
        }
    }
    func wantsToMakeOrder(with order: Order) {
        let orderPresenter = OrderPresenter(networkManager: assembly.networkManager, order: order)
        orderPresenter.didTapToMakeOrder = wantsToViewOrderInfo
        let deliveryVC = DeliveryViewController(presenter: orderPresenter)
        tabBarControllers[2].pushViewController(deliveryVC, animated: true)
//        navigationController.pushViewController(deliveryVC, animated: true)
    }
    func wantsToPostReview(orderPresenter: OrderPresenter) {
        let reviewVC = ReviewViewController(presenter: orderPresenter)
        tabBarControllers[0].pushViewController(reviewVC, animated: true)
//        navigationController.pushViewController(reviewVC, animated: true)
    }
    func wantsToViewOrderInfo(with order: Order) {
        let orderPresenter = OrderPresenter(networkManager: assembly.networkManager, order: order)
        orderPresenter.didTapToChangeDeliveryInfo = wantsToMakeOrder
        orderPresenter.didOrderRequestSend = wantsToShowOrderStatus
        let makingOrderVC = MakingOrderViewController(screenState: .makingOrder, presenter: orderPresenter)
        makingOrderVC.hidesBottomBarWhenPushed = true
        tabBarControllers[2].pushViewController(makingOrderVC, animated: true)
//        navigationController.pushViewController(makingOrderVC, animated: true)
    }
    func wantsToShowOrderStatus(with order: Order) {
        let orderPresenter = OrderPresenter(networkManager: assembly.networkManager, order: order)
        orderPresenter.didTapToOpenOrderHistoryScreen = wantsToOpenTabBar
        let orderStatusVC = OrderStatusViewController(presenter: orderPresenter)
        tabBarControllers[2].pushViewController(orderStatusVC, animated: true)
//        navigationController.pushViewController(orderStatusVC, animated: true)
    }
//    func wantsToOpenProduct(with product: ExpandedProduct) {
//        let orderPresenter = OrderPresenter(networkManager: assembly.networkManager, order: order)
//        orderPresenter.didTapToOpenOrderHistoryScreen = wantsToOpenTabBar
//        let productVC = ProductViewController(presenter: )
//        navigationController.pushViewController(orderStatusVC, animated: true)
//    }
    func wantsToAddProductToCart(with product: CartProduct) {
        cartManager.addProductToCart(product: product)
    }
    func wantsToDeleteProductFromCart(with product: Product) {
        cartManager.deleteProductFromCart(product: product)
    }
    func wantsToChangeProductAmount(with product: Product, amount: Int32) {
        cartManager.updateProductAmount(product: product, newAmount: amount)
    }
    func wantsToDeleteAllProducts() {
        cartManager.deleteAllProducts()
    }
    func wantsToGetCart(comletion: (([Product]) -> Void)) {
        cartManager.getProductsFromCart(comletion: comletion)
    }
    func wantsToOpenChooseCategoryScreen(presenter: AdminPresenter) {
        let chooseCategoreVC = ChooseProductCategoryViewController(presenter: presenter)
        chooseCategoreVC.hidesBottomBarWhenPushed = true
        tabBarControllers[2].pushViewController(chooseCategoreVC, animated: true)
//        navigationController.pushViewController(chooseCategoreVC, animated: true)
    }
    func wantsToOpenChooseImagesScreen(presenter: AdminPresenter) {
        let chooseImagesVC = ChooseProductImagesViewController(presenter: presenter)
        chooseImagesVC.hidesBottomBarWhenPushed = true
        tabBarControllers[2].pushViewController(chooseImagesVC, animated: true)
//        navigationController.pushViewController(chooseImagesVC, animated: true)
    }
    func wantsToOpenChooseNameScreen(presenter: AdminPresenter) {
        let addNameVC = AddProductInfoViewController(presenter: presenter, state: .enterName)
        addNameVC.hidesBottomBarWhenPushed = true
        tabBarControllers[2].pushViewController(addNameVC, animated: true)
//        navigationController.pushViewController(addNameVC, animated: true)
    }
    func wantsToOpenChooseCostScreen(presenter: AdminPresenter) {
        let addNameVC = AddProductInfoViewController(presenter: presenter, state: .enterCost)
        addNameVC.hidesBottomBarWhenPushed = true
        tabBarControllers[2].pushViewController(addNameVC, animated: true)
//        navigationController.pushViewController(addNameVC, animated: true)
    }
    func wantsToOpenChooseDescriptionScreen(presenter: AdminPresenter) {
        let addNameVC = AddProductDescriptionViewController(presenter: presenter)
        addNameVC.hidesBottomBarWhenPushed = true
        tabBarControllers[2].pushViewController(addNameVC, animated: true)
//        navigationController.pushViewController(addNameVC, animated: true)
    }
}
