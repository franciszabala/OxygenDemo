//
//  ODFacade.h
//  OxygenDemo
//
//  Created by Francis Zabala on 6/25/14.
//  Copyright (c) 2014 Francis Zabala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ODReceiverDelegate.h"
#import "ODReceiver.h"
#import "ODFacadeDelegate.h"
#import "ODDbUtil.h"

@interface ODFacade : NSObject<ODReceiverDelegate>
@property (strong, nonatomic) ODReceiver *odReceiver;  //this can be refactored
@property (weak, nonatomic) id<ODFacadeDelegate> delegate;
- (void)getData;
- (ODContact* )getContactByCompanyName: (NSString *) companyNameStr;
- (void) saveContactToDb: (ODContact*) odcontact;
@end
