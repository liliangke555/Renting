//
//  JsonBaseObject.h
//  HaiXing
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonBaseObject : NSObject

//对象转字典
- (NSMutableDictionary *)getJsonDictionary;

//jsonString
- (NSString *)getJsonString;

//jsondata
- (NSData *)getJsonData;

@end
