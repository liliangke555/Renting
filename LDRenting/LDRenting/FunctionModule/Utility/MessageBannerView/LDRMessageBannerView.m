//
//  LDRMessageBannerView.m
//  LDRenting
//
//  Created by MAC on 2020/7/19.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMessageBannerView.h"
#import "LDRHomePageMessageNotifyRequest.h"

@interface LDRMessageBannerView ()
{
    NSInteger currentPage;
}
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSTimer *timer;                     // 定时器
@end

@implementation LDRMessageBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self).insets(UIEdgeInsetsZero);
            make.width.mas_equalTo(32);
        }];
        [imageView setContentMode:UIViewContentModeCenter];
        self.imageView = imageView;
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self).insets(UIEdgeInsetsZero);
            make.left.equalTo(imageView.mas_right).mas_offset(LDRPadding);
//            make.centerY.equalTo(self);
//            make.right.equalTo(self.mas_right);
        }];
        self.label = label;
        label.textColor = [UIColor colorWithHex:0xFD942DFF];
        label.backgroundColor = [UIColor colorWithHex:0xFEFCEEFF];
        label.font = LDRFont14;
        
        currentPage = 0;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMessage:)];
        [self.label addGestureRecognizer:tapRecognizer];
    }
    return self;
}
#pragma mark - IBAction

- (void)tapMessage:(UITapGestureRecognizer *)sender
{
    
}

- (void)handleSwipeFromRight{
    currentPage++;
    if (currentPage >= [self.bannerArray count]) {
        currentPage = 0;
    }
    
    LDRHomeMessageModel *model = self.bannerArray[currentPage];
    NSString *string = @"看房信息";
    if (model.messageNotifyType == 1) {
        string = @"看房信息";
        [self.imageView setImage:[UIImage imageNamed:@"home_renting_message"]];
    } else if (model.messageNotifyType == 2) {
        string = @"催缴信息";
        [self.imageView setImage:[UIImage imageNamed:@"home_call_message"]];
    } else {
        string = @"报警信息";
        [self.imageView setImage:[UIImage imageNamed:@"home_police_message"]];
    }
    [self.label setText:[NSString stringWithFormat:@"收到 %ld 新的%@",model.messageNotifyCount,string]];
    
    //转场动画
    
    CABasicAnimation* rotationAnimation;
      rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
      rotationAnimation.toValue = [NSNumber numberWithFloat: -M_PI * 2.0 ];
      rotationAnimation.duration = 1;
      rotationAnimation.cumulative = YES;
      rotationAnimation.repeatCount = 0;
      [self.imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    CATransition *transition = [[CATransition alloc] init];
//    transition.type = @"cube";                //立方体翻转
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    transition.duration = 0.25;
    [self.label.layer addAnimation:transition forKey:nil];
//    [self.imageView.layer addAnimation:transition forKey:nil];
}

- (void)setupTimer:(CGFloat)timeInterval {
    self.timer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(handleSwipeFromRight) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

#pragma mark - Setter

- (void)setTimeInterval:(CGFloat)timeInterval
{
    _timeInterval = fabs(timeInterval);
    if (self.timer) {
        [self.timer invalidate];
        [self setupTimer:_timeInterval];
    } else {
        [self setupTimer:_timeInterval];
    }
}
- (void)setBannerArray:(NSArray *)bannerArray
{
    _bannerArray = bannerArray;
    if (bannerArray.count > 0) {
        LDRHomeMessageModel *model = bannerArray[0];
        NSString *string = @"看房信息";
        if (model.messageNotifyType == 1) {
            string = @"看房信息";
            [self.imageView setImage:[UIImage imageNamed:@"home_renting_message"]];
        } else if (model.messageNotifyType == 2) {
            string = @"催缴信息";
            [self.imageView setImage:[UIImage imageNamed:@"home_call_message"]];
        } else {
            string = @"报警信息";
            [self.imageView setImage:[UIImage imageNamed:@"home_police_message"]];
        }
        [self.label setText:[NSString stringWithFormat:@"收到 %ld 新的%@",model.messageNotifyCount,string]];
        self.timeInterval = 3;
    }
}

@end
