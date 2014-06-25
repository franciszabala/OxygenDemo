//
//  ODDbUtil.m
//  OxygenDemo
//
//  Created by Francis Zabala on 6/25/14.
//  Copyright (c) 2014 Francis Zabala. All rights reserved.
//

#import "ODDbUtil.h"
#import "ODContact.h"
#import "ODStatement.h"
#import "ODDBConnection.h"

static ODDbUtil *sharedODDbUtil = nil;

@implementation ODDbUtil
+ (ODDbUtil *)sharedDBUtil {
    if (sharedODDbUtil == nil) {
        sharedODDbUtil = [[super allocWithZone:NULL] init];
    }
    
    return sharedODDbUtil;
}

+ (void) saveContactToDb: (ODContact*) odcontact {
	static ODStatement *stmt = nil;
	if (stmt == nil) {
        stmt = [ODDBConnection statementWithQuery:"INSERT OR REPLACE INTO contact (companyname,	website, contactno, address) VALUES (?, ?, ?, ?);"];
    }
	[stmt bindString:[odcontact companyName]		forIndex:1];
	[stmt bindString:[odcontact website]         forIndex:2];
	[stmt bindString:[odcontact contactno]		forIndex:3];
	[stmt bindString:[odcontact address]         forIndex:4];
    
    if ([stmt step] != SQLITE_DONE) {
        [ODDBConnection alert];
    }
    [stmt reset];
}

+ (ODContact *) getContactByCompanyName: (NSString *) companyName {
    
    NSString* sql = @"SELECT * FROM contact WHERE companyname=?";
    
    static ODStatement *stmt = nil;
    if (stmt == nil) {
        stmt = [ODDBConnection statementWithQuery:[sql UTF8String]];
    }
    [stmt bindString:companyName forIndex:1];
    ODContact *contact;
    if ([stmt step] == SQLITE_ROW) {
        contact = [[ODContact alloc] initWithStatement:stmt];
    }
    
    [stmt reset];
    NSLog(@"contact: %@", contact);
    return contact;
    
}

@end
