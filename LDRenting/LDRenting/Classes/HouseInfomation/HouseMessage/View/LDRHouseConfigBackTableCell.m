//
//  LDRHouseConfigTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/7.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHouseConfigBackTableCell.h"
#import "LDRHouseConfigCollectionCell.h"
#import "LDRHouseConfigModel.h"
@interface LDRHouseConfigBackTableCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation LDRHouseConfigBackTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.backView.layer setShadowOffset:CGSizeZero];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
    
    [self.titleLabel setTextColor:LDR_tableTitleColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(LDRPadding, LDRPadding, LDRPadding, LDRPadding);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(44, 44);
    layout.minimumLineSpacing = 16;
    CGFloat spacing = (LDR_WIDTH - 100 - 44 * 4) / 3.0f;
    layout.minimumInteritemSpacing = spacing;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRHouseConfigCollectionCell class]) bundle:nil]
      forCellWithReuseIdentifier:NSStringFromClass([LDRHouseConfigCollectionCell class])];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LDRHouseConfigModel *model = [self.dataSource objectAtIndex:indexPath.item];
    LDRHouseConfigCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LDRHouseConfigCollectionCell class]) forIndexPath:indexPath];
    [cell.titleLabel setText:model.title];
    UIImage *image = [UIImage imageNamed:model.imageUrl];
    
    [cell.headerImageView setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    cell.check = YES;
    cell.selected = model.isSelected;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LDRHouseConfigModel *model = [self.dataSource objectAtIndex:indexPath.item];
    model.selected = !model.isSelected;
    [self.collectionView reloadData];
}
#pragma mark - Getter
- (NSArray *)dataSource
{
    if (!_dataSource) {
        NSMutableArray *array = [NSMutableArray array];
        {
            LDRHouseConfigModel *model = [LDRHouseConfigModel createModelWithTitle:@"WIFI" imageurl:@"house_wifi"];
            [array addObject:model];
        }
        {
            LDRHouseConfigModel *model = [LDRHouseConfigModel createModelWithTitle:@"电视" imageurl:@"house_tv"];
            [array addObject:model];
        }
        {
            LDRHouseConfigModel *model = [LDRHouseConfigModel createModelWithTitle:@"床" imageurl:@"house_bed"];
            [array addObject:model];
        }
        {
            LDRHouseConfigModel *model = [LDRHouseConfigModel createModelWithTitle:@"衣柜" imageurl:@"house_wardrobe"];
            [array addObject:model];
        }
        {
            LDRHouseConfigModel *model = [LDRHouseConfigModel createModelWithTitle:@"冰箱" imageurl:@"house_friger"];
            [array addObject:model];
        }
        {
            LDRHouseConfigModel *model = [LDRHouseConfigModel createModelWithTitle:@"空调" imageurl:@"house_air"];
            [array addObject:model];
        }
        {
            LDRHouseConfigModel *model = [LDRHouseConfigModel createModelWithTitle:@"洗衣机" imageurl:@"house_washing"];
            [array addObject:model];
        }
        {
            LDRHouseConfigModel *model = [LDRHouseConfigModel createModelWithTitle:@"热水器" imageurl:@"house_heater"];
            [array addObject:model];
        }
        _dataSource = array;
    }
    return _dataSource;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat originW = self.backView.bounds.size.width;
    CGFloat originH = self.backView.bounds.size.height;
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:CGRectMake(-2, 0, originW +4,originH+2 )];
    self.backView.layer.shadowPath = path.CGPath;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
