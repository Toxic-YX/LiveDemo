//
//  YXHTTPManager.h
//  YXLiveApp
//
//  Created by YuXiang on 2017/5/2.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface YXHTTPManager : AFHTTPSessionManager
+ (instancetype)shareManager;
@end
