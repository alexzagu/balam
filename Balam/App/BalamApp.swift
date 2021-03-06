//
//  BalamApp.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 27/07/2021.
//

import SwiftUI

@main
struct BalamApp: App {

    var body: some Scene {
        WindowGroup {
            RootView(viewModel: .init(container: container))
        }
    }

    private var container: DIContainer {
        AppEnvironment.bootstrap().container
    }

}
