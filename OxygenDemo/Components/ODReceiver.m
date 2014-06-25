//
//  ODReceiver.m
//  OxygenDemo
//
//  Created by Francis Zabala on 6/23/14.
//  Copyright (c) 2014 Francis Zabala. All rights reserved.
//

#import "ODReceiver.h"

@implementation ODReceiver

- (void)getJSONwithUrl: (NSString*) urlAsString {
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingJSONFailedWithError:error];
        } else {
            [self.delegate receivedJSON:data];
        }
    }];

}

@end
