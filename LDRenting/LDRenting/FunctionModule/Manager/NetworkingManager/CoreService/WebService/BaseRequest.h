//
//  BaseRequest.h
//  PartyBuildingCloud
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonBaseObject.h"
#import <AFNetworking.h>



#define RequestMethodGet  @"GET"
#define RequestMethodPut  @"PUT"
#define RequestMethodDelete  @"DELETE"
#define RequestMethodPOST  @"POST"

@class BaseRequest;
@class BaseResponse;

typedef void (^RequestCompletionHandler)(BaseResponse *response);

@interface BaseRequest : JsonBaseObject
{
@protected
    BaseResponse            *_response;
    RequestCompletionHandler _succHandler;
    RequestCompletionHandler _failHandler;
}

@property (strong, nonatomic)AFHTTPSessionManager *sessionManager;

@property (nonatomic, strong) BaseResponse *response;
@property (nonatomic, copy) RequestCompletionHandler succHandler;
@property (nonatomic, copy) RequestCompletionHandler failHandler;

@property (nonatomic, assign) BOOL isRequestParametersMethodJson;
@property (nonatomic, assign) BOOL hideLoadingView;


- (NSString *)uri;

- (NSString *)requestMethod;

- (NSData *)toPostData;

- (Class)responseDataClass;

- (void)parseResponse:(NSObject *)respJsonObject;

// 异步请求Req
- (void)asyncRequestWithsuccessHandler:(RequestCompletionHandler)succHandler failHandler:(RequestCompletionHandler)fail;

- (void)asyncRequestWithFormDatas:(NSArray<NSData *> *)formDatas formName:(NSString *)formName successHandler:(RequestCompletionHandler)succHandler failHandler:(RequestCompletionHandler)fail;

- (void)asyncRequestWithVoiceData:(NSData *)data formName:(NSString *)formName successHandler:(RequestCompletionHandler)succHandler failHandler:(RequestCompletionHandler)fail;


- (void)uploadWitImagedData:(NSData *)imageData
                 uploadName:(NSString *)uploadName
                   progress:(void (^)(NSProgress *progress))progress
             successHandler:(RequestCompletionHandler)succHandler failHandler:(RequestCompletionHandler)fail;



//+ (NSString *)makeSignForVerifyCode:(NSString *)phone phoneType:(NSString *)phoneType;

@end



@interface BaseResponse : JsonBaseObject

@property (assign, nonatomic) NSInteger code;//用来判断请求成功与否 0请求成功 >0请求失败 <0网络连接失败

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *status; //SUCCESSS  fail

@property (strong, nonatomic) id data;

- (BOOL)success;

@end




