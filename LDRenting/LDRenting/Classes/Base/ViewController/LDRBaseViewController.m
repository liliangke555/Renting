//
//  LDRBaseViewController.m
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseViewController.h"

@interface LDRBaseViewController ()

@end

@implementation LDRBaseViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isWhiteBack) {
        self.navigationItem.leftBarButtonItem =
        [UIBarButtonItem ldr_BackItemWithImage:[UIImage imageNamed:@"navigation_back_white"] WithHighlightedImage:[UIImage imageNamed:@"navigation_back_white"] Target:self action:@selector(backAction:) title:@""];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : LDR_BackgroundColor,
        NSFontAttributeName : LDRBoldFont17}];
    } else {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : LDR_TextBalckColor,
        NSFontAttributeName : LDRBoldFont17}];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view setBackgroundColor:[UIColor greenColor]];
}
#pragma mark - IBAction
/// 返回按钮事件
/// @param sender button
- (void)backAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    NSLog(@"- %@ - 销毁",NSStringFromClass([self class]));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
