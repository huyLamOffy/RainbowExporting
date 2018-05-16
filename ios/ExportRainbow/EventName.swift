//
//  EventName.swift
//  ExportRainbow
//
//  Created by Macbook on 5/15/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation

@objc(EventName)
class EventName: NSObject {
  static let didLoginRainbow = "DidLoginRainbow"
  static let didLogoutRainbow = "DidLogoutRainbow"
  static let didEndPopulatingRainbow = "DidEndPopulatingRainbow"
  static let failAuthenticationRainbow = "FailAuthenticationRainbow"
  static let didAddedCachedItems = "didAddedCachedItems"
  static let didRemoveCacheItems = "didRemoveCacheItems"
  static let didReorderCacheItemsAtIndexes = "didReorderCacheItemsAtIndexes"
  static let didUpdateCacheItems = "didUpdateCacheItems"
  static let resyncBrowsingCache = "resyncBrowsingCache"
  static let didAddCall = "didAddCall"
  static let didUpdateCall = "didUpdateCall"
  static let didChangeCallStatus = "didChangeCallStatus"
  static let didRemoveCall = "didRemoveCall"
  static let didAllowMicrophone = "DidAllowMicrophone"
  static let didRemoveMicrophone = "DidRemoveMicrophone"
  static let requestAccessMicophone = "requestAccessMicophone"
  
  
  static let supportEvents = [
    didLoginRainbow,
    didLogoutRainbow,
    didEndPopulatingRainbow,
    failAuthenticationRainbow,
    didAddedCachedItems,
    didRemoveCacheItems,
    didReorderCacheItemsAtIndexes,
    didUpdateCacheItems,
    resyncBrowsingCache,
    didAddCall,
    didUpdateCall,
    didChangeCallStatus,
    didRemoveCall,
    didAllowMicrophone,
    didRemoveMicrophone,
    requestAccessMicophone
  ]
}
