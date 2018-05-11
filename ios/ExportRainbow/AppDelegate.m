/**
 * Copyright (c) 2015-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"
#import "Rainbow/Rainbow.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

RCTBridge *rnBrigde;

@implementation PublicBridgeHelper : NSObject
-(RCTBridge*)getBridge {
  NSLog(@"rnBridge= @%@", rnBrigde);
  return rnBrigde;
}
@end

#define kPageSize 50

#define kAppID @""
#define kSecretKey @""

@implementation AppDelegate

-(NSString *)applicationName {
  static NSString *_appName;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    _appName = [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    if (!_appName) {
      _appName = [bundle objectForInfoDictionaryKey:@"CFBundleName"];
    }
  });
  return _appName;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLogin:)
//                                               name:kLoginManagerDidLoginSucceeded object:nil];
//
//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failedToAuthenticate:)
//                                               name:kLoginManagerDidFailedToAuthenticate object:nil];
//
//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndPopulatingMyNetwork:) name:kContactsManagerServiceDidEndPopulatingMyNetwork object:nil];
  
  NSURL *jsCodeLocation;

  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
//  [[ServicesManager sharedInstance] setAppID:kAppID secretKey:kSecretKey];
//  [[ServicesManager sharedInstance].loginManager setUsername:@"huylh@dgroup.co" andPassword:@"SUGARdatingapp!23"];
//  [[ServicesManager sharedInstance].rtcService requestMicrophoneAccess];
//  [[ServicesManager sharedInstance].rtcService startCallKitWithIncomingSoundName:@"incoming-call.mp3" iconTemplate:@"logo" appName:[self applicationName]];
//  [ServicesManager sharedInstance].rtcService.appSoundOutgoingCall = @"outgoing-rings.mp3";
//  [ServicesManager sharedInstance].rtcService.appSoundHangup = @"hangup.wav";
//  [[ServicesManager sharedInstance].loginManager connect];
  

  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"ExportRainbow"
                                               initialProperties:nil
                                                   launchOptions:launchOptions];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  rnBrigde = rootView.bridge;
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
  [[ServicesManager sharedInstance].loginManager disconnect];
  [[ServicesManager sharedInstance].loginManager resetAllCredentials];
}

//-(void) failedToAuthenticate:(NSNotification *) notification {
//  NSLog(@"HUYLH - Failed to login");
//}
//
//-(void) didLogin:(NSNotification *) notification {
//  NSLog(@"HUYLH - Did login");
//}
//
//-(void) didCallSuccess:(NSNotification *) notification {
//  NSLog(@"HUYLH - didCallSuccess");
//}
//
//-(void) didEndPopulatingMyNetwork:(NSNotification *) notification {
//  // Enforce that this method is called on the main thread
//  if(![NSThread isMainThread]){
//    dispatch_async(dispatch_get_main_queue(), ^{
//      [self didEndPopulatingMyNetwork:notification];
//    });
//    return;
//  }
//  
//  NSLog(@"HUYLH - Did end populating my network");
//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCallSuccess:) name:kRTCServiceDidAddCallNotification object:nil];
//  ContactsManagerService *_contactsManager = [ServicesManager sharedInstance].contactsManagerService;
//  Contact *huyne;
//  for(Contact *contact in _contactsManager.contacts){
//    // keep only contacts that are in the connected user roster
//    if(contact.isInRoster){
//      NSLog(@"%@", contact.fullName);
//      huyne = contact;
//    }
//  }
//  
//  // All conversations for myUser
//  NSArray<Conversation *> *conversationsArray = [ServicesManager sharedInstance].conversationsManagerService.conversations;
//  Conversation *theConversation = nil;
//  
//  for(Conversation *conversation in conversationsArray){
//    if(conversation.peer == (Peer *)huyne){
//      theConversation = conversation;
//      break;
//    }
//  }
//  // If there is no conversation with this peer, create a new one
//  if(!theConversation){
//    [[ServicesManager sharedInstance].conversationsManagerService startConversationWithPeer:huyne withCompletionHandler:^(Conversation *conversation, NSError *error) {
//      if(!error){
//        NSLog(@"%@", conversation);
//      } else {
//        NSLog(@"Can't create the new conversation, error: %@", [error description]);
//      }
//    }];
//  }
//  MessagesBrowser *messagesBrowser = [[ServicesManager sharedInstance].conversationsManagerService messagesBrowserForConversation: theConversation withPageSize:kPageSize preloadMessages:YES];
//  [messagesBrowser resyncBrowsingCacheWithCompletionHandler:^(NSArray *addedCacheItems, NSArray *removedCacheItems, NSArray *updatedCacheItems, NSError *error) {
//    NSLog(@"%@", error);
//    NSLog(@"%@", addedCacheItems);
//    NSLog(@"%@", removedCacheItems);
//    NSLog(@"%@", updatedCacheItems);
//    NSLog(@"Resync done");
//  }];
//  
//  [[ServicesManager sharedInstance].rtcService beginNewOutgoingCallWithPeer:huyne withFeatures:RTCCallFeatureAudio];
//}

@end
