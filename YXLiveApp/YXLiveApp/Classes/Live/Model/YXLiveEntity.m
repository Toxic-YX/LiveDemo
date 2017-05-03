//
//  YXLiveEntity.m
//  YXLiveApp
//
//  Created by YuXiang on 2017/5/2.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import "YXLiveEntity.h"

@implementation YXLiveEntity

- (instancetype)init {
    if (self = [super init]) {
        [self setupRACCommad];
    }
    return self;
}

- (void)setupRACCommad {
    @weakify(self);
    _fetchLiveEntityCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestForEntityWithUrl:input success:^(NSArray *array) {
                
                NSArray *arrayM = [YXLiveItem mj_objectArrayWithKeyValuesArray:array];
                [subscriber sendNext:arrayM];
                [subscriber sendCompleted];
                
            } failure:^(AFHTTPRequestSerializer *operation, NSError *error) {
                
            }];
            return nil;
        }];
    }];
}

- (void)requestForEntityWithUrl:(NSString *)url success:(void(^)(NSArray *array))success failure:(void (^)(AFHTTPRequestSerializer *operation, NSError *error))failure  {
    [[YXHTTPManager shareManager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *temArray = responseObject[@"lives"];
        success(temArray);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
@end
