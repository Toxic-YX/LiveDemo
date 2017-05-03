//
//  YXLiveViewController.m
//  YXLiveApp
//
//  Created by YuXiang on 2017/5/2.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import "YXLiveViewController.h"
#import <UIImageView+WebCache.h>
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "YXLiveItem.h"
#import "YXCreatorItem.h"

@interface YXLiveViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@end

@implementation YXLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置直播占位图片
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_live.creator.portrait]];
    [self.bgImageView sd_setImageWithURL:imageUrl placeholderImage:nil];
    
    // 拉流地址
    NSURL *url = [NSURL URLWithString:_live.stream_addr];
    
    // 创建IJKFFMoviePlayerController：专门用来直播，传入拉流地址就好了
    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
    
    // 准备播放
    [playerVc prepareToPlay];
    
    // 强引用，防止被销毁
    _player = playerVc;
    
    playerVc.view.frame = [UIScreen mainScreen].bounds;
    
    [self.view insertSubview:playerVc.view atIndex:1];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 界面消失，一定要记得停止播放
    [_player pause];
    [_player stop];
    [_player shutdown];
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
