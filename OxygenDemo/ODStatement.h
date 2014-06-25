//
//  ODStatement.h
//  OxygenDemo
//
//  Created by Francis Zabala on 6/25/14.
//  Copyright (c) 2014 Francis Zabala. All rights reserved.
//

#import <sqlite3.h>

@interface ODStatement : NSObject
{
    sqlite3_stmt*   stmt;
}

+ (id)statementWithDB:(sqlite3*)db query:(const char*)sql;
- (id)initWithDB:(sqlite3*)db query:(const char*)sql;

// method
- (int)step;
- (void)reset;

// Getter
- (NSString*)getString:(int)index;
- (int)getInt32:(int)index;
- (long long)getInt64:(int)index;
- (NSData*)getData:(int)index;
- (double)getDouble:(int)index;

// Binder
- (void)bindString:(NSString*)value forIndex:(int)index;
- (void)bindInt32:(int)value forIndex:(int)index;
- (void)bindInt64:(long long)value forIndex:(int)index;
- (void)bindDouble:(double)value forIndex:(int)index;
- (void)bindData:(NSData*)data forIndex:(int)index;

@end




