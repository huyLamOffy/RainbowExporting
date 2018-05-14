//
//  ConversationController.swift
//  ExportRainbow
//
//  Created by Macbook on 5/13/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation
import Rainbow

fileprivate let kPageSize = 20
fileprivate let didAddedCachedItems = "didAddedCachedItems"
fileprivate let didRemoveCacheItems = "didRemoveCacheItems"
fileprivate let didReorderCacheItemsAtIndexes = "didReorderCacheItemsAtIndexes"
fileprivate let didUpdateCacheItems = "didUpdateCacheItems"
fileprivate let resyncBrowsingCache = "resyncBrowsingCache"

@objc(ConversationController)
class ConversationController: NSObject {
  //MARK: - Properties
  var test = 0
  weak var conversation: Conversation?
  weak var contact: Contact?
  var messagesBrowser: MessagesBrowser!
  weak var eventEmitter: RCTEventEmitter!
  var listMessages: [Message]! = []
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
    if let contactIndex = contactMan.contacts.index(where: {$0.rainbowID == self.id}) {
      self.contact = contactMan.contacts[contactIndex]
    }
    
    guard let contact = self.contact else {
      
      //handle error
      return
    }
    
    if let conversationIndex = conversationMan.conversations.index(where: {$0.peer.rainbowID == self.id}) {
      self.conversation = conversationMan.conversations[conversationIndex]
    }
    if conversation == nil {
      conversationMan.startConversation(with: contact) { [weak self] (conversation, error) in
        if let error = error {
          //handle error
          print("%@ error startConversation", error.localizedDescription)
        } else if let conversation = conversation {
          self?.conversation = conversation
          self?.setUpMessageBrowser(for: conversation)
        }
      }
    } else {
      setUpMessageBrowser(for: conversation!)
    }
    
    print("%@ create conversation",self.conversation!)
    print("%@ create contact", self.contact!)
    //kConversationsManagerDidReceiveNewMessageForConversation
    NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNewMessage(notification:)), name: NSNotification.Name(kConversationsManagerDidReceiveNewMessageForConversation), object: nil)
  }
  
  deinit {
    messagesBrowser.reset()
    messagesBrowser.delegate = nil
    messagesBrowser = nil
    print(self,"deinit")
  }
  
  //MARK: - Helper methods
  func sendFile(base64: NSString) {
    let myUser = ServicesManager.sharedInstance().myUser
    guard let data = HelperMethods.dataFrom(base64: base64) else {
      print("%@ nil data convert from base 64")
      return
    }
    print("%@ myUser",myUser ?? "nil")
    let userName = myUser?.contact.fullName
    if let fileName = ((userName ?? "userName") + NSUUID().uuidString.lowercased()).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
      let file = ServicesManager.sharedInstance().fileSharingService.createTemporaryFile(withFileName: fileName, andData: data, andURL: URL(string: fileName))
      ServicesManager.sharedInstance().conversationsManagerService.sendMessage("test image", fileAttachment: file, to: conversation, completionHandler: { (message, error) in
        if let error = error {
          print("%@ error send mess", error)
        } else {
          print("%@ message send", message?.body ?? "nil body", message?.attachment.fileName ?? "nil body")
        }
      }, attachmentUploadProgressHandler: nil)
    }
  }
  
  func send(text: String) {
    guard let conversation = conversation else {
      return
    }
    ServicesManager.sharedInstance().conversationsManagerService.sendMessage(text, fileAttachment: nil, to: conversation, completionHandler: { (message, error) in
      print("%@ message", message ?? "nil")
      print("%@ error", error ?? "nil")
    }, attachmentUploadProgressHandler: nil)
  }
  
  func setUpMessageBrowser(for conversation: Conversation) {
    messagesBrowser = ServicesManager.sharedInstance().conversationsManagerService.messagesBrowser(for: conversation, withPageSize: kPageSize, preloadMessages: true)
    messagesBrowser.delegate = self
    print("%@ alo", messagesBrowser ?? "null")
    messagesBrowser.resyncBrowsingCache { [weak self] (addedCacheItems, removedCacheItems, updatedCacheItems, error) in
      if let error = error {
        print("%@ get error resync mess", error.localizedDescription)
      }
      print("%@ resync browsing cache")
      self?.eventEmitter.sendEvent(withName: resyncBrowsingCache, body: "resyncBrowsingCache")
    }
  }
  
  func didReceiveNewMessage(notification: Notification) {
    if let receivedConversation = notification.object as? Conversation {
      if receivedConversation == self.conversation {
        print("%@ receivedConversation - did new message for the conversation")
      }
    }
  }
}
//MARK: - CKItemsBrowserDelegate
extension ConversationController: CKItemsBrowserDelegate {
  func itemsBrowser(_ browser: CKItemsBrowser!, didAddCacheItems newItems: [Any]!, at indexes: IndexSet!) {
    print("%@ didAddCacheItems")
    var body: [[String: Any]] = []
    guard let newMessages = newItems as? [Message] else {
      return
    }
    listMessages.append(contentsOf: newMessages.reversed())
    
    body = listMessages.compactMap{ HelperMethods.JSONfrom(message: $0) }
    eventEmitter.sendEvent(withName: didAddedCachedItems, body: body)
  }
  
  func itemsBrowser(_ browser: CKItemsBrowser!, didRemoveCacheItems removedItems: [Any]!, at indexes: IndexSet!) {
    print("%@ didRemoveCacheItems")
  }
  
  func itemsBrowser(_ browser: CKItemsBrowser!, didUpdateCacheItems changedItems: [Any]!, at indexes: IndexSet!) {
    print("%@ didUpdateCacheItems")
  }
  
  func itemsBrowser(_ browser: CKItemsBrowser!, didReorderCacheItemsAtIndexes oldIndexes: [Any]!, toIndexes newIndexes: [Any]!) {
    print("%@ didReorderCacheItemsAtIndexes")
  }
}
