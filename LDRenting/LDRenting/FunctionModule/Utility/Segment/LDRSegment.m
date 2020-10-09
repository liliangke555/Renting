//
//  LDCommunitySegment.m
//  Community
//
//  Created by MAC on 2020/6/2.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "LDRSegment.h"

@interface LDRSegment ()

@property (strong, nonatomic) NSArray * titles;
@property (strong, nonatomic) NSMutableArray * buttons;
@property (strong, nonatomic) LDPointView * point;
@property (strong, nonatomic) UIView * lineView;

@end

static CGFloat const fontSize = 16.0f;
static CGFloat const buttonWidth = 100;

@implementation LDRSegment
+ (instancetype)segmentWithTitles:(NSArray <NSString *>*)titles
{
    LDRSegment *seg = [[LDRSegment alloc] initWithTitles:titles];
    return seg;
}

- (instancetype)initWithTitles:(NSArray <NSString *>*)titles
{
    self = [super init];
    if (self) {
        _titles = titles;
        [self setupView];
    }
    return self;
}
- (void)setupView
{
    if (@available(iOS 13.0, *)) {
        self.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        // Fallback on earlier versions
        self.backgroundColor = [UIColor whiteColor];
    }
    if (_titles) {
        int i = 0;
        for (NSString *string in _titles) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (@available(iOS 13.0, *)) {
                [button setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
            } else {
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                // Fallback on earlier versions
            }
            [button setTitle:string forState:UIControlStateNormal];
            [self addSubview:button];
            button.tag = i;
            if (i == 0) {
                [button setTitleColor:LDR_TextBalckColor forState:UIControlStateNormal];
            } else {
                [button setTitleColor:LDR_TextGrayColor forState:UIControlStateNormal];
            }
            [button.titleLabel setFont:LDRFont16];
            [self.buttons addObject:button];
            [button addTarget:self action:@selector(didChangeIndex:) forControlEvents:UIControlEventTouchUpInside];
            i ++;
        }
        
        LDPointView *point = [[LDPointView alloc] init];
        [self addSubview:point];
        self.point = point;
        
        UIView *lineView = [[UIView alloc] init];
        [lineView setBackgroundColor:LDR_GrayColor];
        [self addSubview:lineView];
        self.lineView = lineView;
    }
}
- (void)didChangeIndex:(UIButton *)sender
{
    self.selectedIndex = sender.tag;
    if (self.didChengeSelected) {
        self.didChengeSelected(self.selectedIndex);
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    for (int i = 0; i < self.buttons.count; i ++) {
        UIButton *button = self.buttons[i];
        button.frame = CGRectMake(buttonWidth * i, 0, buttonWidth, CGRectGetHeight(self.frame));
    }
    self.point.frame = CGRectMake((buttonWidth * _selectedIndex) + buttonWidth / 2.0 - 10, CGRectGetHeight(self.frame) - 10, 20, 10);
    self.lineView.frame = CGRectMake(16, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame) - 32, 0.5);
}
#pragma mark - Getter

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
#pragma mark - Setter
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    for (UIButton *button in self.buttons) {
        [button setTitleColor:LDR_TextGrayColor forState:UIControlStateNormal];
        if (button.tag == selectedIndex) {
            [button setTitleColor:LDR_TextBalckColor forState:UIControlStateNormal];
        }
    }
}
- (void)setContentOffX:(CGFloat)contentOffX
{
    _contentOffX = contentOffX;
    self.point.frame = CGRectMake(buttonWidth/2.0 - 10 + contentOffX * buttonWidth, CGRectGetHeight(self.frame) - 10, 20, 10);
}
- (void)setDidChengeSelected:(void (^)(NSInteger))didChengeSelected
{
    _didChengeSelected = didChengeSelected;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@interface LDPointView ()

@end
@implementation LDPointView

- (void)drawRect:(CGRect)rect {
    
    CGFloat R = CGRectGetWidth(self.frame)/2.0;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //背景颜色设置
    if (@available(iOS 13.0, *)) {
        [[UIColor systemBackgroundColor] set];
    } else {
        // Fallback on earlier versions
        [[UIColor whiteColor] set];
    }
    CGContextFillRect(context, rect);
    
    //边框宽度
    CGContextSetLineWidth(context, 0.0);
    CGContextMoveToPoint(context, R, R);
    UIColor *color = [UIColor colorWithHex:0x21C76733];
    //填充颜色
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextAddArc(context, R, R, R, 0, M_PI, 1);//如果圆弧是顺时针画的，“clockwise”是1，否则是0;
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);

    //填充颜色
    CGContextSetFillColorWithColor(context, LDR_MainGreenColor.CGColor);
    CGContextAddArc(context, R, R, R / 2, 0, M_PI, 1);//如果圆弧是顺时针画的，“clockwise”是1，否则是0;
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

@end
