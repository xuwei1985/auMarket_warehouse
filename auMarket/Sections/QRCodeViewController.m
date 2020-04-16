//
//  LWQRCodeViewController.m
//  LWProjectFramework
//
//  Created by bhczmacmini on 16/12/28.
//  Copyright © 2016年 LW. All rights reserved.
//

#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "QRCodeBackgroundView.h"
#import "QRCodeScanView.h"

#define ScanY 0.15*HEIGHT_SCREEN           //扫描区域y
#define ScanWidth 0.7*WIDTH_SCREEN       //扫描区域宽度
#define ScanHeight 0.7*WIDTH_SCREEN      //扫描区域高度


@interface QRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong)AVCaptureDevice *device;//创建相机
@property(nonatomic,strong)AVCaptureDeviceInput *input;//创建输入设备
@property(nonatomic,strong)AVCaptureMetadataOutput *output;//创建输出设备
@property(nonatomic,strong)AVCaptureSession *session;//创建捕捉类
@property(strong,nonatomic)AVCaptureVideoPreviewLayer *preview;//视觉输出预览层
@property(strong,nonatomic)QRCodeScanView *scanView;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self capture];
    [self UI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setBarTintColor:COLOR_BLACK];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:COLOR_WHITE,NSFontAttributeName:FONT_SIZE_NAVIGATION}];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.session startRunning];
    [self.scanView startAnimaion];
}

- (void)dealloc
{
    self.device = nil;
    [self.session stopRunning];
    self.session = nil;
    self.input = nil;
    self.output = nil;
    self.preview = nil;
    [self.scanView stopAnimaion];
    self.scanView = nil;
}

#pragma mark - 初始化UI
- (void)UI
{
    self.title=@"扫描条形码";
    //扫描区域
    CGRect scanFrame = CGRectMake((WIDTH_SCREEN-ScanWidth)/2, ScanY, ScanWidth, ScanHeight);
    
    // 创建view,用来辅助展示扫描的区域
    self.scanView = [[QRCodeScanView alloc] initWithFrame:scanFrame];
    [self.view addSubview:self.scanView];
    
    //扫描区域外的背景
    QRCodeBackgroundView *qrcodeBackgroundView = [[QRCodeBackgroundView alloc] initWithFrame:self.view.bounds];
    qrcodeBackgroundView.scanFrame = scanFrame;
    [self.view addSubview:qrcodeBackgroundView];
    
    //提示文字
    UILabel *label = [UILabel new];
    if(self.scan_model==SCAN_GOODS){
        label.text = @"将商品条形码放入框内，即可自动扫描";
    }
    else if(self.scan_model==SCAN_SHELF){
        label.text = @"将货架条形码放入框内，即可自动扫描";
    }
    else if(self.scan_model==SCAN_BOX){
        label.text = @"将货箱条形码放入框内，即可自动扫描";
    }
    else if(self.scan_model==SCAN_PICK_CART){
        label.text = @"将拣货车条形码放入框内，即可自动扫描";
    }
    else if(self.scan_model==SCAN_SHELF_BLOCK){
        label.text = @"将拣货区条形码放入框内，即可自动扫描";
    }
    else{
        label.text = @"将二维码/条形码放入框内，即可自动扫描";
    }
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    label.frame = CGRectMake(0, CGRectGetMaxY(self.scanView.frame)+12, WIDTH_SCREEN, 20);
    [self.view addSubview:label];
    
    
    UIButton *light_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [light_btn setImage:[UIImage imageNamed:@"flashlight_close"] forState:UIControlStateNormal];
    [light_btn setImage:[UIImage imageNamed:@"flashlight_open"] forState:UIControlStateSelected];
    light_btn.frame=CGRectMake((WIDTH_SCREEN-32)/2, HEIGHT_SCREEN-64-120, 32, 32);
    [light_btn addTarget:self action:@selector(swichTorch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:light_btn];

    //灯光和相册
//    NSArray *arr = @[@"灯光",@"相册"];
//
//    for (int i = 0; i < arr.count; i++) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:arr[i] forState:UIControlStateNormal];
//        btn.tag = i;
//        btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
//        btn.frame = CGRectMake(WIDTH_SCREEN/2*i, HEIGHT_SCREEN-50, WIDTH_SCREEN/2, 50);
//        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:btn];
//    }
    
//    NSArray *arr = @[@"关闭"];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:arr[0] forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
//    btn.frame = CGRectMake(0, HEIGHT_SCREEN-48, WIDTH_SCREEN, 48);
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
}

-(void)swichTorch:(UIButton *)sender{
    [self popoverPresentationController];
    Class capture = NSClassFromString(@"AVCaptureDevice");
    if (capture != nil) {
        if ([self.device hasTorch] && [self.device hasFlash]) {
            [self.device lockForConfiguration:nil];
            
            sender.selected = !sender.selected;
            
            if (sender.selected) {
                [self.device setTorchMode:AVCaptureTorchModeOn];
                [self.device setFlashMode:AVCaptureFlashModeOn];
            } else {
                [self.device setTorchMode:AVCaptureTorchModeOff];
                [self.device setFlashMode:AVCaptureFlashModeOff];
            }
            [self.device unlockForConfiguration];
        }
    }
}

#pragma mark - 菜单按钮点击事件
- (void)btnClick:(UIButton *)sender
{
    if (sender.tag == 0) {
        [self popoverPresentationController];
        Class capture = NSClassFromString(@"AVCaptureDevice");
        if (capture != nil) {
            if ([self.device hasTorch] && [self.device hasFlash]) {
                [self.device lockForConfiguration:nil];

                sender.selected = !sender.selected;

                if (sender.selected) {
                    [self.device setTorchMode:AVCaptureTorchModeOn];
                    [self.device setFlashMode:AVCaptureFlashModeOn];
                } else {
                    [self.device setTorchMode:AVCaptureTorchModeOff];
                    [self.device setFlashMode:AVCaptureFlashModeOff];
                }
                [self.device unlockForConfiguration];
            }
        }
    } else {
        UIImagePickerController *imagrPicker = [[UIImagePickerController alloc]init];
        imagrPicker.delegate = self;
        imagrPicker.allowsEditing = YES;
        //将来源设置为相册
        imagrPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        [self presentViewController:imagrPicker animated:YES completion:nil];
    }
}

#pragma mark - 从相册选择识别二维码
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取选中的照片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    //初始化  将类型设置为二维码
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
    
    
    [picker dismissViewControllerAnimated:YES completion:^{
        //设置数组，放置识别完之后的数据
        NSArray *features = [detector featuresInImage:[CIImage imageWithData:UIImagePNGRepresentation(image)]];
        //判断是否有数据（即是否是二维码）
        if (features.count >= 1) {
            //取第一个元素就是二维码所存放的文本信息
            CIQRCodeFeature *feature = features[0];
            NSString *scannedResult = feature.messageString;
            //通过对话框的形式呈现
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果"
                                                            message:scannedResult
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            [self.view addSubview:alert];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果"
                                                            message:@"不是二维码图片"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            [self.view addSubview:alert];
            [alert show];
        }
    }];
    
}

