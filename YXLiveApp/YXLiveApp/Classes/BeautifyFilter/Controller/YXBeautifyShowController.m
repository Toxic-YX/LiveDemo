//
//  YXBeautifyShowController.m
//  YXLiveApp
//
//  Created by YuXiang on 2017/5/3.
//  Copyright © 2017年 Rookie.YXiang. All rights reserved.
//

#import "YXBeautifyShowController.h"
#import <GPUImage/GPUImage.h>

@interface YXBeautifyShowController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *handleImage;
@property (strong, nonatomic) UIImage *chooseImage;
@end

@implementation YXBeautifyShowController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [_handleImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addHandleImage)]];
}

#pragma mark --- 滑块

/**
 亮度
 */
- (IBAction)brightnessSlider:(UISlider *)sender {
}

/**
 曝光
 */
- (IBAction)exposureSlider:(UISlider *)sender {
}

/**
 饱和度
 */
- (IBAction)saturationSlider:(UISlider *)sender {
}

/**
 彩色模糊
 */
- (IBAction)colorFuzzySlider:(UISlider *)sender {
}

#pragma mark --- 按钮
/**
 红边框
 */
- (IBAction)redBorder:(UIButton *)sender {
}

/**
 绿边框
 */
- (IBAction)greenBorder:(UIButton *)sender {
}

/**
 锐化
 */
- (IBAction)sharpen:(UIButton *)sender {
}

/**
 浮雕效果
 */
- (IBAction)relief:(UIButton *)sender {
}

/**
 水晶球效果
 */
- (IBAction)crystalBall:(UIButton *)sender {
}

/**
 溶解
 */
- (IBAction)dissolve:(UIButton *)sender {
}

/**
 柔光混合
 */
- (IBAction)softLightBlend:(UIButton *)sender {
}

/**
 哈哈镜
 */
- (IBAction)distortingMirror:(UIButton *)sender {
}


/**
 图形倒立
 */
- (IBAction)graphicsOn:(UIButton *)sender {
}

/**
 鱼眼效果
 */
- (IBAction)fisheyeEffects:(UIButton *)sender {
}

#pragma mark  --- 图片点击事件
- (void)addHandleImage {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择需要处理的图片" message:@"您可以拍照或者从相册中取出图片" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //首先需要判断资源是否可用
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
            
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //获得相机模式下支持的媒体类型
            //        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            pickerImage.delegate = self;
            //设置允许编辑
            pickerImage.allowsEditing = YES;
            
            [self presentViewController:pickerImage animated:YES completion:^{
            }];  
        }
    }];
    
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // 打开本地相册
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            // 设置类型为相机
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = sourceType;
            //设置是否显示相机控制按钮 默认为YES
            picker.showsCameraControls = YES;
            
            //        //创建叠加层(例如添加的相框)
            //        UIView *overLayView=[[UIView alloc]initWithFrame:CGRectMake(0, 120, 320, 254)];
            //        //取景器的背景图片，该图片中间挖掉了一块变成透明，用来显示摄像头获取的图片；
            //        UIImage *overLayImag=[UIImage imageNamed:@"beij.png"];
            //        UIImageView *bgImageView=[[UIImageView alloc]initWithImage:overLayImag];
            //        [overLayView addSubview:bgImageView];
            //        picker.cameraOverlayView=overLayView;
            
            //选择前置摄像头或后置摄像头
            picker.cameraDevice=UIImagePickerControllerCameraDeviceFront;
            [self presentViewController:picker animated:YES completion:^{
            }];
        }else {
            NSLog(@"该设备无相机");
        }
        
    }];
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:deleteAction];
    
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - 从相册选择图片后操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //NSLog(@"%@",info);
    
    //获取源图像（未经裁剪）
    //    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //获取裁剪后的图像
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    //将照片存到媒体库
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    self.handleImage.image = image;
    
    //将照片存到沙盒
    [self saveImage:image];
    
    _chooseImage = image;
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - 照片存到本地后的回调
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    if (!error) {
        NSLog(@"存储成功");
    } else {
        NSLog(@"存储失败：%@", error);
    }
}

#pragma mark - 保存图片
- (void) saveImage:(UIImage *)currentImage {
    //设置照片的品质
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    
    NSLog(@"%@",NSHomeDirectory());
    // 获取沙盒目录
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/currentImage.png"];
    // 将图片写入文件
    [imageData writeToFile:filePath atomically:NO];
    //将选择的图片显示出来
   [self.handleImage setImage:[UIImage imageWithContentsOfFile:filePath]];
}

#pragma mark - 取消操作时调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}
@end
