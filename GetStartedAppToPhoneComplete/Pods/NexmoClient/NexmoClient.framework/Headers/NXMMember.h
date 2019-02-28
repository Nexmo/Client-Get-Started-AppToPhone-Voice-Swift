//
//  NXMMember.h
//  NexmoClient
//
//  Copyright © 2018 Vonage. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NXMEnums.h"
#import "NXMUser.h"

@class NXMMemberEvent;

@interface NXMMember : NSObject
@property (nonatomic, strong) NSString *conversationId;
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *joinDate;
@property (nonatomic, strong) NSString *inviteDate;
@property (nonatomic, strong) NSString *leftDate;
@property (nonatomic, strong) NXMUser *user;
@property (nonatomic) NXMMemberState state;

- (instancetype)initWithMemberId:(NSString *)memberId
                  conversationId:(NSString *)conversationId
                          user:(NXMUser *)user
                           state:(NXMMemberState)state;

-(instancetype)initWithMemberEvent:(NXMMemberEvent *)memberEvent;
@end
