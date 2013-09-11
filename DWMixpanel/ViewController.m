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
    
    [mixpanel events:@{@"event": @[@"Landed on Homepage"],
                       @"type": @"unique",
                       @"unit": @"day",
                       @"interval": [NSNumber numberWithInt:1]
                       }];
    
    [mixpanel topEvents:@{@"type": @"unique"}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)requestSucceeded
{
    NSLog(@"Request succeeded");
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
