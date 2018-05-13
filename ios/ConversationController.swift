//
//  ConversationController.swift
//  ExportRainbow
//
//  Created by Macbook on 5/13/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation
import Rainbow

@objc(ConversationController)
class ConversationController: NSObject {
  weak var conversation: Conversation?
  weak var contact: Contact?
  var id: String!
  init(id: NSString) {
    super.init()
    self.id = id as String
    guard let serviceMan = ServicesManager.sharedInstance(),
      let contactMan = serviceMan.contactsManagerService,
      let conversationMan = serviceMan.conversationsManagerService else {
        //handle error
      return
    }
    
    for contact in contactMan.contacts {
      if contact.rainbowID == self.id {
        self.contact = contact
        break
      }
    }
    
    guard let contact = self.contact else {
      
      //handle error
      return
    }
    
    for conversation in conversationMan.conversations {
      if conversation.peer.rainbowID == self.id {
        self.conversation = conversation
        break
      }
    }
    
    if conversation == nil {
      conversationMan.startConversation(with: contact) { [weak self] (conversation, error) in
        if let error = error {
          //handle error
          print("%@ error startConversation", error.localizedDescription)
        } else {
          self?.conversation = conversation
        }
      }
    }
    
    print("%@ create conversation",self.conversation!)
    print("%@ create contact", self.contact!)
  }
  
  deinit {
    print(self,"deinit")
  }
  
  
}
