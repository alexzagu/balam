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
    let menuRepo: MenuRepositoryProtocol

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

        let cancelBag = CancelBag()
        menu.wrappedValue.setLoading(with: cancelBag)

        menuRepo
            .loadMenu()
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sinkToLoadable {
                appState[\.userData.menu] = $0
                menu.wrappedValue = $0
            }
            .store(in: cancelBag)
    }

    func load(promotions: LoadableSubject<[URL]>) {
        switch appState[\.userData.promotions] {
        case let .loaded(value):
            promotions.wrappedValue = .loaded(value: value)
            return
        default: break
        }

        let cancelBag = CancelBag()
        promotions.wrappedValue.setLoading(with: cancelBag)

        menuRepo
            .loadPromotions()
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sinkToLoadable {
                appState[\.userData.promotions] = $0
                promotions.wrappedValue = $0
            }
            .store(in: cancelBag)
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
