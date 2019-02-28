//
//  NXMCallMember.h
//  NexmoClient
//
//  Copyright © 2018 Vonage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXMUser.h"

typedef NS_ENUM(NSInteger, NXMCallMemberStatus) {
    NXMCallMemberStatusDialling,
    NXMCallMemberStatusCalling,
    NXMCallMemberStatusStarted,
    NXMCallMemberStatusAnswered,
    NXMCallMemberStatusCancelled,
    NXMCallMemberStatusCompleted
};

@interface NXMCallMember : NSObject

@property (nonatomic, readonly, nonnull) NSString *callId;
@property (nonatomic, readonly, nonnull) NSString *memberId;
@property (nonatomic, readonly, nonnull) NXMUser *user;
@property (nonatomic, readonly) BOOL isMuted;
@property (nonatomic, readonly) NXMCallMemberStatus status;
@property (nonatomic, readonly, nullable) NSString *metaInfo;

- (void)hangup;
- (void)hold:(BOOL)isHold;
- (void)mute:(BOOL)isMute;
- (void)earmuff:(BOOL)isEarmuff;

@end



