//
//  Mixpanel.m
//  DWMixpanel
//
//  Created by Dominic Wroblewski on 11/09/2013.
//  Copyright (c) 2013 Dominic Wroblewski. All rights reserved.
//

#import "Mixpanel.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "SBJson.h"

@interface Mixpanel (PrivateMethods)

- (BOOL)_isValidDelegateForSelector:(SEL)selector;

@end

@implementation Mixpanel

#define BASE_URL @"http://mixpanel.com/api/2.0/"

#pragma mark -
#pragma mark Initialisations

+ (Mixpanel *)initFromDefaultsWithDelegate:(NSObject *)theDelegate
{
    return [[self alloc] initWithDelegate:theDelegate];
}

- (Mixpanel *)initWithDelegate:(NSObject <MixpanelDelegate> *)newDelegate
{
    if ((self = [super init])) {
        _delegate =  newDelegate;
        _expireInterval = (NSInteger *)60;
    }
    return self;
}

#pragma mark -
#pragma mark Setting authentication details

- (void)setApiKey:(NSString *)key andSecret:(NSString *)secret
{
    _apiKey = key;
    _apiSecret = secret;
}

#pragma mark -
#pragma mark Events

- (void)events:(NSDictionary *)params
{
    [self makeRequestWithParams:params forPath:@"events/"];
}

- (void)eventsTop:(NSDictionary *)params
{
    [self makeRequestWithParams:params forPath:@"events/top/"];
}

- (void)eventsNames:(NSDictionary *)params
{
    [self makeRequestWithParams:params forPath:@"events/names/"];
}

- (void)eventsProperties:(NSDictionary *)params
{
    [self makeRequestWithParams:params forPath:@"events/properties/"];
}

- (void)eventsPropertiesTop:(NSDictionary *)params
{
    [self makeRequestWithParams:params forPath:@"events/properties/top/"];
}

- (void)eventsPropertiesValues:(NSDictionary *)params
{
    [self makeRequestWithParams:params forPath:@"events/properties/values/"];
}

#pragma mark -
#pragma mark - Funnels

- (void)funnels:(NSDictionary *)params
{
    [self makeRequestWithParams:params forPath:@"funnels/"];
}

#pragma mark -
#pragma mark - Private methods

- (void)makeRequestWithParams:(NSDictionary *)params forPath:(NSString *)path
{
    NSMutableDictionary *mutParams = [self getMutableParams:params];
    [mutParams setObject:[self getSigFromParams:mutParams] forKey:@"sig"];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                            path:path
                                                      parameters:mutParams];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([self _isValidDelegateForSelector:@selector(requestSucceededForMethod:)]) {
            [_delegate requestSucceededForMethod:path];
        }
        if ([self _isValidDelegateForSelector:@selector(receivedData:)]) {
            [_delegate receivedData:[self dictionaryFromJson:response]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([self _isValidDelegateForSelector:@selector(requestFailedWithError:)]) {
            [_delegate requestFailedWithError:error];
        }
    }];
    
    [operation start];
}

- (BOOL)_isValidDelegateForSelector:(SEL)selector
{
	return ((_delegate != nil) && [_delegate respondsToSelector:selector]);
}

- (NSArray *)sortedKeysFromParams:(NSDictionary *)params
{
    return [[params allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

- (NSInteger)expire
{
    NSDate *date = [[NSDate date] dateByAddingTimeInterval:(int)_expireInterval];
    return (NSInteger)[date timeIntervalSince1970];
}

- (NSString *)getSigFromParams:(NSDictionary *)params
{
    NSMutableString *urlString = [[NSMutableString alloc] init];
    for (NSString *key in [self sortedKeysFromParams:params]) {
        [urlString appendString:[NSString stringWithFormat:@"%@=%@", key, [params objectForKey:key]]];
    }
    [urlString appendString:_apiSecret];
    NSString *sig = [self md5HexDigest:urlString];
    return sig;
}

- (NSString *)md5HexDigest:(NSString *)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (NSMutableDictionary *)getMutableParams:(NSDictionary *)params
{
    NSMutableDictionary *copyParams = [[NSMutableDictionary alloc] initWithDictionary:params];
    [copyParams setObject:_apiKey forKey:@"api_key"];
    [copyParams setObject:[NSNumber numberWithInteger:[self expire]] forKey:@"expire"];
    return [self convertParamsToJson:copyParams];
}

- (NSMutableDictionary *)convertParamsToJson:(NSMutableDictionary *)copyParams
{
    NSMutableDictionary *mutParams = [[NSMutableDictionary alloc] initWithDictionary:copyParams];
    for (NSString *key in mutParams) {
        if ([[mutParams objectForKey:key] isKindOfClass:[NSArray class]]) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[mutParams objectForKey:key] options:0 error:&error];
            [copyParams setObject:[[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding] forKey:key];
        }
    }
    return copyParams;
}

- (NSDictionary *)dictionaryFromJson:(NSString *)jsonString
{
    NSError *error;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
}

@end
