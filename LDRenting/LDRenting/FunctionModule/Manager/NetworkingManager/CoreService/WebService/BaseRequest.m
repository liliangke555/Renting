//
//  BaseRequest.m
//  PartyBuildingCloud
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import "BaseRequest.h"
#import "JSONKit.h"
//#import "HUDHelper.h"
//#import "GTMBase64.h"
//#import "EJSUserModel.h"
#import "NSObject+AutoCoding.h"
#import "LDRRefreshTokenRequest.h"
#import "LDRPhoneCodeLoginRequest.h"

static NSString * const Authorization = @"eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJhNGViZDcyNS1hOTIyLTRhMjQtYWEyMC02OGEyMjY3M2Y3MWUiLCJsb2dpbk5hbWUiOiIxMzA4Nzg0OTgwMCIsInVzZXJJZCI6IjE3NzAzOTg1Mzc5NjEwNjI0IiwiaXAiOiIxMjcuMC4wLjEiLCJjbGllbnRJZCI6Imxvb2tkb29yX21pbmlfYXBwIiwibG9naW5Tb3VyY2UiOiJNSU5JX0FQUCIsImdyYW50VHlwZSI6Ik1JTklfQVBQIiwiaG91c2VUeXBlIjoiUkVOVCIsImlzUmVmcmVzaCI6MCwiZXhwIjoxNjE1Mjg5MzA5fQ.KsQt4B1qryAIt3aD7j5AKn-eaPVDUe8V2inBcGgihYs";
@interface BaseRequest()



@end

@implementation BaseRequest

- (instancetype)initWithHandler:(RequestCompletionHandler)succHandler
{
    if (self = [self init])
    {
        self.succHandler = succHandler;
    }
    return self;
}

- (AFHTTPSessionManager *)sessionManager
{
    if(!_sessionManager)
    {
        _sessionManager = [AFHTTPSessionManager manager];
        if(self.isRequestParametersMethodJson)
        {
            
        }
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = 30;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    }
    return _sessionManager;
}

- (instancetype)initWithHandler:(RequestCompletionHandler)succHandler failHandler:(RequestCompletionHandler)fail
{
    if (self = [self initWithHandler:succHandler]) {
        self.failHandler = fail;
    }
    return self;
}

- (NSString *)uri
{
    return @"";
}

- (NSString *)requestMethod
{
    return @"POST";
}


- (BaseResponse *)response
{
    if (!_response)
    {
        _response = [[BaseResponse alloc] init];
    }
    return _response;
}

