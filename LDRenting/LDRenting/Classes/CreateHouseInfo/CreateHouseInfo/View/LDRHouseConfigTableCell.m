//
//  LDRHouseConfigTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/4.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHouseConfigTableCell.h"
#import "LDRHouseConfigCollectionCell.h"
#import "LDRHouseConfigModel.h"
@interface LDRHouseConfigTableCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation LDRHouseConfigTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(LDRPadding, 40, LDRPadding, 40);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(44, 44);
    layout.minimumLineSpacing = 16;
    CGFloat spacing = (LDR_WIDTH - 80 - 44 * 4) / 3.0f;
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
    cell.check = self.isCheck;
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
