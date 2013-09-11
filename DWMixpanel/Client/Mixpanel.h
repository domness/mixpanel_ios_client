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
@property (nonatomic) NSInteger *expireInterval;

#pragma mark -
#pragma mark Initialisations

+ (Mixpanel *)initFromDefaultsWithDelegate:(NSObject *)theDelegate;
- (Mixpanel *)initWithDelegate:(NSObject *)newDelegate;

#pragma mark -
#pragma mark Setting authentication details

- (void)setApiKey:(NSString *)key andSecret:(NSString *)secret;

#pragma mark -
#pragma mark Events

/*
 METHOD: events
 URI: http://mixpanel.com/api/2.0/events/
 Parameters:
 'event'        NSArray
 'type'         NSString
 'unit'         NSString
 'interval'     NSInteger
 'format'       NSString
 */
- (void)events:(NSDictionary *)params;

/*
 METHOD: top
 URI: http://mixpanel.com/api/2.0/events/top/
 Parameters:
 'type'         NSString
 'limit'        NSInteger
 */
- (void)eventsTop:(NSDictionary *)params;

/*
 METHOD: names
 URI: http://mixpanel.com/api/2.0/events/names/
 Parameters:
 'type'         NSString
 'limit'        NSInteger
 */
- (void)eventsNames:(NSDictionary *)params;

/*
 METHOD: properties
 URI: http://mixpanel.com/api/2.0/events/properties/
 Parameters:
 'event'        NSString
 'name'         NSString
 'values'       NSArray
 'type'         NSString
 'unit'         NSString
 'interval'     NSInteger
 'format'       NSString
 'limit'        NSInteger
 */
- (void)eventsProperties:(NSDictionary *)params;

/*
 METHOD: properties/top
 URI: http://mixpanel.com/api/2.0/events/properties/top/
 Parameters:
 'event'        NSString
 'limit'        NSInteger
 */
- (void)eventsPropertiesTop:(NSDictionary *)params;

/*
 METHOD: properties/top
 URI: http://mixpanel.com/api/2.0/events/properties/values/
 Parameters:
 'event'        NSString
 'name'         NSString
 'limit'        NSInteger
 'bucket'       NSString
 */
- (void)eventsPropertiesValues:(NSDictionary *)params;

#pragma mark -
#pragma mark Funnels

/*
 METHOD: funnels
 URI: http://mixpanel.com/api/2.0/funnels/
 Parameters:
 'funnel_id'    NSInteger
 'from_date'    NSString
 'to_date'      NSString
 'length'       NSInteger
 'interval'     NSInteger
 'unit'         NSString
 'on'           NSString
 'where'        NSString
 'limit         NSInteger
 */
- (void)funnels:(NSDictionary *)params;

@end
