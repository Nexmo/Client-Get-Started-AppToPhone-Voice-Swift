//
//  NXMCall.h
//  NexmoClient
//
//  Copyright © 2018 Vonage. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NXMCallMember.h"
#import "NXMConversation.h"
#import "NXMBlocks.h"

@protocol NXMCallDelegate
- (void)statusChanged:(nonnull NXMCallMember *)callMember;
@end

typedef NS_ENUM(NSInteger, NXMCallType) {
    NXMCallTypeInApp,
    NXMCallTypeServer
};
typedef NS_ENUM(NSInteger, NXMCallStatus) {
    NXMCallStatusConnected,
    NXMCallStatusDisconnected
};


@interface NXMCall : NSObject

@property (nonatomic, readonly, nonnull) NSMutableArray<NXMCallMember *> *otherCallMembers;
@property (nonatomic, readonly, nonnull) NXMCallMember *myCallMember;
@property (nonatomic, readonly) NXMCallStatus status;
@property (nonatomic, readonly, nonnull) NXMConversation* conversation;

- (void)setDelegate:(nonnull id<NXMCallDelegate>)delegate;

- (void)answer:(nonnull id<NXMCallDelegate>)delegate completionHandler:(NXMErrorCallback _Nullable)completionHandler;
- (void)reject:(NXMErrorCallback _Nullable)completionHandler;

- (void)addCallMemberWithUserId:(NSString *)userId completionHandler:(NXMErrorCallback _Nullable)completionHandler;
- (void)addCallMemberWithNumber:(NSString *)number completionHandler:(NXMErrorCallback _Nullable)completionHandler;

@end

