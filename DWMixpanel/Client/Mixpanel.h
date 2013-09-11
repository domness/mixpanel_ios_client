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

/*
 All details on the API methods below can be found from the Mixpanel API documentation here:
 https://mixpanel.com/docs/api-documentation/data-export-api
 */

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

/*
 METHOD: funnels/list
 URI: http://mixpanel.com/api/2.0/funnels/list/
 */
- (void)funnelsList;

#pragma mark -
#pragma mark Segmentation

/*
 METHOD: segmentation
 URI: http://mixpanel.com/api/2.0/segmentation/
 Parameters:
 'event'        NSString
 'from_date'    NSString
 'to_date'      NSString
 'on'           NSString
 'unit'         NSString
 'where'        NSString
 'limit'        NSInteger
 'type'         NSString
 */
- (void)segmentation:(NSDictionary *)params;

/*
 METHOD: segmentation/numeric
 URI: http://mixpanel.com/api/2.0/segmentation/numeric/
 Parameters:
 'event'        NSString
 'from_date'    NSString
 'to_date'      NSString
 'on'           NSString
 'buckets'      NSInteger
 'unit'         NSString
 'where'        NSString
 'type'         NSString
 */
- (void)segmentationNumeric:(NSDictionary *)params;

/*
 METHOD: segmentation/sum
 URI: http://mixpanel.com/api/2.0/segmentation/sum/
 Parameters:
 'event'        NSString
 'from_date'    NSString
 'to_date'      NSString
 'on'           NSString
 'unit'         NSString
 'where'        NSString
 */
- (void)segmentationSum:(NSDictionary *)params;

/*
 METHOD: segmentation/average
 URI: http://mixpanel.com/api/2.0/segmentation/average/
 Parameters:
 'event'        NSString
 'from_date'    NSString
 'to_date'      NSString
 'on'           NSString
 'unit'         NSString
 'where'        NSString
 */
- (void)segmentationAverage:(NSDictionary *)params;

#pragma mark -
#pragma mark Retention

/*
 METHOD: retention
 URI: http://mixpanel.com/api/2.0/retention/
 Parameters:
 'from_date'        NSString
 'to_date'          NSString
 'retention_type'   NSString
 'born_event'       NSString
 'event'            NSString
 'born_where'       NSString
 'where'            NSString
 'interval'         NSInteger
 'interval_count'   NSInteger
 'unit'             NSString
 'on'               NSString
 'limit'            NSInteger
 */
- (void)retention:(NSDictionary *)params;


@end
