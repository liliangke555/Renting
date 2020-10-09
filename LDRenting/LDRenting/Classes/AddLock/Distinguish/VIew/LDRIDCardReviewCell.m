//
//  LDRIDCardReviewCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/23.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRIDCardReviewCell.h"
#import "LDRIDCradReviewCollectionCell.h"

@interface LDRIDCardReviewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titlesLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation LDRIDCardReviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titlesLabel.textColor = LDR_tableTitleColor;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 16;
    flowLayout.minimumInteritemSpacing = 16;
    flowLayout.sectionHeadersPinToVisibleBounds = YES;
    flowLayout.sectionFootersPinToVisibleBounds = YES;
    flowLayout.itemSize = CGSizeMake((LDR_WIDTH - 80) / 4.0f, 46);;
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRIDCradReviewCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([LDRIDCradReviewCollectionCell class])];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    LDRIDCradReviewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LDRIDCradReviewCollectionCell class])
                                                                                 forIndexPath:indexPath];
    cell.titleS = dic[@"title"];
    cell.typeImageString = dic[@"details"];
    cell.bigImageString = dic[@"imageName"];
    return cell;
}
#pragma mark - Getter
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[
            @{
                @"imageName":@"idcard_standard",
                @"title":@"标准拍摄",
                @"details":@"success_icon"
            },
            @{
                @"imageName":@"idcard_defect",
                @"title":@"边框缺失",
                @"details":@"error_icom"
            },
            @{
                @"imageName":@"idcard_vague",
                @"title":@"照片模糊",
                @"details":@"error_icom"
            },
            @{
                @"imageName":@"idcard_light",
                @"title":@"闪光强烈",
                @"details":@"error_icom"
            },
        ];
    }
    return _dataSource;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
