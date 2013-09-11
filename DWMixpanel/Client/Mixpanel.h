//
//  Mixpanel.h
//  DWMixpanel
//
//  Created by Dominic Wroblewski on 11/09/2013.
//  Copyright (c) 2013 Dominic Wroblewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MixpanelDelegate.h"

@interface Mixpanel : NSObject {
    NSObject <MixpanelDelegate> *_delegate;
}

@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *apiSecret;

#pragma mark - Initialisations

+ (Mixpanel *)initFromDefaultsWithDelegate:(NSObject *)theDelegate;
- (Mixpanel *)initWithDelegate:(NSObject *)newDelegate;

#pragma mark - Setting authentication details

- (void)setApiKey:(NSString *)key andSecret:(NSString *)secret;

#pragma mark - API Calls

/* 
    METHOD: events
    URI: http://mixpanel.com/api/2.0/events/
    Parameters:
        'event'     NSArray
        'type'      NSString
        'unit'      NSString
        'interval'  NSInteger
        'format'    NSString
 */
- (void)events:(NSDictionary *)params;

/*
    METHOD: top
    URI: http://mixpanel.com/api/2.0/events/top/
    Parameters:
        'type'      NSString
        'limit'     NSInteger
 */
- (void)topEvents:(NSDictionary *)params;

@end