- (NSData *)toPostData
{
    NSMutableString *string = [[NSMutableString alloc] init];
    return [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
}


- (void)parseResponse:(NSObject *)respJsonObject
{
    if (respJsonObject && [respJsonObject isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"==========[%@]开始解析响应>>>>>>>>>", self);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 子线程解析数据
            if (self->_succHandler) {
                NSDictionary *respJsonDict = (NSDictionary *)respJsonObject;
                
                if([respJsonDict[@"data"] isKindOfClass:[NSDictionary class]]){
                    self.response.data = [[self responseDataClass] mj_objectWithKeyValues:respJsonDict[@"data"]];
                } else  if([respJsonDict[@"data"] isKindOfClass:[NSArray class]]) {
//                    NSMutableArray *array = [NSMutableArray array];
//                    for (NSDictionary *dict in respJsonDict[@"data"]) {
//                        id object = [[self responseDataClass] mj_objectWithKeyValues:dict];
//                        if(object) {
//                            [array addObject:object];
//                        }
//                    }
//                    self.response.data = array;
                    self.response.data = [[self responseDataClass] mj_objectArrayWithKeyValuesArray:respJsonDict[@"data"]];
                } else if([respJsonDict[@"data"] isKindOfClass:[NSNull class]]) {
                    self.response.data = nil;
                } else {
                    self.response.data = respJsonDict[@"data"];
                }
            
                if(respJsonDict[@"code"] && ![respJsonDict[@"code"] isKindOfClass:[NSNull class]]) {
                    self.response.code = [respJsonDict[@"code"] integerValue];
                    
                }
                if(respJsonDict[@"message"] && ![respJsonDict[@"message"] isKindOfClass:[NSNull class]]) {
                    self.response.message = respJsonDict[@"message"];
                }
                
//                if(respJsonDict[@"status"] && ![respJsonDict[@"status"] isKindOfClass:[NSNull class]]) {
//                    self.response.status = respJsonDict[@"status"];
//                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self->_response.code == 200) {
                        if (self->_succHandler) {
                            self->_succHandler(self.response);
                        }
                    } else {
                        //需要登录
                        if(self.response.code == 401){
                            [LDRHUD showHUDWithMessage:self.response.message];
                            [[LDRRootConfig sharedRootConfig] toLogin];
                        }
                        if (self.response.code == 2) {
                            if ([self.uri isEqualToString:@"auth/token/v1/get"]) {
                                [LDRHUD showHUDWithMessage:self.response.message];
                                [[LDRRootConfig sharedRootConfig] toLogin];
                            } else {
                                LDRWeakify(self);
                                LDRRefreshTokenRequest *request = [LDRRefreshTokenRequest new];
                                [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
                                    LDRLoginSuccessModel *model = response.data;
                                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                                    [user setObject:model.accessToken forKey:LDRSessionId];
                                    [user setObject:model.accessTokenRefresh forKey:LDRRefresSessionId];
                                    [user synchronize];
                                    [weakSelf asyncRequestWithsuccessHandler:^(BaseResponse *response) {
                                        if (self->_succHandler) {
                                            self->_succHandler(response);
                                        }
                                    } failHandler:^(BaseResponse *response) {
                                        if (self->_failHandler) {
                                            self->_failHandler(response);
                                        }
                                    }];
                                } failHandler:^(BaseResponse *response) {
                                    
                                }];
                            }
                            return;
                        }
                        [LDRHUD showHUDWithMessage:self.response.message];
                        // 返回的数据有业务错误
                        if (self->_failHandler) {
                            self->_failHandler(self.response);
                        }
                    }
                    NSLog(@"==========解析响应完成>>>>>>>>>");
                });
            }
        });
    } else  {
        self.response.data = respJsonObject;
        NSLog(@"[%@]返回数据格式不对", [self class]);
        dispatch_async(dispatch_get_main_queue(), ^{
            // 说明返回内容有问题
            if (self->_succHandler) {
                self->_succHandler(self.response);
            }
        });
    }
}

- (Class)responseDataClass;
{
    return [JsonBaseObject class];
}





- (void)asyncRequestWithsuccessHandler:(RequestCompletionHandler)succHandler failHandler:(RequestCompletionHandler)fail
{
    self.succHandler = succHandler;
    self.failHandler = fail;

    NSString *url = [NSString stringWithFormat:@"%@/%@",ServerAddressWeb,[self uri]];
    NSMutableDictionary *paramters = [[self getJsonDictionary] mutableCopy];
    if ([[self uri] isEqualToString:@"lock/lockInfo/v1/add"]) {
        [paramters setObject:@"" forKey:@"id"];
        [paramters setObject:@"" forKey:@"iccid"];
    }
    NSString *sessionID = [[NSUserDefaults standardUserDefaults] objectForKey:LDRSessionId];
    [self.sessionManager.requestSerializer setValue:sessionID  forHTTPHeaderField:LDRSessionId];
    NSLog(@"paramters = %@   \n url = %@  requestMethod = %@ \n paramters = %@",self,url,[self requestMethod],paramters);
    NSLog(@"==========开始请求>>>>>>>>>");
    NSLog(@"HTTP Request Header  =   %@", self.sessionManager.requestSerializer.HTTPRequestHeaders);
    NSLog(@"HTTP Response acceptableContentTypes =   %@", self.sessionManager.responseSerializer.acceptableContentTypes);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
  
//    if(!self.hideLoadingView)
//    {
//        [[HUDHelper sharedInstance] loading];
//    }
    
    if([[self requestMethod] isEqualToString:RequestMethodGet])
    {
        [self.sessionManager GET:url parameters:paramters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self requestSuccess:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"网络错误++++++%@+++++",error);
             [self requestFaild:(NSHTTPURLResponse *)task.response error:error];
        }];
    }
    else if([[self requestMethod] isEqualToString:RequestMethodPut])
    {
        [self.sessionManager PUT:url parameters:paramters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self requestSuccess:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"网络错误++++++%@+++++",error);
            [self requestFaild:(NSHTTPURLResponse *)task.response error:error];
        }];
    }
    else if([[self requestMethod] isEqualToString:RequestMethodDelete])
    {
        [self.sessionManager DELETE:url parameters:paramters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self requestSuccess:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"网络错误++++++%@+++++",error);
             [self requestFaild:(NSHTTPURLResponse *)task.response error:error];
        }];
    }
    else
    {
        [self.sessionManager POST:url parameters:paramters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             [self requestSuccess:responseObject];
         }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"网络错误++++++%@+++++",error);
             [self requestFaild:(NSHTTPURLResponse *)task.response error:error];
         }];
    }
   
}

