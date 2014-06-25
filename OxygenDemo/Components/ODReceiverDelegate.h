//
//  ODReceiverDelegate.h
//  OxygenDemo
//
//  Created by Francis Zabala on 6/25/14.
//  Copyright (c) 2014 Francis Zabala. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ODReceiverDelegate
- (void)receivedJSON:(NSData *)objectNotation;
- (void)fetchingJSONFailedWithError:(NSError *)error;
@end

