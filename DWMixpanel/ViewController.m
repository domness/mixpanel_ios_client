//
//  ViewController.m
//  DWMixpanel
//
//  Created by Dominic Wroblewski on 11/09/2013.
//  Copyright (c) 2013 Dominic Wroblewski. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#define API_KEY @""
#define API_SECRET @""

- (void)viewDidLoad
{
    [super viewDidLoad];
    Mixpanel *mixpanel = [[Mixpanel alloc] initWithDelegate:self];
    [mixpanel setApiKey:API_KEY andSecret:API_SECRET];
    [mixpanel setExpireInterval:(NSInteger *)300];
    
//    [mixpanel events:@{@"event": @[@"User created"],
//                       @"type": @"unique",
//                       @"unit": @"day",
//                       @"interval": [NSNumber numberWithInt:1]
//                       }];
    
//    [mixpanel eventsTop:@{@"type": @"unique"}];
    
//    [mixpanel eventsNames:@{@"type": @"unique"}];
    
//    [mixpanel eventsProperties:@{@"event": @"User created",
//                                 @"name": @"email",
//                                 @"type": @"unique",
//                                 @"interval": [NSNumber numberWithInt:1],
//                                 @"unit": @"day"
//                                 }];
    
//    [mixpanel eventsPropertiesTop:@{@"event": @"User created"}];
    
//    [mixpanel funnels:@{@"funnel_id": [NSNumber numberWithInt:424930]}];
    
//    [mixpanel funnelsList];
    
//    [mixpanel segmentation:@{@"event": @"Landed on Homepage",
//                             @"from_date": @"2013-07-22",
//                             @"to_date": @"2013-09-11"
//                             }];
    
//    [mixpanel segmentationNumeric:@{@"event": @"Landed on Homepage",
//                                    @"from_date": @"2013-07-22",
//                                    @"to_date": @"2013-09-11",
//                                    @"on": @"number(properties[\"time\"])",
//                                    @"buckets": [NSNumber numberWithInt:5]
//                                    }];
    
//    [mixpanel segmentationSum:@{@"event": @"Landed on Homepage",
//                                @"from_date": @"2013-07-22",
//                                @"to_date": @"2013-09-11",
//                                @"on": @"number(properties[\"time\"])"
//                                }];
    
//    [mixpanel segmentationAverage:@{@"event": @"Landed on Homepage",
//                                @"from_date": @"2013-07-22",
//                                @"to_date": @"2013-09-11",
//                                @"on": @"number(properties[\"time\"])"
//                                }];
    
//    [mixpanel retention:@{@"from_date": @"2013-07-22",
//                          @"to_date": @"2013-09-11",
//                          @"born_event": @"User created"}];
    
//    [mixpanel engage:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Mixpanel Delegate Methods

- (void)requestSucceededForMethod:(NSString *)method
{
    NSLog(@"Request succeeded for method: %@", method);
}

- (void)requestFailedWithError:(NSError *)error
{
    NSLog(@"Request failed with error: %@", [error debugDescription]);
}

- (void)receivedData:(NSDictionary *)dict
{
    NSLog(@"Received data from Mixpanel client: %@", dict);
}

@end