- (void)asyncRequestWithFormDatas:(NSArray<NSData *> *)formDatas formName:(NSString *)formName successHandler:(RequestCompletionHandler)succHandler failHandler:(RequestCompletionHandler)fail
{
    self.succHandler = succHandler;
    self.failHandler = fail;
    
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",ServerAddressWeb,[self uri]];
    NSMutableDictionary *paramters = [[self getJsonDictionary] mutableCopy];

    _sessionManager.requestSerializer.timeoutInterval = 6000;

    
    NSLog(@"paramters = %@   url = %@  requestMethod = %@",self,url,[self requestMethod]);
    
    NSLog(@"==========[%@]开始请求>>>>>>>>>", paramters);
    
    NSLog(@"HTTP Request Header  =   %@", self.sessionManager.requestSerializer.HTTPRequestHeaders);
    NSLog(@"HTTP Response acceptableContentTypes =   %@", self.sessionManager.responseSerializer.acceptableContentTypes);
    
    [self.sessionManager POST:url parameters:paramters headers:nil constructingBodyWithBlock:^(id< AFMultipartFormData >  _Nonnull formData) {
//        for (NSData *data in formDatas)
//        {
//            [formData appendPartWithFileData:data name:formName fileName:[NSString stringWithFormat:@"%@.jpg",@([FlyClientTools getNowTimeStamp])] mimeType:@"image/jpg"];
//        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"上传进度+++++++++++%@",@(uploadProgress.fractionCompleted));
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"上传成功+++++++++++");
         [self requestSuccess:responseObject];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"上传失败++++++%@+++++",error);
         [self requestFaild:(NSHTTPURLResponse *)task.response error:error];
     }];
}


- (void)asyncRequestWithVoiceData:(NSData *)data formName:(NSString *)formName successHandler:(RequestCompletionHandler)succHandler failHandler:(RequestCompletionHandler)fail
{
    self.succHandler = succHandler;
    self.failHandler = fail;
    
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",ServerAddressWeb,[self uri]];
    NSMutableDictionary *paramters = [[self getJsonDictionary] mutableCopy];
    _sessionManager.requestSerializer.timeoutInterval = 6000;

    
    NSLog(@"paramters = %@   url = %@  requestMethod = %@",self,url,[self requestMethod]);
    
    NSLog(@"==========[%@]开始请求>>>>>>>>>", paramters);
    
    NSLog(@"HTTP Request Header  =   %@", self.sessionManager.requestSerializer.HTTPRequestHeaders);
    NSLog(@"HTTP Response acceptableContentTypes =   %@", self.sessionManager.responseSerializer.acceptableContentTypes);
    
    [self.sessionManager POST:url parameters:paramters headers:nil constructingBodyWithBlock:^(id< AFMultipartFormData >  _Nonnull formData) {
//        [formData appendPartWithFileData:data name:formName fileName:[NSString stringWithFormat:@"%@.amr",@([FlyClientTools getNowTimeStamp])] mimeType:@"audio/AMR"];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"上传进度+++++++++++%@",@(uploadProgress.fractionCompleted));
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"上传成功+++++++++++");
         [self requestSuccess:responseObject];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"上传失败++++++%@+++++",error);
         [self requestFaild:(NSHTTPURLResponse *)task.response error:error];
     }];
}
#pragma mark -- 上传图片 --
- (void)uploadWitImagedData:(NSData *)imageData
                 uploadName:(NSString *)uploadName
                   progress:(void (^)(NSProgress *progress))progress
             successHandler:(RequestCompletionHandler)succHandler failHandler:(RequestCompletionHandler)fail
{
    self.succHandler = succHandler;
    self.failHandler = fail;
    
    NSMutableDictionary *paramters = [[self getJsonDictionary] mutableCopy];

    
    _sessionManager.requestSerializer.timeoutInterval = 6000;
    NSString *url = [NSString stringWithFormat:@"%@/%@",ServerAddressWeb,[self uri]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager POST:url parameters:paramters headers:nil constructingBodyWithBlock:^(id< AFMultipartFormData >  _Nonnull formData) {
//        [formData appendPartWithFileData:imageData name:uploadName fileName:[NSString stringWithFormat:@"%@.jpg",@([FlyClientTools getNowTimeStamp])] mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if(progress)
        {
            progress(uploadProgress);
        }
         NSLog(@"上传进度+++++++++++%@",@(uploadProgress.fractionCompleted));
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"上传成功+++++++++++");
         [self requestSuccess:responseObject];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"上传失败++++++%@+++++",error);
         [self requestFaild:(NSHTTPURLResponse *)task.response error:error];
     }];
}

