//
//  YXBeautifyFilterController.m
//  YXLiveApp
//
//  Created by YuXiang on 2017/5/3.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import "YXBeautifyFilterController.h"
#import "GPUImageBeautifyFilter.h"
#import <GPUImage/GPUImage.h>

@interface YXBeautifyFilterController ()
/** 视频源*/
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
/** 最终目的源*/
@property (nonatomic, strong) GPUImageView *captureVideoPreview;  
@end

@implementation YXBeautifyFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建视频源
    // SessionPreset:屏幕分辨率，AVCaptureSessionPresetHigh会自适应高分辨率
    // cameraPosition:摄像头方向
    GPUImageVideoCamera *videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    _videoCamera = videoCamera;
    
    // 创建最终预览View
    GPUImageView *captureVideoPreview = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:captureVideoPreview atIndex:0];
    _captureVideoPreview = captureVideoPreview;
    
    // 设置处理链
    [_videoCamera addTarget:_captureVideoPreview];
    
    // 必须调用startCameraCapture，底层才会把采集到的视频源，渲染到GPUImageView中，就能显示了。
    // 开始采集视频
    [videoCamera startCameraCapture];
    
}

- (IBAction)openBeautifySwitch:(id)sender {
     // 切换美颜效果原理：移除之前所有处理链，重新设置处理链
    if ([sender isOn]) {
        // 移除之前所有的处理链
        [_videoCamera removeAllTargets];
        
        // 创建美颜滤镜
        GPUImageBeautifyFilter *beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
        
        // 设置GPUImage处理链, 从数据源 -> 滤镜 -> 最终目的源 (界面效果)
        [_videoCamera addTarget:beautifyFilter];
        [beautifyFilter addTarget:_captureVideoPreview];
        
    }else {
        // 移除之前所有的处理链
        [_videoCamera removeAllTargets];
        [_videoCamera addTarget:_captureVideoPreview];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
