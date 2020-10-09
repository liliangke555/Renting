//
//  LDRFingerprintCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRFingerprintCell.h"
@interface LDRFingerprintCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@end
@implementation LDRFingerprintCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.backView.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
    [self.backView.layer setCornerRadius:LDRRadius];
    
    [self.nameLabel setTextColor:LDR_TextBalckColor];
    [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
}
- (IBAction)deleteButtonAction:(UIButton *)sender
{
    if (self.didClickDelete) {
        self.didClickDelete();
    }
}
- (void)setDidClickDelete:(void (^)(void))didClickDelete
{
    _didClickDelete = didClickDelete;
}
- (void)setNameString:(NSString *)nameString
{
    _nameString = nameString;
    [self.nameLabel setText:nameString];
}
- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [self.headerImageView setImage:[UIImage imageNamed:imageUrl]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
