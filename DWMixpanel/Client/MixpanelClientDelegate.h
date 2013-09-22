//
//  MixpanelClientDelegate.h
//  DWMixpanel
//
//  Created by Dominic Wroblewski on 11/09/2013.
//  Copyright (c) 2013 Dominic Wroblewski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MixpanelClientDelegate <NSObject>

- (void)requestSucceededForMethod:(NSString *)method;
- (void)requestFailedWithError:(NSError *)error;

@optional

- (void)receivedData:(id)data;

@end
