//
//  ViewState.swift
//  pokemon
//
//  Created by Argana Phangquestian on 20/08/23.
//

import Foundation

enum ViewState<T> {
        case idle
        case loading
        case failed(Error)
        case loaded(T)
    }
