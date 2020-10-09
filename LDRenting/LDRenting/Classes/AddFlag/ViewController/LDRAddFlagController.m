//
//  LDRAddFlagController.m
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAddFlagController.h"
#import "LDRFlagModel.h"
#import "LDRFlagCell.h"
#import "LDRAddFlagCollectionReusableView.h"
static NSString * const LDRGoodFlag = @"良好标签";
static NSString * const LDRwarningFlag = @"警告标签";
@interface LDRAddFlagController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *bootomView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation LDRAddFlagController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self headerView];
    self.navigationController.navigationBar.translucent = NO;
    [self bootomView];
    [self collectionView];
}
#pragma mark - IBAction
- (void)buttonAction:(UIButton *)sender
{
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataSource count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.dataSource objectAtIndex:section][@"detail"] count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LDRFlagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LDRFlagCell class]) forIndexPath:indexPath];
    LDRFlagModel *model = [self.dataSource[indexPath.section][@"detail"] objectAtIndex:indexPath.row];
    cell.title = model.title;
    NSString *key = [self.dataSource objectAtIndex:indexPath.section][@"key"];
    if ([key isEqualToString:LDRGoodFlag]) {
        cell.flagType = LDRFlagTypeGood;
    }
    if ([key isEqualToString:LDRwarningFlag]) {
        cell.flagType = LDRFlagTypeWarning;
    }
    cell.selected = model.isSelected;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LDRFlagModel *model = [self.dataSource[indexPath.section][@"detail"] objectAtIndex:indexPath.row];
    model.selected = !model.isSelected;
//    LDRFlagCell *cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
//    cell.selected = model.selected;
    [self.collectionView reloadData];
}
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        LDRAddFlagCollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:@"header"
                                                                                           forIndexPath:indexPath];
        NSString *key = [self.dataSource objectAtIndex:indexPath.section][@"key"];
        header.titleString =key;
        
        return header;
    }
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:@"footer"
                                                                                   forIndexPath:indexPath];
        
        return header;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(LDR_WIDTH, 48);
}
#pragma mark - Getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setSectionInset:UIEdgeInsetsMake(LDRPadding, LDRPadding, LDRPadding, LDRPadding)];
        CGFloat itemW = (LDR_WIDTH - LDRPadding - LDRPadding - 20) / 3;
        CGFloat itemH = 44;
        flowLayout.itemSize = CGSizeMake(itemW, itemH);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 8;
        flowLayout.minimumInteritemSpacing = 8;
        //设置footerView大小
        flowLayout.footerReferenceSize = CGSizeMake(LDR_WIDTH, 24);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerView.mas_bottom);
            make.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.bottom.equalTo(self.bootomView.mas_top);
        }];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView setBackgroundColor:LDR_BackgroundColor];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRFlagCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([LDRFlagCell class])];
        [_collectionView registerClass:[LDRAddFlagCollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:@"footer"];
    }
    return _collectionView;
}
- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        [_headerView setBackgroundColor:LDR_BackgroundColor];
        [self.view addSubview:_headerView];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
        UILabel *label = [[UILabel alloc] init];
        [_headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headerView.mas_left).mas_offset(LDRPadding);
            make.centerY.equalTo(_headerView);
            make.top.bottom.equalTo(_headerView).insets(UIEdgeInsetsMake(LDRPadding, 0, LDRPadding, 0));
        }];
        [label setFont:LDRBoldFont24];
        [label setTextColor:LDR_TextBalckColor];
        [label setText:@"添加标签"];
    }
    return  _headerView;
}
- (UIView *)bootomView
{
    if (!_bootomView) {
        _bootomView = [[UIView alloc] init];
        [self.view addSubview:_bootomView];
        [_bootomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
        [_bootomView setBackgroundColor:LDR_BackgroundColor];
        UIButton *button = [UIButton mainButtonWithTarget:self action:@selector(buttonAction:)];
        [_bootomView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bootomView.mas_top).mas_offset(LDRPadding);
            make.left.right.equalTo(_bootomView).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
            make.height.mas_equalTo(LDRButtonHeight);
            make.bottom.equalTo(_bootomView.mas_bottom).mas_offset(-LDRPadding-KBottomSafeHeight);
        }];
        [button setTitle:@"保存" forState:UIControlStateNormal];
    }
    return _bootomView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        NSMutableArray *arrM = [NSMutableArray array];
        {
            LDRFlagModel *model = [LDRFlagModel modelWithTitle:@"品格好，讲卫生"];
            [arrM addObject:model];
        }
        {
            LDRFlagModel *model = [LDRFlagModel modelWithTitle:@"干净整洁"];
            [arrM addObject:model];
        }
        {
            LDRFlagModel *model = [LDRFlagModel modelWithTitle:@"按时缴费"];
            [arrM addObject:model];
        }
        {
            LDRFlagModel *model = [LDRFlagModel modelWithTitle:@"按时缴费11"];
            [arrM addObject:model];
        }
        [_dataSource addObject:@{@"key":LDRGoodFlag,@"detail":arrM}];
        [_dataSource addObject:@{@"key":LDRwarningFlag,@"detail":arrM}];
    }
    return _dataSource;
}
@end
