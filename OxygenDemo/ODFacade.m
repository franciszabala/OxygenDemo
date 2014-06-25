//
//  ODFacade.m
//  OxygenDemo
//
//  Created by Francis Zabala on 6/25/14.
//  Copyright (c) 2014 Francis Zabala. All rights reserved.
//

#import "ODFacade.h"

@implementation ODFacade
@synthesize odReceiver;

- (void)getData
{ 
    [odReceiver getJSONwithUrl:@"http://jsonblob.com/api/jsonblob/538428bde4b0441b35d1328f"];
}

- (ODContact* )getContactByCompanyName: (NSString *) companyNameStr {
   ODContact* contact = [ODDbUtil getContactByCompanyName:companyNameStr];
   return contact;
}

- (void) saveContactToDb: (ODContact*) odcontact {
    [ODDbUtil saveContactToDb:odcontact];
}


#pragma mark - ODReceiverDelegate

- (void)receivedJSON:(NSData *)objectNotation {
    [self.delegate didReceiveJSON: objectNotation];
    
}

- (void)fetchingJSONFailedWithError:(NSError *)error {
    
}
@end
