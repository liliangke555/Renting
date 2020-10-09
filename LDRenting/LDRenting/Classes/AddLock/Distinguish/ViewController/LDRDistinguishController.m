//
//  LDRDistinguishController.m
//  LDRenting
//
//  Created by MAC on 2020/7/23.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRDistinguishController.h"
#import "LDRIDCardReviewCell.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import "LDRBottomPoliceView.h"
//static CGFloat bottomImageHeight = 40;
//static CGFloat reviewIDCardHeight = 150;
static CGFloat const bottomHeight = 153.0f;
@interface LDRDistinguishController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) LDRBottomPoliceView *bottomView;
@property (nonatomic, strong) UIView *idcardBackView;
@property (nonatomic, copy) NSString *imageBase;
@end

@implementation LDRDistinguishController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"拍摄证件添加信息";
    [self setupView];
}

- (void)setupView
{
//    self.tableView.tableHeaderView = self.idcardBackView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRIDCardReviewCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRIDCardReviewCell class])];
    [self bottomView];
}
#pragma mark - Networking
- (void)loadImageData
{
    LDRWeakify(self);
    [LDRHUD showLoadingInView:self.view];
    LDROrganizationRequest *request = [LDROrganizationRequest new];
    request.base64 = self.imageBase;
    request.idCardSide = @"front";
    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
        [LDRHUD hideHUDForView:weakSelf.view];
        LDROrganizationModel *model = response.data;
        LDROrganizationResultModel *result = model.words_result;
        if ([weakSelf.delegate respondsToSelector:@selector(distinguishResultWithName:idCardNo:)]) {
            [weakSelf.delegate distinguishResultWithName:result.name.words idCardNo:result.certificateNo.words];
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failHandler:^(BaseResponse *response) {
        [LDRHUD hideHUDForView:weakSelf.view];
    }];
}
#pragma mark - IBAction
- (void)distinguishAction:(UIButton *)sender
{
    NSLog(@"-- 相册 --");
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
    {
        // 无权限
        [self showAlterMessage:@"请在iphone的“设置-隐私-相机”选项中，允许App访问你的相册"];
        return;
    }
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
//        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
}
- (void)didClickCamre
{
    NSLog(@"-- 拍照 --");
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
    {
        // 无权限
        [self showAlterMessage:@"请在iphone的“设置-隐私-相机”选项中，允许App访问你的相机"];
        return;
    }
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
       UIImagePickerController *picker = [[UIImagePickerController alloc] init];
       picker.delegate = self;
//       picker.allowsEditing = YES;
       picker.sourceType = UIImagePickerControllerSourceTypeCamera;
       [self presentViewController:picker animated:YES completion:nil];
    }
}
- (void)showAlterMessage:(NSString *)message
{
    MMPopupItemHandler block = ^(NSInteger index){
       if (index == 1) {
           NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
           if([[UIApplication sharedApplication] canOpenURL:url]) {
               NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
               [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
           }
       }
    };
    NSArray *items =@[MMItemMake(LDRAlterCancle, MMItemTypeNormal, block),
                     MMItemMake(LDRAlterGoTo, MMItemTypeNormal, block)];
    LDRAlterView *alertView = [[LDRAlterView alloc] initWithTitle:@"提示"
                                                        detail:message
                                                         items:items];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = YES;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleDark;
    [alertView show];
}
#pragma mark - UIImagePickerControllerDelegate
//获取到图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (image) {
            NSData *imageData = [image compressImageToByte:200*1024];
            NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            self.imageBase = encodedImageStr;
            if (encodedImageStr) {
                [self loadImageData];
            }
        }
    }];
}
#pragma mark - DZNEmptyDataSetSource

// MARK: 空白页显示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"idcard_background"];
}
// MARK: 空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"点击拍摄识别人面像";
    NSRange range = [title rangeOfString:@"人面像"];
    NSMutableAttributedString *fontAttributeNameStr = [[NSMutableAttributedString alloc] initWithString:title];
    [fontAttributeNameStr addAttribute:NSFontAttributeName value:LDRFont16 range:NSMakeRange(0, title.length)];
    [fontAttributeNameStr addAttribute:NSForegroundColorAttributeName value:LDR_TextBalckColor range:NSMakeRange(0, title.length)];
    [fontAttributeNameStr addAttribute:NSForegroundColorAttributeName value:LDR_MainGreenColor range:range];
    return fontAttributeNameStr;
}
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    NSLog(@"--识别身份证--");
    [self didClickCamre];
}
#pragma mark - Getter
//- (UIView *)idcardBackView
//{
//    if (!_idcardBackView) {
//        _idcardBackView = [[UIView alloc] init];
//        [_idcardBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickCamre:)]];
//
//        UIImageView *imageView = [[UIImageView alloc] init];
//        [_idcardBackView addSubview:imageView];
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(_idcardBackView);
//        }];
//        [imageView setImage:[UIImage imageNamed:@"idcard_background"]];
//        UILabel *label = [[UILabel alloc] init];
//        [_idcardBackView addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(imageView.mas_bottom).mas_offset(LDRPadding);
//            make.centerX.equalTo(imageView);
//        }];
//        [label setFont:LDRFont16];
//        [label setTextColor:[UIColor colorWithHex:0x353F4FFF]];
//        [label setAttributedText:[@"点击拍摄识别人像面" getMainColorAttributeWithString:@"人像面"]];
//    }
//    return _idcardBackView;
//}
- (LDRBottomPoliceView *)bottomView
{
    if (!_bottomView) {
        LDRWeakify(self);
        _bottomView = [[LDRBottomPoliceView alloc] initWithButtonTitle:@"识别照片" action:^{
            [weakSelf distinguishAction:nil];
        }];
        _bottomView.enable = YES;
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(bottomHeight+KBottomSafeHeight);
        }];
    }
    return _bottomView;
}

- (void)viewDidLayoutSubviews
{
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).insets(UIEdgeInsetsZero);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
//    self.idcardBackView.frame = CGRectMake(0, 0, LDR_WIDTH, CGRectGetHeight(self.tableView.frame) - reviewIDCardHeight - KNavBarHeight);
    [self.tableView reloadData];
}

@end
