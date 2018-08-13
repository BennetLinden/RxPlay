//
//  Presenter.swift
//  Toedoes
//
//  Created by Bennet van der Linden on 18/07/2018.
//  Copyright © 2018 Wepps. All rights reserved.
//

import Foundation

protocol Presenter: class {

    associatedtype View

    var view: View? { get set }

    func attach(view: View)
}

extension Presenter {

    func attach(view: View) {
        self.view = view
    }
}
