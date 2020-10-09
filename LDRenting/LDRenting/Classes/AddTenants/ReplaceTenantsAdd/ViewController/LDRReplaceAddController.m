//
//  LDRReplaceAddController.m
//  LDRenting
//
//  Created by MAC on 2020/7/30.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRReplaceAddController.h"
#import "LDRInputInfoCell.h"
#import "LDRBottomPoliceView.h"
#import "LDRReplceAddSuccessController.h"
static NSString *const Title = @"租客信息";
static NSString *const Name = @"姓名";
static NSString *const Phone = @"联系电话";
static NSString *const IDCard = @"身份证号码";
static CGFloat const tableViewHeight = 330.0f;
@interface LDRReplaceAddController ()
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) LDRBottomPoliceView *bottomView;
@end

@implementation LDRReplaceAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"替租客登记";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRInputInfoCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([LDRInputInfoCell class])];
    
    [self bottomView];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRInputInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRInputInfoCell class])];
    NSString *title = [self.array objectAtIndex:indexPath.row][@"title"];
    cell.title = title;
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return Title;
}
#pragma mark - Getter
-(NSArray *)array
{
    if (!_array) {
        _array = @[@{@"title":Name},@{@"title":Phone},@{@"title":IDCard}];
    }
    return _array;
}
#pragma mark - Getter
- (LDRBottomPoliceView *)bottomView
{
    if (!_bottomView) {
        LDRWeakify(self);
        _bottomView = [[LDRBottomPoliceView alloc] initWithButtonTitle:LDRButtonNextStep action:^{
            LDRReplceAddSuccessController *vc = [[LDRReplceAddSuccessController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        [self.view addSubview:_bottomView];
        
        _bottomView.enable = YES;
    }
    return _bottomView;
}
- (void)viewDidLayoutSubviews
{
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        make.height.mas_equalTo(tableViewHeight);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        make.top.equalTo(self.tableView.mas_bottom);
    }];
}
@end
