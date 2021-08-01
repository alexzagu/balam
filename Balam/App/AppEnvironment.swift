//
//  AppEnvironment.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 29/07/2021.
//

struct AppEnvironment {

    let container: DIContainer

}

// MARK: - Bootstrapping

extension AppEnvironment {

    static func bootstrap() -> AppEnvironment {
        let appState: Store<AppState> = .init(.init())
        let appServices: AppServices = bootstrapServices(with: appState)
        let container: DIContainer = .init(appState: appState, appServices: appServices)

        return .init(container: container)
    }

    private static func bootstrapServices(with appState: Store<AppState>) -> AppServices {
        let menuService: MenuService = .init()
        let imagesService: ImagesService = .init()
        let cartService: CartService = .init(appState: appState)

        return .init(menuService: menuService,
                     imagesService: imagesService,
                     cartService: cartService)
    }

}
