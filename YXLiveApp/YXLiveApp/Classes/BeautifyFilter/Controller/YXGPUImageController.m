//
//  YXGPUImageController.m
//  YXLiveApp
//
//  Created by YuXiang on 2017/5/3.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import "YXGPUImageController.h"
#import <GPUImage/GPUImage.h>

@interface YXGPUImageController ()

/** 视频源*/
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
/** 双边滤波,模糊度*/
@property (nonatomic, strong) GPUImageBilateralFilter *bilateralFilter;
/** 亮度*/
@property (nonatomic, strong) GPUImageBrightnessFilter *brightnessFilter;

@end

@implementation YXGPUImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建视频源
    // SessionPreset:屏幕分辨率，AVCaptureSessionPresetHigh会自适应高分辨率
    // cameraPosition:摄像头方向
    // 最好使用AVCaptureSessionPresetHigh，会自动识别，如果用太高分辨率，当前设备不支持会直接报错
    GPUImageVideoCamera *videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    _videoCamera = videoCamera;

    // 创建最终预览View
    GPUImageView *captureVideoPreview = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:captureVideoPreview atIndex:0];
    
    // 创建滤镜：磨皮，美白，组合滤镜
    GPUImageFilterGroup *groupFilter = [[GPUImageFilterGroup alloc] init];
    
    // 磨皮滤镜
    GPUImageBilateralFilter *bilateralFilter = [[GPUImageBilateralFilter alloc] init];
    [groupFilter addTarget:bilateralFilter];
    _bilateralFilter = bilateralFilter;
    
    // 美白滤镜
    GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    [groupFilter addTarget:brightnessFilter];
    _brightnessFilter = brightnessFilter;
    
    // 设置滤镜组链
    [bilateralFilter addTarget:brightnessFilter];
    [groupFilter setInitialFilters:@[bilateralFilter]];
    groupFilter.terminalFilter = brightnessFilter;
    
    // 设置GPUImage处理链，从数据源 => 滤镜 => 最终界面效果
    [videoCamera addTarget:groupFilter];
    [groupFilter addTarget:captureVideoPreview];
    
    // 必须调用startCameraCapture，底层才会把采集到的视频源，渲染到GPUImageView中，就能显示了。
    // 开始采集视频
    [videoCamera startCameraCapture];

}

/**
 亮度设置

 @param sender <#sender description#>
 */
- (IBAction)brightnessFilter:(id)sender {
    UISlider *slider = (UISlider *)sender;
     _brightnessFilter.brightness = slider.value;
}

/**
 双边滤波设置,模糊度

 @param sender <#sender description#>
 */
- (IBAction)bilateralFilter:(id)sender {
    UISlider *slider = (UISlider *)sender;
    // 值越小，磨皮效果越好
    CGFloat maxValue = 10;
    [_bilateralFilter setDistanceNormalizationFactor:(maxValue - slider.value)];
}
@end
