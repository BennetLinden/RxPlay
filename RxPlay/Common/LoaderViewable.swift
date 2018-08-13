//
//  LoaderViewable.swift
//  RePlay
//
//  Created by Bennet van der Linden on 27/07/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

import Foundation

protocol LoaderViewable: View {
    func showLoader()
    func hideLoader()
}
