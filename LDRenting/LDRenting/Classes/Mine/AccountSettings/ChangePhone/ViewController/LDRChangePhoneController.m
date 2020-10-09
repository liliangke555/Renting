//
//  LDRChangePhoneController.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRChangePhoneController.h"
#import "LDRInputInfoCell.h"
#import "LDRSendCodeViewCell.h"
static NSString *const LDROriginal = @"原手机号";
static NSString *const LDRNew = @"新手机号";
static NSString *const LDRCode = @"验证码";
@interface LDRChangePhoneController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation LDRChangePhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改手机号";
    self.dataSource = @[LDROriginal,LDRNew,LDRCode];
    [self.tableBakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRInputInfoCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LDRInputInfoCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LDRSendCodeViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LDRSendCodeViewCell class])];
    [self.tableView setRowHeight:56];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *title = [self.dataSource objectAtIndex:indexPath.row];
    
    if ([title isEqualToString:LDRCode]) {
        LDRSendCodeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRSendCodeViewCell class])];
        
        return cell;
    }
    LDRInputInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRInputInfoCell class])];
    [cell setTitle:title];
    return cell;
}

@end
