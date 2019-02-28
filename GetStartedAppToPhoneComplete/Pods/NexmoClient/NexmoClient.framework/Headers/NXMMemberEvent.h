//
//  NXMMemberEvent.h
//  NexmoNClient
//
//  Copyright © 2018 Vonage. All rights reserved.
//

#import "NXMEvent.h"
#import "NXMUser.h"
#import "NXMMediaSettings.h"

typedef NS_ENUM(NSInteger, NXMChannelType){
    NXMChannelTypeApp,
    NXMChannelTypePhone,
    NXMChannelTypeUnknown
};

@interface NXMMemberEvent : NXMEvent

@property (nonatomic, strong, nonnull) NSString *memberId;
@property (nonatomic) NXMMemberState state;
@property (nonatomic, strong, nonnull) NXMUser *user;
@property (nonatomic, strong, nonnull) NSString *phoneNumber;
@property (nonatomic, strong, nullable) NXMMediaSettings *media;
@property (nonatomic) NXMChannelType channelType;
@property (nonatomic, strong, nullable) NSString *channelData;
@property (nonatomic, strong, nullable) NSString *knockingId;

@end
