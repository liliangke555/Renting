//
//  LDRHomeMessageTableViewCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/15.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHomeMessageTableViewCell.h"

@interface LDRHomeMessageTableViewCell ()

@property (nonatomic, copy) void(^didSetImageView)(UIImageView *);
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LDRHomeMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
//    [self setBackgroundColor:[UIColor clearColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
        make.centerY.equalTo(self);
        make.top.equalTo(self).mas_offset(6);
        make.bottom.equalTo(self).mas_offset(-6);
    }];

    [imageView setImage:[UIImage imageNamed:@"home_message_one"]];
    [imageView.layer setCornerRadius:LDRRadius];
    self.backImageView = imageView;
    
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(165);
        make.height.mas_equalTo(33);
    }];
    [label setBackgroundColor:LDR_GrayColor];
    [label setTextColor:LDR_TextGrayColor];
    [label.layer setCornerRadius:33/2.0f];
    [label setClipsToBounds:YES];
    [label setFont:LDRFont12];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.hidden = YES;
    self.titleLabel = label;
}
#pragma mark - Setter
- (void)setImageToImageView:(void (^)(UIImageView * _Nonnull))setImage
{
//    setImage;
    if (setImage) {
        setImage(self.backImageView);
    }
}
- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    if (titleString) {
        self.titleLabel.hidden = NO;
        self.titleLabel.text = titleString;
    } else {
        self.titleLabel.hidden = YES;
    }
}
#pragma mark - Layout
- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.backImageView.frame = CGRectMake(LDRPadding, 6, CGRectGetWidth(self.frame) - 2*LDRPadding, CGRectGetHeight(self.frame) - 12);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
