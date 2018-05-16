//
//  RTCCallController.swift
//  ExportRainbow
//
//  Created by Macbook on 5/16/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation
import Rainbow

@objc(RTCCallController)
class RTCCallController: NSObject {
  var currentCall: RTCCall?
  var contact: Contact?
  weak var eventEmitter: RCTEventEmitter!
  
  init(contact: Contact, feature: RTCCallFeatureFlags, eventEmitter: RCTEventEmitter) {
    self.contact = contact
    self.eventEmitter = eventEmitter
    super.init()
    
    NotificationCenter.default.addObserver(self, selector: #selector(didCallSuccess(notification:)), name: NSNotification.Name.rtcServiceDidAddCall, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(didUpdateCall(notification:)), name: NSNotification.Name.rtcServiceDidUpdateCall, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(didCallChangeCallStatus(notification:)), name: NSNotification.Name.rtcServiceCallStats, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(didRemoveCall(notification:)), name: NSNotification.Name.rtcServiceDidRemoveCall, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(didAllowMicrophone(notification:)), name: NSNotification.Name.rtcServiceDidAllowMicrophone, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(didRefuseMicrophone(notification:)), name: NSNotification.Name.rtcServiceDidRefuseMicrophone, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(didAddLocalVideo(notification:)), name: NSNotification.Name.rtcServiceDidAddLocalVideoTrack, object: nil)
    
    makeCallTo(contact, with: feature)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.rtcServiceDidAddCall, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.rtcServiceDidUpdateCall, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.rtcServiceCallStats, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.rtcServiceDidRemoveCall, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.rtcServiceDidAllowMicrophone, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.rtcServiceDidRefuseMicrophone, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.rtcServiceDidAddLocalVideoTrack, object: nil)
    currentCall = nil
    contact = nil
    print(self, "deinit")
  }
  
  //MARK: -  Helper methods
  func cancelCurrentCall() {
    guard currentCall != nil else {
      return
    }
    ServicesManager.sharedInstance().rtcService.cancelOutgoingCall(currentCall!)
    ServicesManager.sharedInstance().rtcService.hangupCall(currentCall!)
  }
  
  func addVideoToAudioCall() {
    if currentCall != nil {
      ServicesManager.sharedInstance().rtcService.addVideoMedia(to: currentCall!)
    }
  }
  
  func removeVideo() {
    if currentCall != nil {
      ServicesManager.sharedInstance().rtcService.removeVideoMedia(from: currentCall!)
//      ServicesManager.sharedInstance().rtcService.localVideoStream(for: currentCall!)?.videoTracks.last?.remove(<#T##renderer: RTCVideoRenderer##RTCVideoRenderer#>)
    }
  }
  
  func makeCallTo(_ contact: Contact, with feature: RTCCallFeatureFlags) {
    guard ServicesManager.sharedInstance().rtcService.microphoneAccessGranted else {
      requestAccessMicrophone()
      return
    }
    currentCall = ServicesManager.sharedInstance().rtcService.beginNewOutgoingCall(with: contact, withFeatures: feature)
  }
  
  func requestAccessMicrophone() {
    eventEmitter.sendEvent(withName: EventName.requestAccessMicophone, body: NSNull.init())
    
  }
  
  //MARK: - RTCCall notifications
  func didCallSuccess(notification: Notification) {
    if let currentCall = notification.object as? RTCCall {
      print("%@ did call success", currentCall)
    }
  }
  
  func didUpdateCall(notification: Notification) {
    if let currentCall = notification.object as? RTCCall {
      print("%@ did update call", currentCall)
    }
  }
  
  func didCallChangeCallStatus(notification: Notification) {
    if let currentCall = notification.object as? RTCCall {
      print("%@ didCallChangeCallStatus", currentCall)
    }
  }
  
  func didAddLocalVideo(notification: Notification) {
    if let localVideoTrack = notification.object as? RTCVideoTrack,
      localVideoTrack.source is RTCAVFoundationVideoSource,
      let source = localVideoTrack.source as? RTCAVFoundationVideoSource {
      // // LocalVideoView is an instance of RTCCameraPreviewView, you can use the component you want to display it
      //      _localVideoView.captureSession = source.captureSession;
      print(source)
    }
  }
  
  func didRemoveCall(notification: Notification) {
    if let currentCall = notification.object as? RTCCall {
      print("%@ didRemoveCall", currentCall)
    }
  }
  
  func didAllowMicrophone(notification: Notification) {
    if let currentCall = notification.object as? RTCCall {
      print("%@ didAllowMicrophone", currentCall)
    }
  }
  
  func didRefuseMicrophone(notification: Notification) {
    if let currentCall = notification.object as? RTCCall {
      print("%@ didRefuseMicrophone", currentCall)
    }
  }
}
