//
//  LDRLandlordAuthorityController.m
//  LDRenting
//
//  Created by MAC on 2020/8/11.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRLandlordAuthorityController.h"
#import "LDRLockBuleCollectionCell.h"
#import "LDROffLineOpenCollectionCell.h"
#import "LDRLandlordOpenDoorManageController.h"
@interface LDRLandlordAuthorityController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation LDRLandlordAuthorityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"房东权限";
    [self collectionView];
}
#pragma mark -  UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 3;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGFloat itemWidth = (LDR_WIDTH - LDRPadding*3) / 2.0f;
        return CGSizeMake(itemWidth, 78);
    } else {
        CGFloat itemWidth = (LDR_WIDTH - LDRPadding*3) / 2.0f;
        return CGSizeMake(itemWidth, 102);
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LDRLockBuleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LDRLockBuleCollectionCell class]) forIndexPath:indexPath];
        
        return cell;
    }
    LDROffLineOpenCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LDROffLineOpenCollectionCell class]) forIndexPath:indexPath];
    cell.openType = indexPath.item;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                      withReuseIdentifier:@"header"
                                                                             forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] init];
    [header addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left).mas_offset(LDRPadding);
        make.centerY.equalTo(header);
    }];
    [label setFont:LDRFont12];
    [label setTextColor:LDR_tableTitleColor];
    if (indexPath.section == 0) {
        [label setText:@"默认开门方式"];
    } else {
        [label setText:@"设置线下开门方式"];
    }
    return header;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        LDRLandlordOpenDoorManageController *vc = [[LDRLandlordOpenDoorManageController alloc] init];
        vc.openType = indexPath.item;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(LDR_WIDTH, 56);
}
#pragma mark - Getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(LDRPadding, LDRPadding, LDRPadding, LDRPadding);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat itemWidth = (LDR_WIDTH - LDRPadding*3) / 2.0f;
        layout.itemSize = CGSizeMake(itemWidth, 102);
        layout.minimumLineSpacing = LDRPadding;
        layout.minimumInteritemSpacing = LDRPadding;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
        }];
        [_collectionView setBackgroundColor:LDR_BackgroundColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"header"];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRLockBuleCollectionCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([LDRLockBuleCollectionCell class])];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LDROffLineOpenCollectionCell class]) bundle:nil]
        forCellWithReuseIdentifier:NSStringFromClass([LDROffLineOpenCollectionCell class])];
    }
    return _collectionView;
}

@end
