//
//  File.swift
//  TMDBSwifty
//
//  Created by brett ohland on 11/06/25.
//

import Foundation
import SharedModels

enum DiscoverFilterValidationService {

    enum ValidationError: Error {
        // certification, certification.gte and certification.lte are used in conjunction with region

        // certification_country is used in conjunction with `certification`, `certification_gte`, and certification_lte

        // watch_region used with with_watch_monetization_types and with_watch_providers

        // 
    }

    static func validate(filterSet: [DiscoverFilter]) throws {

    }
}
