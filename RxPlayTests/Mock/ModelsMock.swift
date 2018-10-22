//
//  ModelsMock.swift
//  RxPlayTests
//
//  Created by Bennet van der Linden on 12/10/2018.
//  Copyright © 2018 Bennet. All rights reserved.
//

@testable import RxPlay
import Foundation

extension GIF {
    
    static func mock(id: String = UUID().uuidString) -> GIF {
        return GIF(id: id, slug: "", url: URL(string: "www.giphy.com")!, username: "", rating: "", images: Images.mock())
    }
}

extension Images {
    
    static func mock(url: String = "") -> Images {
        return Images(originalStill: Media.mock(url: url), downsized: Media.mock())
    }
}

extension Media {
    
    static func mock(url: String = "") -> Media {
        return Media(url: url)
    }
}
