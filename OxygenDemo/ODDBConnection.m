//
//  ODDBConnection.m
//  OxygenDemo
//
//  Created by Francis Zabala on 6/25/14.
//  Copyright (c) 2014 Francis Zabala. All rights reserved.
//

#import "ODDBConnection.h"

#define MAIN_DATABASE_NAME @"oxydemo.sqlite"
static sqlite3* theDatabase = nil;

@implementation ODDBConnection
+ (sqlite3*)openDatabase:(NSString*)dbFilename
{
    sqlite3* instance;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:dbFilename];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &instance) != SQLITE_OK) {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(instance);
        NSLog(@"Failed to open database. (%s)", sqlite3_errmsg(instance));
        return nil;
    }
    return instance;
}

+ (sqlite3*)getSharedDatabase
{
    if (theDatabase == nil) {
        theDatabase = [self openDatabase:MAIN_DATABASE_NAME];
        if (theDatabase == nil) {
            [ODDBConnection createEditableCopyOfDatabaseIfNeeded:true];
            //[[enjoyVIPAppDelegate getAppDelegate] alert:@"Local cache error"
              //                                  message:@"Local cache database has been corrupted. Re-created new database."];
        }
        
    }
    return theDatabase;
}

+ (ODStatement*)statementWithQuery:(const char *)sql
{
    ODStatement* stmt = [ODStatement statementWithDB:theDatabase query:sql];
    return stmt;
}

//
// cleanup and optimize
//

const char *optimize_sql = "VACUUM; ANALYZE";

+ (void)closeDatabase
{
    char *errmsg;
    if (theDatabase) {
      	int launchCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"launchCount"];
        NSLog(@"launchCount %d", launchCount);
        if (launchCount-- <= 0) {
            NSLog(@"Optimize database...");
            if (sqlite3_exec(theDatabase, optimize_sql, NULL, NULL, &errmsg) != SQLITE_OK) {
                NSLog(@"Error: failed to cleanup chache (%s)", errmsg);
            }
            launchCount = 50;
        }
        [[NSUserDefaults standardUserDefaults] setInteger:launchCount forKey:@"launchCount"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        sqlite3_close(theDatabase);
    }
}

// Creates a writable copy of the bundled default database in the application Documents directory.
+ (void)createEditableCopyOfDatabaseIfNeeded:(BOOL)force
{
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:MAIN_DATABASE_NAME];
    NSLog(@"%@", writableDBPath);
    if (force) {
        [fileManager removeItemAtPath:writableDBPath error:&error];
    }
    
    // No exists any database file. Create new one.
    //
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
	
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:MAIN_DATABASE_NAME];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
	NSLog(@"%@", defaultDBPath);
    
    
    
    
    
}

+ (void)beginTransaction
{
    char *errmsg;
    sqlite3_exec(theDatabase, "BEGIN", NULL, NULL, &errmsg);
}

+ (void)commitTransaction
{
    char *errmsg;
    sqlite3_exec(theDatabase, "COMMIT", NULL, NULL, &errmsg);
}

+ (void)alert
{
    NSString *sqlite3err = [NSString stringWithUTF8String:sqlite3_errmsg(theDatabase)];
    NSLog(@"error:%@", sqlite3err);
}

@end
