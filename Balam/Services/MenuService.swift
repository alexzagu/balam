//
//  MenuService.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 29/07/2021.
//

import Foundation

protocol MenuServiceProtocol {

    func load(menu: LoadableSubject<Menu>)
    func load(promotions: LoadableSubject<[URL]>)

}

struct MenuService {}

// MARK: - MenuServiceProtocol

extension MenuService: MenuServiceProtocol {

    func load(menu: LoadableSubject<Menu>) {
        menu.wrappedValue = .loaded(value: .mockedData)
    }

    func load(promotions: LoadableSubject<[URL]>) {
        promotions.wrappedValue = .loaded(value: [
            .init(string: "")!,
            .init(string: "")!,
            .init(string: "")!
        ])
    }

}
