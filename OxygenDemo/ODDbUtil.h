//
//  ODDbUtil.h
//  OxygenDemo
//
//  Created by Francis Zabala on 6/25/14.
//  Copyright (c) 2014 Francis Zabala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ODContact.h"

@interface ODDbUtil : NSObject {
    
}
+ (ODDbUtil *)sharedDBUtil;
+ (void) saveContactToDb: (ODContact*) odcontact;
+ (ODContact*) getContactByCompanyName: (NSString *) companyName;
@end
