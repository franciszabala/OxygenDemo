//
//  ODContact.m
//  OxygenDemo
//
//  Created by Francis Zabala on 6/23/14.
//  Copyright (c) 2014 Francis Zabala. All rights reserved.
//

#import "ODContact.h"


@implementation ODContact

- (id)initWithNSData:(NSData *)objectNotation {
    self = [super init];
    if(self != nil) {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:objectNotation
                          
                          options:kNilOptions
                          error:&error];
        self = [self initWithNSDictionary:json];
        
    }
    return self;
}

- (id)initWithNSDictionary:(NSDictionary *)dic {
    self = [super init];
    if(self != nil) {
        [self setCompanyName:[dic objectForKey:@"companyname"]];
        [self setWebsite:[dic objectForKey:@"website"]];
        [self setContactno:[dic objectForKey:@"contactno"]];
        [self setAddress:[dic objectForKey:@"address"]];
    }
    return self;
}

- (id) initWithStatement:(ODStatement*) stmt{
	if (self = [super init]) {
        [self setCompanyName:[stmt getString:1]];
        [self setWebsite:[stmt getString:2]];
        [self setContactno:[stmt getString:3]];
        [self setAddress:[stmt getString:4]];
	}
	return self;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"\ncompanyname: %@\nwebsite = %@ \ncontactno: %@ \naddress: %@", self.companyName, self.website, self.contactno, self.address];
}





@end
