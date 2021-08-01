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
    func fetch(item: LoadableSubject<MenuItem>, with id: UUID)

}

struct MenuService {

    let appState: Store<AppState>

}

// MARK: - MenuServiceProtocol

extension MenuService: MenuServiceProtocol {

    func load(menu: LoadableSubject<Menu>) {
        switch appState[\.userData.menu] {
        case let .loaded(value):
            menu.wrappedValue = .loaded(value: value)
            return
        default: break
        }

        let mockedMenu: Loadable<Menu> = .loaded(value: .mockedData)
        appState[\.userData.menu] = mockedMenu
        menu.wrappedValue = mockedMenu
    }

    func load(promotions: LoadableSubject<[URL]>) {
        switch appState[\.userData.promotions] {
        case let .loaded(value):
            promotions.wrappedValue = .loaded(value: value)
            return
        default: break
        }

        let mockedPromotions: Loadable<[URL]> = .loaded(value: [
            .init(string: "www.balam.com/img/placeholder_image.png")!,
            .init(string: "www.balam.com/img/placeholder_image.png")!,
            .init(string: "www.balam.com/img/placeholder_image.png")!
        ])
        appState[\.userData.promotions] = mockedPromotions
        promotions.wrappedValue = mockedPromotions
    }

    func fetch(item: LoadableSubject<MenuItem>, with id: UUID) {
        guard let menu = appState[\.userData.menu].value else {
            item.wrappedValue = .failed(ValueIsMissingError())
            return
        }

        let menuItem = menu.categories.flatMap { $0.items }.first { $0.id == id }
        item.wrappedValue = menuItem.map { .loaded(value: $0) } ?? .failed(ValueIsMissingError())
    }

}

// MARK: - Stub

#if DEBUG

struct MenuServiceStub: MenuServiceProtocol {

    func load(menu: LoadableSubject<Menu>) {
        menu.wrappedValue = .loaded(value: Menu.mockedData)
    }

    func load(promotions: LoadableSubject<[URL]>) {
        promotions.wrappedValue = .loaded(value: [])
    }

    func fetch(item: LoadableSubject<MenuItem>, with id: UUID) {
        item.wrappedValue = .loaded(value: Menu.mockedData.categories.first!.items.first!)
    }

}

#endif
