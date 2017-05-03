//
//  VLCAddress.h
//  JerkLive
//
//  Created by YuXiang on 2017/4/28.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VLCAddress : NSObject
+(instancetype)sharedInstance;
- (NSDictionary *)loadVLCUrlAddress;
@end
