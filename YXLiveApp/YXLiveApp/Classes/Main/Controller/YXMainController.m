//
//  YXMainController.m
//  YXLiveApp
//
//  Created by YuXiang on 2017/5/2.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import "YXMainController.h"
#import "YXCaputureController.h"
#import "YXBroadcastListController.h"

@interface YXMainController ()

@end

@implementation YXMainController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"直播APP功能";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 采集视屏

 @param sender <#sender description#>
 */
- (IBAction)caputreViedo:(id)sender {
    
    [self pushSpecifiedController:@"YXCaputureController"];
   
}

/**
 主播列表

 @param sender <#sender description#>
 */
- (IBAction)playVideo:(id)sender {
    
    [self pushSpecifiedController:@"YXBroadcastListController"];
    
}

/**
 GPUImage原生美颜

 @param sender <#sender description#>
 */
- (IBAction)GPUImageFilter:(id)sender {
    [self pushSpecifiedController:@"YXGPUImageController"];
}

/**
 利用美颜滤镜美颜

 @param sender <#sender description#>
 */
- (IBAction)beautifyFilter:(id)sender {
    [self pushSpecifiedController:@"YXBeautifyFilterController"];
}

/**
 美图秀秀各种美颜

 @param sender <#sender description#>
 */
- (IBAction)beautifyShows:(id)sender {
    [self pushSpecifiedController:@"YXBeautifyShowController"];
}

/**
 跳转控制器

 @param controllerName 控制器的名字
 */
- (void)pushSpecifiedController:(NSString *)controllerName {
    if(NSClassFromString(controllerName) == nil){
        NSLog(@"%@ 不存在",controllerName);
        return;
    }
    id vc = [[NSClassFromString(controllerName) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
