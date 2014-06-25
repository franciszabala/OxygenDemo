//
//  ODReceiver.h
//  OxygenDemo
//
//  Created by Francis Zabala on 6/23/14.
//  Copyright (c) 2014 Francis Zabala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ODReceiverDelegate.h"

@protocol ODReceiverDelegate;

@interface ODReceiver : NSObject
@property (weak, nonatomic) id<ODReceiverDelegate> delegate;

- (void)getJSONwithUrl: (NSString*) urlAsString;

@end
