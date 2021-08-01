//
//  AppState.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 28/07/2021.
//

import Foundation

struct AppState: Equatable {

    var userData: UserData = .init()
    var routing: Routing = .init()

}

extension AppState {

    struct UserData: Equatable {

        var cart: [CartItem] = []
        var menu: Loadable<Menu> = .notRequested
        var promotions: Loadable<[URL]> = .notRequested

    }

}

extension AppState {

    struct Routing: Equatable {

        var rootView: RootView.Routing = .init()

    }

}

#if DEBUG

extension AppState {

    static var preview: Self { .init(userData: .preview, routing: .preview) }

}

extension AppState.UserData {

    static var preview: Self {
        .init(cart: [],
              menu: .loaded(value: .mockedData),
              promotions: .loaded(value: [
                .init(string: "www.balam.com/img/promotions/1.png")!,
                .init(string: "www.balam.com/img/promotions/2.png")!,
                .init(string: "www.balam.com/img/promotions/3.png")!
              ]))
    }

}

extension AppState.Routing {

    static var preview: Self { .init() }

}

#endif
