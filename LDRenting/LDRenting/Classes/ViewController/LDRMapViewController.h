//
//  LDRMapViewController.h
//  LDRenting
//
//  Created by MAC on 2020/8/5.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationManager.h>
NS_ASSUME_NONNULL_BEGIN

@protocol LDRMapViewDelegate <NSObject>

- (void)didSelectedAddress:(AMapPOI *)mapPOI;

@end

@interface LDRMapViewController : LDRBaseViewController
@property (nonatomic, weak) id <LDRMapViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
