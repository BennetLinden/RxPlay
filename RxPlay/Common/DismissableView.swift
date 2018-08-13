//
//  DismissableView.swift
//  RePlay
//
//  Created by Bennet van der Linden on 30/07/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import UIKit

protocol DismissableView: View {
    func dismiss()
}

extension DismissableView where Self: UIViewController {

    func dismiss() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}
