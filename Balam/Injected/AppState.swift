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

    }

}
