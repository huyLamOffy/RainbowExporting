//
//  RainbowManager.m
//  ExportRainbow
//
//  Created by Macbook on 5/10/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

//#import <Foundation/Foundation.h>
//// RainbowManager.m
//#import <React/RCTBridgeModule.h>
//
//@interface RainbowManager : NSObject <RCTBridgeModule>
//
//@end
// CalendarManagerBridge.m
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RainbowManager, NSObject)
RCT_EXTERN_METHOD(addEvent:(NSString *)name location:(NSString *)location date:(nonnull NSNumber *)date)

RCT_EXTERN_METHOD(loginWith:(NSString *)username password:(NSString *)password)
RCT_EXTERN_METHOD(logOut)
RCT_EXTERN_METHOD(touchContact: (NSString *)type contactId:(NSString *)contactId)
RCT_EXTERN_METHOD(getContactList:(RCTResponseSenderBlock *)callback)
RCT_EXTERN_METHOD(getConversations:(RCTResponseSenderBlock *)callback)
RCT_EXTERN_METHOD(openConversation: (NSString *)id)
RCT_EXTERN_METHOD(sendText: (NSString *)text)
RCT_EXTERN_METHOD(sendFileBase64: (NSString *)base64)
@end
