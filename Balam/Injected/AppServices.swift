//
//  AppServices.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 29/07/2021.
//

struct AppServices {

    let menuService: MenuServiceProtocol
    let imagesService: ImagesServiceProtocol
    let cartService: CartServiceProtocol

}

// MARK: - Stub

#if DEBUG

extension AppServices {

    static var stub: Self {
        .init(menuService: MenuServiceStub(),
              imagesService: ImagesServiceStub(),
              cartService: CartServiceStub())
    }

}

#endif
