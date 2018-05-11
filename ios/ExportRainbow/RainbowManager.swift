//
//  RainbowManager.swift
//  ExportRainbow
//
//  Created by Macbook on 5/10/18.
//  Copyright © 2018 Facebook. All rights reserved.
//
import Foundation
import Rainbow
// RainbowManager.swift

@objc(RainbowManager)
class RainbowManager: RCTEventEmitter {
  @objc func loginWith(_ username: NSString, password: NSString) {
    print("%@ %@", username, password)
    ServicesManager.sharedInstance().loginManager.setUsername(username as String, andPassword: password as String)
    ServicesManager.sharedInstance().loginManager.connect()
    
    NotificationCenter.default.addObserver(self, selector: #selector(didLogin(notification:)), name: NSNotification.Name(kLoginManagerDidLoginSucceeded), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(didLogout(notification:)), name: NSNotification.Name(kLoginManagerDidLogoutSucceeded), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(failedToAuthenticate(notification:)), name: NSNotification.Name(kLoginManagerDidFailedToAuthenticate), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(didEndPopulatingMyNetwork(notification:)), name: NSNotification.Name(kContactsManagerServiceDidEndPopulatingMyNetwork), object: nil)
  }
  
  @objc func logOut() {
    print("%@ log out ne")
    ServicesManager.sharedInstance().loginManager.disconnect()

    ServicesManager.sharedInstance().loginManager.resetAllCredentials()
  }
  
  @objc func getConversations(_ callback: RCTResponseSenderBlock) {
    let converationManager = ServicesManager.sharedInstance().conversationsManagerService
    
    if let conversations = converationManager?.conversations {
      callback([conversations.map{HelperMethods.JSONfrom(conversation: $0)}])
    } else {
      callback([[]])
    }
//      let conversation = conversations.first {
//      _ = converationManager?.sendMessage("test ne", fileAttachment: nil, to: conversation, completionHandler: { (message, error) in
//        if let error = error {
//          print(error.localizedDescription)
//
//        } else {
//          print("%@ sent mess", message ?? "nil message")
//        }
//      }, attachmentUploadProgressHandler: { (_, _, _) in
//        print("%@ sent mess with file")
//      })
//    }
  }
  
  @objc func getContactList(_ callback: @escaping RCTResponseSenderBlock) {
    let contactMan = ServicesManager.sharedInstance().contactsManagerService
    if let contacts = contactMan?.contacts {
      print("%@ contacts", contacts)
      let array = contacts.map{HelperMethods.JSONfrom(contact: $0)}
      callback([array])
    }
  }
  
  @objc func touchContact(_ type: NSString, contactId: NSString) {
    print("%@ touchContact: ", contactId)
    if let contacts = ServicesManager.sharedInstance().contactsManagerService.contacts,
    let contact = contacts.filter({$0.rainbowID == contactId as String}).first {

      print("%@ findContact: ", contact)
    }
  }
  
  @objc func addEvent(_ name: String, location: String, date: NSNumber) -> Void {
    // Date is ready to use!
    print("%@ %@ %S", name, location, date);
  }
  
  //MARK: - Conform RCTEventEmitter
  override func supportedEvents() -> [String]! {
    return [
      "DidLoginRainbow",
      "DidLogoutRainbow",
      "DidEndPopulatingRainbow",
      "FailAuthenticationRainbow"
    ]
  }
  
  //MARK: - notification methods
  @objc func didLogout(notification: Notification) {
    if !Thread.isMainThread {
      DispatchQueue.main.async {
        self.didLogout(notification: notification)
      }
      return
    }
    let ret =  [
      "name": "DidLogoutRainbow"
    ]
    self.sendEvent(withName: "DidLogoutRainbow", body: ret)
    print("%@ Did logout");
  }
  
  @objc func didEndPopulatingMyNetwork(notification : Notification) {
    // Enforce that this method is called on the main thread
    if !Thread.isMainThread {
      DispatchQueue.main.async {
        self.didEndPopulatingMyNetwork(notification: notification)
      }
      return
    }
    let ret =  [
      "name": "DidEndPopulatingRainbow"
    ]
    self.sendEvent(withName: "DidEndPopulatingRainbow", body: ret)
    print("Did end populating my network");
  }
  
  @objc func didLogin(notification: Notification) {
    print("%@ Did login")
    let ret =  [
      "name": "Did login"
    ]
    self.sendEvent(withName: "DidLoginRainbow", body: ret )
  }
  
  @objc func failedToAuthenticate(notification : NSNotification) {
    if !Thread.isMainThread {
      DispatchQueue.main.sync {
        self.failedToAuthenticate(notification: notification)
      }
      return
    }
    print("%@ failedToAuthenticate")
    let ret =  [
      "name": "failedToAuthenticate"
    ]
    self.sendEvent(withName: "FailAuthenticationRainbow", body: ret )
    print("%@ Did fail")
  }
  
  
}