- (void)requestSuccess:(id)responseObject
{
//    [[HUDHelper sharedInstance] stopLoading:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self parseResponse:responseObject];
    NSLog(@"%@'response = %@",[self class],responseObject);
}

- (void)requestFaild:(NSHTTPURLResponse *)responses error:(NSError *)error
{
//    [[HUDHelper sharedInstance] stopLoading:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSInteger state = responses.statusCode;
    NSString *msg = @"服务器错误";
    if(responses.statusCode == 500)//服务器内部错误
    {
        msg = @"服务器错误";
    }
    else if(responses.statusCode == 401)//授权失败 直接跳转登录界面
    {
        //跳转登录界面
//        [[HUDHelper sharedInstance] tipMessage:@"授权失败"];
        return;
    }
    else
    {
         if(error && error.code == NSURLErrorTimedOut)
         {
             state = -2;
             msg = @"网络连接超时";
         }
        else if (error && error.code == NSURLErrorNotConnectedToInternet)
        {
            state = -1;
            msg = @"网络连接失败";
        }
    }
    
    self.response.code = state;
    self.response.message = msg;

    if(self.failHandler)
    {
        self.failHandler(self.response);
    }
}


//+ (NSString *)getSignWithParamters:(NSDictionary *)paramters timeString:(NSString *)timeString{
//    NSString *sortString = [self stringWithDict:paramters];
//    NSString *secrectKey = [EJSUserTokenModel userTokenModel].secretKey;
//    return [[NSString stringWithFormat:@"%@%@%@",sortString,secrectKey,timeString] md5];
//}

+(NSString*)stringWithDict:(NSDictionary*)dict{
    NSArray*keys = [dict allKeys];
    NSArray*sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        return[obj1 compare:obj2 options:NSNumericSearch];//正序
    }];
    NSString*str =@"";
    for(NSString*categoryId in sortedArray) {
        id value = [dict objectForKey:categoryId];
        if(str.length > 0){
            str = [str stringByAppendingString:@"&"];
        }
        str = [str stringByAppendingFormat:@"%@=%@",categoryId,value];
    }
    return str;
}


//+ (NSString *)makeSignForVerifyCode:(NSString *)phone phoneType:(NSString *)phoneType
//{
//    NSData *stringData = [phone dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *encodedString = [GTMBase64 stringByEncodingData:stringData];
//
//    return [[NSString stringWithFormat:@"%@%@",[self hexStringFromString:encodedString],phoneType] md5];
//}

+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];   
    }   
    return hexStr;   
}

+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange,BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i =0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) &0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

+ (NSString *)hexStringWithData:(NSData *)data {
    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    if (!dataBuffer) {
        return [NSString string];
    }
    
    NSUInteger          dataLength  = [data length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i) {
        [hexString appendFormat:@"%02x", (unsigned char)dataBuffer[i]];
    }
    return [NSString stringWithString:hexString];
}


@end


@implementation BaseResponse

- (instancetype)init
{
    if (self = [super init])
    {
        // 默认成功
        _code = 0;
        _message = @"";
        _status = @"SUCCESSS";
    }
    return self;
}

- (BOOL)success
{
    if([_status isEqualToString:@"SUCCESSS"])
    {
        return YES;
    }
    return NO;
}

- (NSString *)msg
{
    return _message?_message:@"";
}

@end



