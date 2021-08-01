//
//  DIContainer.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 28/07/2021.
//

import Combine
import SwiftUI

struct DIContainer {

    let appState: Store<AppState>
    let appServices: AppServices
    let appFormatters: AppFormatters

    init(appState: Store<AppState>, appServices: AppServices) {
        self.appState = appState
        self.appServices = appServices
        self.appFormatters = .init()
    }

    init(appState: AppState, appServices: AppServices) {
        self.init(appState: .init(appState), appServices: appServices)
    }

}

// MARK: - Stub

#if DEBUG

extension DIContainer {

    static var preview: Self {
        .init(appState: .preview, appServices: .stub)
    }

}

#endif
