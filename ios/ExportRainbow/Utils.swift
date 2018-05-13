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
  @objc static func JSONfrom(conversation: Conversation?) -> [String: Any]  {
    guard let conversation = conversation else {
      return [:]
    }
    var dictionary: [String: Any] = [:]
    dictionary["type"] = conversation.type
    dictionary["rainbowID"] = conversation.peer.rainbowID
    dictionary["lastMessage"] = conversation.lastMessage.body
    dictionary["lastMessageTime"] = conversation.lastMessage.date.timeIntervalSince1970
    dictionary["lastUpdateDate"] = conversation.lastUpdateDate.timeIntervalSince1970
    dictionary["unreadMessagesCount"] = conversation.unreadMessagesCount
    return dictionary
  }
  
  @objc static func JSONfrom(contact: Contact?) -> [String: Any] {
    guard let contact = contact else {
      return [:]
    }
    var dictionary: [String: Any] = [:]
    dictionary["rainbowID"] = contact.rainbowID
    dictionary["fullName"] = contact.fullName
    dictionary["lastName"] = contact.lastName
    dictionary["firstName"] = contact.firstName
    if contact.photoData != nil {
      dictionary["photoData"] = contact.photoData.base64EncodedString(options: .init(rawValue: 0))
    }
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
