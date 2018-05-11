//
//  Contact+Extension.swift
//  ExportRainbow
//
//  Created by Macbook on 5/11/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation
import Rainbow
@objc(HelperMethods)
class HelperMethods: NSObject {
  //MARK: - Helper methods
  @objc static func JSON(from contact: Contact?) -> [String: Any] {
    guard let contact = contact else {
      return [:]
    }
    var dictionary: [String: Any] = [:]
    dictionary["rainbowID"] = contact.rainbowID
    dictionary["fullName"] = contact.fullName
    dictionary["lastName"] = contact.lastName
    dictionary["firstName"] = contact.firstName
    dictionary["photoData"] = contact.photoData
    dictionary["emailAddress"] = contact.emailAddresses.map{$0.address}
    dictionary["phoneNumber"] = contact.phoneNumbers.map{$0.number}
    dictionary["title"] = contact.title
    dictionary["jobTitle"] = contact.jobTitle
    dictionary["address"] = contact.addresses.map{$0.city}
    if contact.presence != nil {
      dictionary["presenceStatus"] = contact.presence.status
    }
    return dictionary
  }
}
