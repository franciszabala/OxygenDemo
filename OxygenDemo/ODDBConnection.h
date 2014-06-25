//
//  ODDBConnection.h
//  OxygenDemo
//
//  Created by Francis Zabala on 6/25/14.
//  Copyright (c) 2014 Francis Zabala. All rights reserved.
//

#import <sqlite3.h>
#import "ODStatement.h"

@interface ODDBConnection : NSObject

+ (void)createEditableCopyOfDatabaseIfNeeded:(BOOL)force;
+ (sqlite3*)getSharedDatabase;
+ (void)closeDatabase;
+ (ODStatement*)statementWithQuery:(const char *)sql;
+ (void)beginTransaction;
+ (void)commitTransaction;
+ (void)alert;

@end
