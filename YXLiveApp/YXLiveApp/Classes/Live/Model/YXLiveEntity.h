//
//  YXLiveEntity.h
//  YXLiveApp
//
//  Created by YuXiang on 2017/5/2.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "YXLiveItem.h"
#import "YXHTTPManager.h"
#import <MJExtension/MJExtension.h>

@interface YXLiveEntity : NSObject
@property (nonatomic, strong) RACCommand *fetchLiveEntityCommand;
@end
