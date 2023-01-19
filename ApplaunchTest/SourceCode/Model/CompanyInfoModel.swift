//
//  CompanyInfoModel.swift
//  ApplaunchTest
//
//  Created by Nitesh jha on 18/01/23.
//

import Foundation

class CompanyModel: Codable {
    let headquarters: Headquarters
    let links: Linkss
    let name, founder: String
    let founded, employees, vehicles, launchSites: Int
    let testSites: Int
    let ceo, cto, coo, ctoPropulsion: String
    let valuation: Int
    let summary, id: String

    enum CodingKeys: String, CodingKey {
        case headquarters, links, name, founder, founded, employees, vehicles
        case launchSites = "launch_sites"
        case testSites = "test_sites"
        case ceo, cto, coo
        case ctoPropulsion = "cto_propulsion"
        case valuation, summary, id
    }

    init(headquarters: Headquarters, links: Linkss, name: String, founder: String, founded: Int, employees: Int, vehicles: Int, launchSites: Int, testSites: Int, ceo: String, cto: String, coo: String, ctoPropulsion: String, valuation: Int, summary: String, id: String) {
        self.headquarters = headquarters
        self.links = links
        self.name = name
        self.founder = founder
        self.founded = founded
        self.employees = employees
        self.vehicles = vehicles
        self.launchSites = launchSites
        self.testSites = testSites
        self.ceo = ceo
        self.cto = cto
        self.coo = coo
        self.ctoPropulsion = ctoPropulsion
        self.valuation = valuation
        self.summary = summary
        self.id = id
    }
}

// MARK: - Headquarters
class Headquarters: Codable {
    let address, city, state: String

    init(address: String, city: String, state: String) {
        self.address = address
        self.city = city
        self.state = state
    }
}

// MARK: - Links
class Linkss: Codable {
    let website, flickr, twitter, elonTwitter: String

    enum CodingKeys: String, CodingKey {
        case website, flickr, twitter
        case elonTwitter = "elon_twitter"
    }

    init(website: String, flickr: String, twitter: String, elonTwitter: String) {
        self.website = website
        self.flickr = flickr
        self.twitter = twitter
        self.elonTwitter = elonTwitter
    }
}
