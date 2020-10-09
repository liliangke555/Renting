//
//  LDRCreateHousePhotoTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/4.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRCreateHousePhotoTableCell.h"
#import "LDRContentImageCollectionCell.h"
#import "MMSheetView.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import <TZImagePickerController/TZImageRequestOperation.h>
#import <MobileCoreServices/MobileCoreServices.h>
static NSInteger const MaxPhoto = 9;
@interface LDRCreateHousePhotoTableCell ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
TZImagePickerControllerDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>
{
    NSMutableArray *_selectedAssets;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeight;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (strong, nonatomic) CLLocation *location;
@end

@implementation LDRCreateHousePhotoTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    [self.desLabel setTextColor:LDR_TextGrayColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(LDRPadding, LDRPadding, LDRPadding, LDRPadding);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat itemW = (LDR_WIDTH - LDRPadding*4) / 3;
    layout.itemSize = CGSizeMake(itemW, itemW);
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRContentImageCollectionCell class]) bundle:nil]
      forCellWithReuseIdentifier:NSStringFromClass([LDRContentImageCollectionCell class])];
    
    _selectedAssets = [NSMutableArray array];
}
#pragma mark -
- (void)reviewImageWithIndex:(NSInteger)index
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:self.dataSource index:index];
    imagePickerVc.maxImagesCount = MaxPhoto;
    imagePickerVc.allowPickingGif = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingMultipleVideo = YES;
    imagePickerVc.showSelectedIndex = YES;
    imagePickerVc.isSelectOriginalPhoto = NO;
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    __weak typeof(self)weakSelf = self;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        weakSelf.dataSource = [NSMutableArray arrayWithArray:photos];
        self->_selectedAssets = [NSMutableArray arrayWithArray:assets];
        [weakSelf.collectionView reloadData];
    }];
    [[UINavigationController findVisibleViewController] presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)addImage
{
    MMPopupItemHandler block = ^(NSInteger index){
            NSLog(@"clickd %@ button",@(index));
        if (index == 0) {
            [self takePhoto];
        } else {
            [self pushTZImagePickerController];
        }
    };
    NSArray *items =@[MMItemMake(@"拍摄", MMItemTypeNormal, block),
                      MMItemMake(@"去相册选择", MMItemTypeNormal, block)];
    MMSheetView *alertView = [[MMSheetView alloc] initWithTitle:@"" items:items];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = YES;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleDark;
    [alertView show];
}
- (void)pushTZImagePickerController
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:MaxPhoto columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.barItemTextColor = [UIColor blackColor];
    [imagePickerVc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    imagePickerVc.navigationBar.tintColor = [UIColor blackColor];
    imagePickerVc.naviBgColor = [UIColor whiteColor];
    imagePickerVc.navigationBar.translucent = NO;
   // 1.设置目前已经选中的图片数组
   imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
   imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
   imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按

   imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
   imagePickerVc.showPhotoCannotSelectLayer = YES;
   imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
   [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
       [doneButton setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
//       [numberImageView setBackgroundColor:LDR_MainGreenColor];
   }];
   // 3. Set allow picking video & photo & originalPhoto or not
   // 3. 设置是否可以选择视频/图片/原图
   imagePickerVc.allowPickingVideo = NO;
   imagePickerVc.allowPickingImage = YES;
   imagePickerVc.allowPickingOriginalPhoto = YES;
   imagePickerVc.allowPickingGif = NO;
   imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
   
   // 4. 照片排列按修改时间升序
   imagePickerVc.sortAscendingByModificationDate = YES;
   
   /// 5. Single selection mode, valid when maxImagesCount = 1
   /// 5. 单选模式,maxImagesCount为1时才生效
   imagePickerVc.showSelectBtn = NO;
   imagePickerVc.allowCrop = NO;
   imagePickerVc.needCircleCrop = NO;
   imagePickerVc.scaleAspectFillCrop = YES;
   imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
   // 设置是否显示图片序号
   imagePickerVc.showSelectedIndex = YES;
    imagePickerVc.preferredLanguage = @"zh-Hans";
   imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [[UINavigationController findVisibleViewController] presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark -
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    self.dataSource = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    CGFloat itemW = (LDR_WIDTH - LDRPadding*4) / 3;
    if (self.dataSource.count > 5) {
        self.collectionHeight.constant = LDR_WIDTH;
    } else if (self.dataSource.count > 2 && self.dataSource.count <= 5) {
        self.collectionHeight.constant = itemW * 2 + 2 * LDRPadding;
    } else {
        self.collectionHeight.constant = itemW + 2 * LDRPadding;
    }
    [self.collectionView reloadData];
    if (self.didReliadTableView) {
        self.didReliadTableView();
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataSource.count >= MaxPhoto) {
        return MaxPhoto;
    }
    return self.dataSource.count + 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LDRContentImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LDRContentImageCollectionCell class]) forIndexPath:indexPath];
    if (indexPath.item == self.dataSource.count) {
        cell.deleteButton.hidden = YES;
        [cell.imageView setImage:[UIImage imageNamed:@"add_image_background"]];
    } else {
        cell.deleteButton.hidden = NO;
        [cell.imageView setImage:self.dataSource[indexPath.item]];
        LDRWeakify(self);
        [cell setDidDelete:^{
            [weakSelf.dataSource removeObjectAtIndex:indexPath.item];
            [self->_selectedAssets removeObjectAtIndex:indexPath.item];
            CGFloat itemW = (LDR_WIDTH - LDRPadding*4) / 3;
            if (weakSelf.dataSource.count > 5) {
                weakSelf.collectionHeight.constant = LDR_WIDTH;
            } else if (weakSelf.dataSource.count > 2 && weakSelf.dataSource.count <= 5) {
                weakSelf.collectionHeight.constant = itemW * 2 + 2 * LDRPadding;
            } else {
                weakSelf.collectionHeight.constant = itemW + 2 * LDRPadding;
            }
            [weakSelf.collectionView reloadData];
            if (weakSelf.didReliadTableView) {
                weakSelf.didReliadTableView();
            }
        }];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == self.dataSource.count) {
        [self addImage];
    } else {
        [self reviewImageWithIndex:indexPath.item];
    }
}
#pragma mark - UIImagePickerController
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == kCLAuthorizationStatusRestricted || authStatus == kCLAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        MMPopupItemHandler block = ^(NSInteger index){
                NSLog(@"clickd %@ button",@(index));
            if (index == 0) {
                
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]
                                                   options:nil
                                         completionHandler:nil];
            }
        };
        NSArray *items =@[MMItemMake(@"取消", MMItemTypeNormal, block),
                          MMItemMake(@"设置", MMItemTypeNormal, block)];
        LDRAlterView*alert = [[LDRAlterView alloc] initWithTitle:@"无法使用相机" detail:@"请在iPhone的""设置-隐私-相机""中允许访问相机" items:items];
        [alert show];
    } else if (authStatus == kCLAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        MMPopupItemHandler block = ^(NSInteger index){
                NSLog(@"clickd %@ button",@(index));
            if (index == 0) {
                
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]
                                                   options:nil
                                         completionHandler:nil];
            }
        };
        NSArray *items =@[MMItemMake(@"取消", MMItemTypeNormal, block),
                          MMItemMake(@"设置", MMItemTypeNormal, block)];
        LDRAlterView*alert = [[LDRAlterView alloc] initWithTitle:@"无法使用相机" detail:@"请在iPhone的""设置-隐私-相机""中允许访问相机" items:items];
        [alert show];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        [mediaTypes addObject:(NSString *)kUTTypeImage];
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [[UINavigationController findVisibleViewController] presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
//        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    tzImagePickerVc.sortAscendingByModificationDate = YES;
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSDictionary *meta = [info objectForKey:UIImagePickerControllerMediaMetadata];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image meta:meta location:self.location completion:^(PHAsset *asset, NSError *error){
            [tzImagePickerVc hideProgressHUD];
            if (error) {
//                NSLog(@"图片保存失败 %@",error);
            } else {
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
            }
        }];
    } else if ([type isEqualToString:@"public.movie"]) {
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        if (videoUrl) {
            [[TZImageManager manager] saveVideoWithUrl:videoUrl location:self.location completion:^(PHAsset *asset, NSError *error) {
                [tzImagePickerVc hideProgressHUD];
                if (!error) {
                    TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                        if (!isDegraded && photo) {
                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:photo];
                        }
                    }];
                }
            }];
        }
    }
}

- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [self.dataSource addObject:image];
    CGFloat itemW = (LDR_WIDTH - LDRPadding*4) / 3;
    if (self.dataSource.count > 5) {
        self.collectionHeight.constant = LDR_WIDTH;
    } else if (self.dataSource.count > 2 && self.dataSource.count <= 5) {
        self.collectionHeight.constant = itemW * 2 + 2 * LDRPadding;
    } else {
        self.collectionHeight.constant = itemW + 2 * LDRPadding;
    }
    [self.collectionView reloadData];
    if (self.didReliadTableView) {
        self.didReliadTableView();
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - Getter
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = [UIColor redColor];
        _imagePickerVc.navigationBar.tintColor = [UINavigationController currentNC].navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
        BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
 
    }
    return _imagePickerVc;
}
- (void)setDidReliadTableView:(void (^)(void))didReliadTableView
{
    _didReliadTableView = didReliadTableView;
}
- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    [self.titleLabel setText:titleString];
}
- (void)setDetailString:(NSString *)detailString
{
    _detailString = detailString;
    [self.desLabel setText:detailString];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
