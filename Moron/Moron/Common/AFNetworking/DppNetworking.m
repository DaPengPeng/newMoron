//
//  DppNetworking.m
//  DppWB
//
//  Created by bever on 16/4/9.
//  Copyright © 2016年 贝沃. All rights reserved.
//

#import "DppNetworking.h"
#import "AFNetworking.h"

@implementation DppNetworking

+ (void)GET:(NSString *)url parmeters:(NSDictionary *)parmeters resulteBlock:(resulteBlock)block withFilePath:(NSString *)path {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:parmeters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:responseObject];
        [archiver finishEncoding];
        
        BOOL isSuccess = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
        if (isSuccess) {
            NSLog(@"保存成功");
        }else {
        
            NSLog(@"保存失败");
        }
        
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error is:%@",error);
    }];
}

+ (void)POST:(NSString *)url parmeters:(NSDictionary *)parmeters withBlcok:(resulteBlock)blocck{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:parmeters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        blocck(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

+ (void)POST:(NSString *)url parmeters:(NSDictionary *)parmeters imageName:(NSString *)imageName imageType:(NSString *)imageType withBlcok:(resulteBlock)blocck{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parmeters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:imageType];
        NSData *imageData = [NSData dataWithContentsOfFile:path];
        [formData appendPartWithFileData:imageData name:imageName fileName:[imageName stringByAppendingString:@".png"] mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        blocck(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
}

@end
