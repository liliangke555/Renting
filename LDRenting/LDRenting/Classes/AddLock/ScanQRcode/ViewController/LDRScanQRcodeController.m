//
//  LDRScanQRcodeController.m
//  LDRenting
//
//  Created by MAC on 2020/7/20.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRScanQRcodeController.h"
#import <AVFoundation/AVFoundation.h>
#import "LDRScanQRModel.h"
static CGFloat const lineHeight = 48;
//static CGFloat const topPadding = 112;
static CGFloat const bottomPadding = 46;
static CGFloat const lightButtonHeight = 60;
static CGFloat const bottomHeight = 46 + 60 + 20 + 46;

@interface LDRScanQRcodeController ()<AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>{
    NSTimer *_timer;
     int num;
}
@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureDeviceInput * input;
@property (strong, nonatomic) AVCaptureMetadataOutput * output;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;
@property (retain, nonatomic) UIImageView *line;
@property (nonatomic, strong) UILabel *openLightLabel;
@property (nonatomic, strong) UIImageView *pointImage;

@end

@implementation LDRScanQRcodeController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage ldr_imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage ldr_imageWithColor:[UIColor blackColor]]];
    
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        __weak typeof(self)weakSelf = self;
        MMPopupItemHandler block = ^(NSInteger index){
                NSLog(@"clickd %@ button",@(index));
            if (index == 1) {
                NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if([[UIApplication sharedApplication] canOpenURL:url]) {
                    NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                }
            } else {
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }
        };
        NSArray *items =@[MMItemMake(LDRAlterCancle, MMItemTypeNormal, block),
                          MMItemMake(LDRAlterGoTo, MMItemTypeNormal, block)];
        LDRAlterView *alertView = [[LDRAlterView alloc] initWithTitle:@"提示"
                                                             detail:@"请在iphone的“设置-隐私-相机”选项中，允许App访问你的相机"
                                                              items:items];
        alertView.attachedView.mm_dimBackgroundBlurEnabled = YES;
        alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleDark;
        [alertView show];
    } else {
        [self initView];
    }
}
- (void)viewDidLoad {
    self.whiteBack = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"扫码添加";
    [self.view setBackgroundColor:[UIColor blackColor]];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.session stopRunning];
    [_timer setFireDate:[NSDate distantFuture]];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_timer) {
        [_timer invalidate];
    }
}

#pragma mark -
- (void)initView {
    if (self.device == nil) {
        __weak typeof(self)weakSelf = self;
        MMPopupItemHandler block = ^(NSInteger index){
                NSLog(@"clickd %@ button",@(index));
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
        NSArray *items =@[MMItemMake(LDRAlterYes, MMItemTypeNormal, block)];
        LDRAlterView *alertView = [[LDRAlterView alloc] initWithTitle:@"提示"
                                                             detail:@"未检测到摄像头！"
                                                              items:items];
        alertView.attachedView.mm_dimBackgroundBlurEnabled = YES;
        alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleDark;
        [alertView show];
        return;
    }
    [self addTimer];
    [self addImageView];
    [self scanSetup];
}
- (void)scanResult:(NSString *)string
{
    LDRScanQRModel *model = [LDRScanQRModel mj_objectWithKeyValues:string];
    NSString *result = string;
    BOOL mac = NO;
    if (model.ad.length > 0) {
        result = [model.ad stringByReplacingOccurrencesOfString:@"-" withString:@""];
        mac = YES;
    }
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            if ([weakSelf.delegate respondsToSelector:@selector(didScanQRCompletion:isMac:)]) {
                [weakSelf.delegate didScanQRCompletion:result isMac:mac];
            }
        }];
    });
}
#pragma mark - IBAction
- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//控制扫描线上下滚动
- (void)timerMethod
{
    num ++;
    _line.frame = CGRectMake(0, num, LDR_WIDTH, lineHeight);
    if (num == (int)(CGRectGetHeight(self.view.frame) - bottomHeight - KBottomSafeHeight - lineHeight-10)) {
        num = 0;
    }
}
- (void)openLightAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        [self.openLightLabel setText:@"轻触关闭"];
        [self turnOn];
    } else {
        [self turnOff];
        [self.openLightLabel setText:@"轻触照亮"];
    }
}
- (void)otherButtonAction:(UIButton *)sender
{
    __weak typeof(self)weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
            if ([weakSelf.delegate respondsToSelector:@selector(didClickNoQRCode)]) {
                [weakSelf.delegate didClickNoQRCode];
            }
    }];
    
}
#pragma mark - Private
-(void) turnOn
{
    [self.device lockForConfiguration:nil];
    [self.device setTorchMode:AVCaptureTorchModeOn];
    [self.device unlockForConfiguration];
}

-(void) turnOff
{
    [self.device lockForConfiguration:nil];
    [self.device setTorchMode:AVCaptureTorchModeOff];
    [self.device unlockForConfiguration];
}

- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.008 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
}
//添加扫描框
- (void)addImageView
{
    _line = [[UIImageView alloc]initWithFrame:CGRectMake(0, -lineHeight, LDR_WIDTH, lineHeight)];
    _line.image = [[UIImage imageNamed:@"qrcode_line"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.view addSubview:_line];
    [_line setContentMode:UIViewContentModeCenter];
    
    UIButton *otherButton = [UIButton buttonWithTarget:self action:@selector(otherButtonAction:)];
    [self.view addSubview:otherButton];
    [otherButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(-bottomPadding-KBottomSafeHeight);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
    }];
    [otherButton setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
    [otherButton setTitle:@"我没有或无法扫码?" forState:UIControlStateNormal];
    [otherButton.titleLabel setFont:LDRFont14];
    
    UIButton *button = [UIButton buttonWithTarget:self action:@selector(openLightAction:)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(otherButton.mas_top).mas_offset(-bottomPadding);
        make.width.height.mas_equalTo(lightButtonHeight);
    }];
    [button setImage:[UIImage imageNamed:@"open_light_normal"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"open_light_selected"] forState:UIControlStateSelected];
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(button.mas_bottom).mas_offset(8);
        make.centerX.equalTo(button);
    }];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:LDRFont14];
    [label setText:@"轻触照亮"];
    self.openLightLabel = label;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    [imageView setImage:[UIImage imageNamed:@"qr_point"]];
    self.pointImage = imageView;
}

/// 计算扫描区域
/// @param rect 扫描区域 rect
- (CGRect)rectOfInterestByScanViewRect:(CGRect)rect
{
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    CGFloat x = (height - CGRectGetHeight(rect)) / 2 / height;
    CGFloat y = (width - CGRectGetWidth(rect)) / 2 / width;
    CGFloat w = CGRectGetHeight(rect) / height;
    CGFloat h = CGRectGetWidth(rect) / width;
    return CGRectMake(x, y, w, h);
}
//初始化扫描配置
- (void)scanSetup
{
    
    self.preview.videoGravity = AVLayerVideoGravityResize;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode]];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    [self.session startRunning];
    
}
//暂定扫描
- (void)stopScan
{
    [self.session stopRunning];
    [_timer setFireDate:[NSDate distantFuture]];
    _line.hidden = YES;
}
- (void)starScan
{
    [self.session startRunning];
    [_timer setFireDate:[NSDate distantPast]];
    _line.hidden = NO;
}

/// 计算二维码中心点
/// @param array 二维码四个点的坐标
- (void)pointScanQRWithPoits:(NSArray *)array
{
    if ([array count] < 3) {
        return;
    }
    NSDictionary *oneDic = array[0];
    NSDictionary *twoDic = array[2];
    CGFloat oneY = [[oneDic objectForKey:@"Y"] floatValue];
    CGFloat oneX = [[oneDic objectForKey:@"X"] floatValue];
    CGFloat twoY = [[twoDic objectForKey:@"Y"] floatValue];
    CGFloat twoX = [[twoDic objectForKey:@"X"] floatValue];
    CGFloat centerX = (1 - ((fabs(oneY - twoY) / 2.0) + (oneY > twoY ? twoY : oneY))) * CGRectGetWidth(self.preview.frame);
    CGFloat centerY = ((fabs(oneX - twoX) / 2.0) + (oneX > twoX ? twoX : oneX)) * CGRectGetHeight(self.preview.frame);
    
    self.pointImage.frame = CGRectMake(0, 0, 28, 28);
    self.pointImage.center = CGPointMake(centerX, centerY);
}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if ([metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        if ([metadataObject isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            NSString *stringValue = [metadataObject stringValue];
            [self pointScanQRWithPoits:[metadataObject corners]];
            if (stringValue != nil) {
                [self.session stopRunning];
                [_timer invalidate];
                [self scanResult:stringValue];
                NSLog(@"%@",stringValue);
            }
        }
    }
}
#pragma mark - Getter
- (AVCaptureDevice *)device
{
    if (_device == nil) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}
 
- (AVCaptureDeviceInput *)input
{
    if (_input == nil) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}
 
- (AVCaptureMetadataOutput *)output
{
    
    if (_output == nil) {
        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //限制扫描区域(上下左右)
        [_output setRectOfInterest:CGRectMake(0, 0, 1, 1)];
    }
    return _output;
}
 
- (AVCaptureSession *)session
{
    if (_session == nil) {
        //session
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input]) {
            [_session addInput:self.input];
        }
        if ([_session canAddOutput:self.output]) {
            [_session addOutput:self.output];
        }
    }
    return _session;
}
 
- (AVCaptureVideoPreviewLayer *)preview
{
    if (_preview == nil) {
        _preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    }
    return _preview;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.preview.frame = CGRectMake(0, 0, LDR_WIDTH, CGRectGetHeight(self.view.frame) - bottomHeight - KBottomSafeHeight);
}
@end
