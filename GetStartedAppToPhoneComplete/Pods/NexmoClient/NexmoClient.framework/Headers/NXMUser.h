//
//  NXMUser
//  NexmoClient
//
//  Copyright © 2018 Vonage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXMUser : NSObject

@property NSString * _Nonnull userId;
@property NSString * _Nonnull name;
@property NSString * _Nullable displayName;

- (instancetype _Nullable)initWithId:(NSString * _Nonnull)uuid name:(NSString * _Nonnull)name;
- (instancetype _Nullable)initWithId:(NSString * _Nonnull)uuid name:(NSString * _Nonnull)name displayName:(NSString * _Nullable)displayName;

@end


