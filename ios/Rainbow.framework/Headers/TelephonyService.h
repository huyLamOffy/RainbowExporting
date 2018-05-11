/*
 * Rainbow
 *
 * Copyright (c) 2018, ALE International
 * All rights reserved.
 *
 * ALE International Proprietary Information
 *
 * Contains proprietary/trade secret information which is the property of
 * ALE International and must not be made available to, or copied or used by
 * anyone outside ALE International without its written authorization
 *
 * Not to be disclosed or used except in accordance with applicable agreements.
 */

#import <Foundation/Foundation.h>
#import "PhoneNumber.h"

/**
 *  Telephony service
 */
@interface TelephonyService : NSObject

/**
 *  Activate telephony nomadic
 *
 *  @param phoneNumber the phone number to use
 */
-(void) nomadicLoginWithPhoneNumber:(PhoneNumber *)phoneNumber withCompletionBlock:(void (^)(NSError *error))completionBlock;

/**
 *  Activate telephony nomadic
 *
 *  @param phoneNumber the string phone number to use
 */
-(void) nomadicLoginWithPhoneString:(NSString *)phoneNumber withCompletionBlock:(void (^)(NSError *error))completionBlock;

/**
 *  Disable telephony nomadic
 *
 */
-(void) nomadicLogoutWithCompletionBlock:(void (^)(NSError *error))completionBlock;

@end
