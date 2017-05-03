//
//  YXHTTPManager.m
//  YXLiveApp
//
//  Created by YuXiang on 2017/5/2.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import "YXHTTPManager.h"

@implementation YXHTTPManager
+ (instancetype)shareManager {
    
    YXHTTPManager *mgr = [super manager];
    NSMutableSet *mgrSet = [NSMutableSet set];
    mgrSet.set = mgr.responseSerializer.acceptableContentTypes;
    [mgrSet addObject:@"text/html"];
    [mgrSet addObject:@"text/plain"];
    mgr.responseSerializer.acceptableContentTypes = mgrSet;
    
    return mgr;
}
@end
