//
//  LDRSetPassTypeTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSetPassTypeTableCell.h"
#import "LDRSetPassDetailCollectionCell.h"
@interface LDRSetPassTypeTableCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;

@end

@implementation LDRSetPassTypeTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(LDRPadding, LDRPadding, LDRPadding, LDRPadding);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat itemWidth = (LDR_WIDTH - LDRPadding*3) / 2.0f;
    layout.itemSize = CGSizeMake(itemWidth, 56);
    layout.minimumLineSpacing = LDRPadding;
    layout.minimumInteritemSpacing = LDRPadding;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRSetPassDetailCollectionCell class]) bundle:nil]
    forCellWithReuseIdentifier:NSStringFromClass([LDRSetPassDetailCollectionCell class])];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.isSetPassNum) {
        CGFloat itemWidth = (LDR_WIDTH - LDRPadding*5) / 4.0f;
        return CGSizeMake(itemWidth, 36);
    }
    CGFloat itemWidth = (LDR_WIDTH - LDRPadding*3) / 2.0f;
    return CGSizeMake(itemWidth, 56);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.item];
    LDRSetPassDetailCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LDRSetPassDetailCollectionCell class]) forIndexPath:indexPath];
    cell.title = [dic allKeys][0];
    cell.detail = [dic allValues][0];
    cell.selected = (indexPath.item == self.passType);
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.passType = indexPath.item;
    if (self.didChangeType) {
        self.didChangeType(self.passType);
    }
    [self.collectionView reloadData];
}
#pragma mark - Setter
- (void)setDidChangeType:(void (^)(NSInteger))didChangeType
{
    _didChangeType = didChangeType;
}
- (void)setSetPassNum:(BOOL)setPassNum
{
    _setPassNum = setPassNum;
    if (setPassNum) {
        self.dataSource = @[@{@"1次":@""},@{@"2次":@""},@{@"3次":@""},@{@"4次":@""},];
        self.collectionViewHeight.constant = 68.0f;
    } else {
        self.dataSource = @[@{@"一次性密码":@"使用一次后失效"},@{@"多次密码":@"使用超出设置次数后失效"},@{@"限时密码":@"使用超出有效时间后失效"},];
        self.collectionViewHeight.constant = 160.0f;
    }
    [self.collectionView reloadData];
}
#pragma mark - Getter
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@{@"一次性密码":@"使用一次后失效"},@{@"多次密码":@"使用超出设置次数后失效"},@{@"限时密码":@"使用超出有效时间后失效"},];
    }
    return _dataSource;
}
@end
