//
//  ODContact.h
//  OxygenDemo
//
//  Created by Francis Zabala on 6/23/14.
//  Copyright (c) 2014 Francis Zabala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ODDBConnection.h"
#import "ODStatement.h"

@interface ODContact : NSObject

@property (nonatomic, strong) NSString * companyName;
@property (nonatomic, strong) NSString * website;
@property (nonatomic, strong) NSString * contactno;
@property (nonatomic, strong) NSString * address;

- (id)initWithNSData:(NSData *)objectNotation;
- (id)initWithNSDictionary:(NSDictionary *)dic;
- (id)initWithStatement:(ODStatement*) stmt;


@end
