//
//  ODStatement.m
//  OxygenDemo
//
//  Created by Francis Zabala on 6/25/14.
//  Copyright (c) 2014 Francis Zabala. All rights reserved.
//

#import "ODStatement.h"
#import <sqlite3.h>

@implementation ODStatement

- (id)initWithDB:(sqlite3*)db query:(const char*)sql
{
    self = [super init];
    
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) != SQLITE_OK) {
        NSAssert2(0, @"Failed to prepare statement '%s' (%s)", sql, sqlite3_errmsg(db));
    }
    return self;
}

+ (id)statementWithDB:(sqlite3*)db query:(const char*)sql
{
    return [[ODStatement alloc] initWithDB:db query:sql];
}

- (int)step
{
    return sqlite3_step(stmt);
}

- (void)reset
{
    sqlite3_reset(stmt);
}

- (void)dealloc
{
    sqlite3_finalize(stmt);
}

//
//
//
- (NSString*)getString:(int)index
{
    return [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, index)];
}

- (int)getInt32:(int)index
{
    return (int)sqlite3_column_int(stmt, index);
}

- (long long)getInt64:(int)index
{
    return (long long)sqlite3_column_int(stmt, index);
}

- (double)getDouble:(int)index
{
    return (double)sqlite3_column_int(stmt, index);
}

- (NSData*)getData:(int)index
{
    int length = sqlite3_column_bytes(stmt, index);
    return [NSData dataWithBytes:sqlite3_column_blob(stmt, index) length:length];
}

- (void)bindString:(NSString*)value forIndex:(int)index
{
    sqlite3_bind_text(stmt, index, [value UTF8String], -1, SQLITE_TRANSIENT);
}

- (void)bindInt32:(int)value forIndex:(int)index
{
    sqlite3_bind_int(stmt, index, value);
	sqlite3_bind_double(stmt, index, value);
}

- (void)bindInt64:(long long)value forIndex:(int)index
{
    sqlite3_bind_int64(stmt, index, value);
}

- (void)bindDouble:(double)value forIndex:(int)index{
	sqlite3_bind_double(stmt, index, value);
}

- (void)bindData:(NSData*)value forIndex:(int)index
{
    sqlite3_bind_blob(stmt, index, value.bytes, value.length, SQLITE_TRANSIENT);
}
@end
