//
//  LDRHomeMessageBannderView.m
//  LDRenting
//
//  Created by MAC on 2020/7/20.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHomeMessageBannderView.h"

@interface LDRHomeMessageBannderView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, assign) NSInteger currentRow;
@property (nonatomic, strong) UIPickerView *pick;
@property (nonatomic, strong) NSTimer *timer;                     // 定时器
@end

@implementation LDRHomeMessageBannderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIPickerView *pickerView = [[UIPickerView alloc] init];
        [self addSubview:pickerView];
        [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        self.pick = pickerView;
        [pickerView setBackgroundColor:[UIColor colorWithHex:0xFEFCEEFF]];
        self.backgroundColor = [UIColor colorWithHex:0xFEFCEEFF];
        
//        [self changeSpearatorLineColor];
    }
    return self;
}

- (void)changeSpearatorLineColor
{
    for(UIView *speartorView in self.pick.subviews)
    {
        [speartorView setBackgroundColor:[UIColor clearColor]];
        if (speartorView.frame.size.height < 1)//取出分割线view
        {
            speartorView.hidden = YES;
        }
    }
}

#pragma mark - UIPickerViewDelegate

//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
//{
//    return ;
//}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.dataSource count]*4000;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.dataSource objectAtIndex:row % [self.dataSource count]];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc] init];
        [label setFont:LDRFont14];
        [label setTextColor:[UIColor colorWithHex:0xFD942DFF]];
        [label setBackgroundColor:[UIColor colorWithHex:0xFEFCEEFF]];
    }
    [label setText:[self pickerView:pickerView titleForRow:row forComponent:component]];
    [self changeSpearatorLineColor];
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"--- 点当前 %ld",row % [self.dataSource count]);
}
#pragma mark - UIPickerViewDataSource

- (void)handleSwipeFromRight{
    _currentRow ++;
    [self.pick selectRow:_currentRow inComponent:0 animated:YES];
}
#pragma mark - Setter
- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    [self.pick reloadAllComponents];
}
- (void)setTimeInterval:(CGFloat)timeInterval
{
    _timeInterval = fabs(timeInterval);
    _currentRow = 0;
    if (self.timer) {
        [self.timer invalidate];
        [self setupTimer:_timeInterval];
    } else {
        [self setupTimer:_timeInterval];
    }
}
- (void)setupTimer:(CGFloat)timeInterval {
    self.timer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(handleSwipeFromRight) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}
@end
