//
//  ImagesService.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 29/07/2021.
//

import Foundation

protocol ImagesServiceProtocol {

    func load(image: LoadableSubject<Data>, from url: URL?)

}

struct ImagesService {}

// MARK: - ImagesServiceProtocol

extension ImagesService: ImagesServiceProtocol {

    func load(image: LoadableSubject<Data>, from url: URL?) {}

}
