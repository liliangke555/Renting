//
//  LDRHomeHouseManagerCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/15.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHomeHouseManagerCell.h"

typedef void(^DidClick)(void);

@interface LDRHomeHouseManagerCell ()
@property (weak, nonatomic) IBOutlet UILabel *houseTitle;
@property (weak, nonatomic) IBOutlet UILabel *housePeople;
@property (weak, nonatomic) IBOutlet UIView *houseBackView;
@property (weak, nonatomic) IBOutlet UILabel *tenantPeople;
@property (weak, nonatomic) IBOutlet UIView *tenantBackView;
@property (weak, nonatomic) IBOutlet UILabel *tenantTitle;

@property (nonatomic, copy) DidClick didClickHouse;
@property (nonatomic, copy) DidClick didClickTenant;

@end

@implementation LDRHomeHouseManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.houseBackView.layer setCornerRadius:LDRRadius];
    [self.houseTitle setTextColor:LDR_TextBalckColor];
    [self.housePeople setTextColor:LDR_TextGrayColor];
    [self.tenantBackView.layer setCornerRadius:LDRRadius];
    [self.tenantTitle setTextColor:LDR_TextBalckColor];
    [self.tenantPeople setTextColor:LDR_TextGrayColor];
    
    [self.houseBackView.layer setShadowOffset:CGSizeZero];
    [self.houseBackView.layer setShadowRadius:LDRShadowRadius];
    [self.houseBackView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.houseBackView.layer setShadowOpacity:1.0f];
    
    [self.tenantBackView.layer setShadowOffset:CGSizeZero];
    [self.tenantBackView.layer setShadowRadius:LDRShadowRadius];
    [self.tenantBackView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.tenantBackView.layer setShadowOpacity:1.0f];
    
    [self.houseBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(houseAction:)]];
    [self.tenantBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tenantAction:)]];
}
#pragma mark - IBAction
- (void)houseAction:(UITapGestureRecognizer *)sender
{
    if (self.didClickHouse) {
        self.didClickHouse();
    }
}
- (void)tenantAction:(UITapGestureRecognizer *)sender
{
    if (self.didClickTenant) {
        self.didClickTenant();
    }
}
- (void)didClickHouse:(void (^)(void))clickHouse clickTenant:(void (^)(void))clickTenant
{
    self.didClickHouse = clickHouse;
    self.didClickTenant = clickTenant;
}
#pragma mark - Setter
- (void)setHouseNumber:(NSString *)houseNumber
{
    _houseNumber = houseNumber;
    self.housePeople.text = [NSString stringWithFormat:@"共 %@ 人",houseNumber];
}

- (void)setTenantNumber:(NSString *)tenantNumber
{
    _tenantNumber = tenantNumber;
    self.tenantPeople.text = [NSString stringWithFormat:@"共 %@ 人",tenantNumber];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
