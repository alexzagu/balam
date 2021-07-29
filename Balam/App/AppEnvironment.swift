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
        let appState: AppState = .init()
        let appServices: AppServices = bootstrapServices()
        let container: DIContainer = .init(appState: appState, appServices: appServices)

        return .init(container: container)
    }

    private static func bootstrapServices() -> AppServices {
        let menuService: MenuService = .init()
        let imagesService: ImagesService = .init()

        return .init(menuService: menuService, imagesService: imagesService)
    }

}