#pragma mark - 初始化扫描设备
- (void)capture
{
    //如果是模拟器返回（模拟器获取不到摄像头）
    if (TARGET_IPHONE_SIMULATOR) {
        return;
    }
    
    // 下面的是比较重要的,也是最容易出现崩溃的原因,就是我们的输出流的类型
    // 1.这里可以设置多种输出类型,这里必须要保证session层包括输出流
    // 2.必须要当前项目访问相机权限必须通过,所以最好在程序进入当前页面的时候进行一次权限访问的判断
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus ==AVAuthorizationStatusRestricted|| authStatus ==AVAuthorizationStatusDenied){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的“设置”-“隐私”-“相机”功能中，找到“某某应用”打开相机访问权限" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //初始化基础"引擎"Device
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //初始化输入流 Input,并添加Device
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    //初始化输出流Output
    self.output = [[AVCaptureMetadataOutput alloc] init];
    
    //设置输出流的相关属性
    // 确定输出流的代理和所在的线程,这里代理遵循的就是上面我们在准备工作中提到的第一个代理,至于线程的选择,建议选在主线程,这样方便当前页面对数据的捕获.
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描区域的大小 rectOfInterest  默认值是CGRectMake(0, 0, 1, 1) 按比例设置
    self.output.rectOfInterest = CGRectMake(ScanY/HEIGHT_SCREEN,((WIDTH_SCREEN-ScanWidth)/2)/WIDTH_SCREEN,ScanHeight/HEIGHT_SCREEN,ScanWidth/WIDTH_SCREEN);
    
    /*
     // AVCaptureSession 预设适用于高分辨率照片质量的输出
     AVF_EXPORT NSString *const AVCaptureSessionPresetPhoto NS_AVAILABLE(10_7, 4_0) __TVOS_PROHIBITED;
     // AVCaptureSession 预设适用于高分辨率照片质量的输出
     AVF_EXPORT NSString *const AVCaptureSessionPresetHigh NS_AVAILABLE(10_7, 4_0) __TVOS_PROHIBITED;
     // AVCaptureSession 预设适用于中等质量的输出。 实现的输出适合于在无线网络共享的视频和音频比特率。
     AVF_EXPORT NSString *const AVCaptureSessionPresetMedium NS_AVAILABLE(10_7, 4_0) __TVOS_PROHIBITED;
     // AVCaptureSession 预设适用于低质量的输出。为了实现的输出视频和音频比特率适合共享 3G。
     AVF_EXPORT NSString *const AVCaptureSessionPresetLow NS_AVAILABLE(10_7, 4_0) __TVOS_PROHIBITED;
     */
    
    // 初始化session
    self.session = [[AVCaptureSession alloc]init];
    // 设置session类型,AVCaptureSessionPresetHigh 是 sessionPreset 的默认值。
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    //将输入流和输出流添加到session中
    // 添加输入流
    if ([_session canAddInput:self.input]) {
        [_session addInput:self.input];
    }
    // 添加输出流
    if ([_session canAddOutput:self.output]) {
        [_session addOutput:self.output];
        
        //扫描格式
        NSMutableArray *metadataObjectTypes = [NSMutableArray array];
        [metadataObjectTypes addObjectsFromArray:@[
                                                   AVMetadataObjectTypeEAN13Code,
                                                   AVMetadataObjectTypeEAN8Code,
                                                   AVMetadataObjectTypeCode128Code,
                                                   AVMetadataObjectTypeCode39Code,
                                                   AVMetadataObjectTypeCode93Code,
                                                   AVMetadataObjectTypeCode39Mod43Code
                                                   ]];
//        AVMetadataObjectTypePDF417Code,
//        AVMetadataObjectTypeAztecCode,
//        AVMetadataObjectTypeUPCECode,
//        AVMetadataObjectTypeQRCode,
        
        // >= ios /Users/wuxuwei/Projects/IOS_Projects/auMarket_warehouse/auMarket/Sections8
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
            [metadataObjectTypes addObjectsFromArray:@[AVMetadataObjectTypeInterleaved2of5Code,
                                                       AVMetadataObjectTypeITF14Code,
                                                       AVMetadataObjectTypeDataMatrixCode]];
        }
        //设置扫描格式
        self.output.metadataObjectTypes= metadataObjectTypes;
    }
    
    
    //设置输出展示平台AVCaptureVideoPreviewLayer
    // 初始化
    self.preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    // 设置Video Gravity,顾名思义就是视频播放时的拉伸方式,默认是AVLayerVideoGravityResizeAspect
    // AVLayerVideoGravityResizeAspect 保持视频的宽高比并使播放内容自动适应播放窗口的大小。
    // AVLayerVideoGravityResizeAspectFill 和前者类似，但它是以播放内容填充而不是适应播放窗口的大小。最后一个值会拉伸播放内容以适应播放窗口.
    // 因为考虑到全屏显示以及设备自适应,这里我们采用fill填充
    self.preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
    // 设置展示平台的frame
    self.preview.frame = CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN);
    // 因为 AVCaptureVideoPreviewLayer是继承CALayer,所以添加到当前view的layer层
    [self.view.layer insertSublayer:self.preview atIndex:0];
    //放大焦距
    
    NSError *error = nil;
    
    [self.device lockForConfiguration:&error];
    
    
    
    if (self.device.activeFormat.videoMaxZoomFactor > 1.5) {
        
        self.device.videoZoomFactor = 1.3;
        
    }else{
        
        self.device.videoZoomFactor = self.device.activeFormat.videoMaxZoomFactor;
        
    }
    
    
    
    [self.device unlockForConfiguration];
    //开始
    [self.session startRunning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.session stopRunning];
    [self.scanView stopAnimaion];
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate
#pragma mark - 扫描结果处理
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //扫描成功播放音效
    [self playSoundEffect:@"scan.wav"];
    
    // 判断扫描结果的数据是否存在
    if ([metadataObjects count] >0){
        // 如果存在数据,停止扫描
        [self.session stopRunning];
        [self.scanView stopAnimaion];
        // AVMetadataMachineReadableCodeObject是AVMetadataObject的具体子类定义的特性检测一维或二维条形码。
        // AVMetadataMachineReadableCodeObject代表一个单一的照片中发现机器可读的代码。这是一个不可变对象描述条码的特性和载荷。
        // 在支持的平台上,AVCaptureMetadataOutput输出检测机器可读的代码对象的数组
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        
        // 获取扫描到的信息
        NSString *stringValue = metadataObject.stringValue;
        if(self.scan_model==SCAN_GOODS){
            if(stringValue!=nil&&stringValue.length==13&&[stringValue hasPrefix:@"0"]){
                stringValue=[stringValue substringFromIndex:1];
            }
        }
        if([self.pass_delegate respondsToSelector:@selector(passObject:)]){
            [self.pass_delegate passObject:[NSDictionary dictionaryWithObjectsAndKeys:stringValue,@"code",[NSString stringWithFormat:@"%lu",(unsigned long)self.scan_model],@"scan_model", nil]];
        }
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self goBack];
        });
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果"
//                                                        message:stringValue
//                                                       delegate:self
//                                              cancelButtonTitle:nil
//                                              otherButtonTitles:@"确定", nil];
//        [self.view addSubview:alert];
//        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self.session startRunning];
    [self.scanView startAnimaion];
}

#pragma mark - - - 扫描提示声
/** 播放音效文件 */
- (void)playSoundEffect:(NSString *)name{
    // 获取音效
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    
    // 1、获得系统声音ID
    SystemSoundID soundID = 0;
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    // 如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    // 2、播放音频
    AudioServicesPlaySystemSound(soundID); // 播放音效
}

/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundCompleteCallback(SystemSoundID soundID, void *clientData){
    NSLog(@"播放完成...");
    
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
