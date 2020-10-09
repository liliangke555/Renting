//
//  LDRHouseInfoFooterView.m
//  LDRenting
//
//  Created by MAC on 2020/7/22.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHouseInfoFooterView.h"
#import "LDRHouseInfoCollectionCell.h"
@interface LDRHouseInfoFooterView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *backCollectionView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation LDRHouseInfoFooterView


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 16;
    flowLayout.minimumInteritemSpacing = 16;
    flowLayout.sectionHeadersPinToVisibleBounds = YES;
    flowLayout.sectionFootersPinToVisibleBounds = YES;
    flowLayout.itemSize = CGSizeMake((LDR_WIDTH - 48) / 2.0f, 56);;
    self.backCollectionView.collectionViewLayout = flowLayout;
    self.backCollectionView.delegate = self;
    self.backCollectionView.dataSource = self;
    [self.backCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRHouseInfoCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([LDRHouseInfoCollectionCell class])];
}

#pragma mark - UICollectionViewDelegate
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    LDRHouseInfoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LDRHouseInfoCollectionCell class])
                                                                                 forIndexPath:indexPath];
    cell.title = dic[@"title"];
    cell.details = dic[@"details"];
    cell.imageUrl = dic[@"imageName"];
    return cell;
}
#pragma mark - Getter
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[
            @{
                @"imageName":@"houseinfo_travel",
                @"title":@"出租安全",
                @"details":@"租客身份预警"
            },
            @{
                @"imageName":@"houseinfo_rent",
                @"title":@"租金安全",
                @"details":@"欠租征信催缴"
            },
            @{
                @"imageName":@"houseinfo_key",
                @"title":@"钥匙安全",
                @"details":@"六大安全解锁方式"
            },
            @{
                @"imageName":@"houseinfo_alarm",
                @"title":@"联网报警求助",
                @"details":@"联网报警求助"
            },
            @{
                @"imageName":@"houseinfo_landlady",
                @"title":@"房东安全",
                @"details":@"房东30万第三责任险"
            },
            @{
                @"imageName":@"houseinfo_resource",
                @"title":@"房源安全",
                @"details":@"严选房源发布"
            },
        ];
    }
    return _dataSource;
}

@end
