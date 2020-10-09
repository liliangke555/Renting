//
//  LDRRenantsFlagTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/31.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRRenantsFlagTableCell.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "LDRRenantsFlagCollectionViewCell.h"
#import "LDRCollectionViewLeftOrRightAlignedLayout.h"
@interface LDRRenantsFlagTableCell ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UICollectionViewDelegate,UICollectionViewDataSource,HorizontalCollectionLayoutDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titlesLabel;
@property (weak, nonatomic) IBOutlet UIButton *addFlagButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation LDRRenantsFlagTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.backView.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
    
    [self.titlesLabel setTextColor:LDR_tableTitleColor];
    [self.addFlagButton setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
    self.collectionView.emptyDataSetDelegate = self;
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    LDRCollectionViewLeftOrRightAlignedLayout *flowLayout = [[LDRCollectionViewLeftOrRightAlignedLayout alloc] init];
    flowLayout.itemInset = UIEdgeInsetsMake(LDRPadding, LDRPadding, LDRPadding, LDRPadding);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.lineSpacing = 16;
    flowLayout.interitemSpacing = 8;
    flowLayout.delegate = self;
    self.collectionView.collectionViewLayout = flowLayout;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRRenantsFlagCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
}
- (IBAction)addFlagAction:(UIButton *)sender
{
    if (self.didClickAddFlag) {
        self.didClickAddFlag();
    }
}
- (void)setDidClickAddFlag:(void (^)(void))didClickAddFlag
{
    _didClickAddFlag = didClickAddFlag;
}
#pragma mark - UICollectionViewDataSource
// 用协议传回 item 的内容,用于计算 item 宽度
- (NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath
{
    return self.dataSource[indexPath.row];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.titlesLabel setText:title];
}

- (void)layoutSubviews
{
    CGFloat originY = 0;
    CGFloat originW = LDR_WIDTH - 32;
    CGFloat originH = self.backView.bounds.size.height;
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:CGRectMake(-2, originY, originW +4,originH)];
    self.backView.layer.shadowPath = path.CGPath;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LDRRenantsFlagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    cell.flagType = indexPath.row;
    return cell;
}
#pragma mark - Getter
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@"有长期欠租等不良记录",@"欠租",@"品格好,讲卫生"];
    }
    return _dataSource;
}
#pragma mark - DZNEmptyDataSetSource
// MARK: 空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *title = @"暂无标签";
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRFont12,
        NSForegroundColorAttributeName:LDR_TextLightGrayColor
    };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
@end
