//
//  ODViewController.m
//  OxygenDemo
//
//  Created by Francis Zabala on 6/23/14.
//  Copyright (c) 2014 Francis Zabala. All rights reserved.
//

#import "ODViewController.h"
#import "ODFacadeDelegate.h"
#import "ODFacade.h"
#import "ODReceiver.h"
#import "ODContact.h"

@interface ODViewController () <ODFacadeDelegate> {
     ODFacade *_facade;
}

@end

@implementation ODViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
    _facade = [[ODFacade alloc] init];
    _facade.odReceiver = [[ODReceiver alloc] init]; //just in case you need to use a different implementation of ODReceiver
    _facade.odReceiver.delegate = _facade;
    _facade.delegate = self;
    
    [_facade getData];
    
}


- (void)didReceiveJSON:(NSData *)objectNotation {
    NSLog(@"data: %@", objectNotation);
    ODContact *contact = [[ODContact alloc]initWithNSData:objectNotation];
    
    NSLog(@"contact: %@", contact);
    //save
    [_facade saveContactToDb:contact];
    
    ODContact *contactFromDB = [[ODContact alloc]init];
    NSLog(@"contactFromDB: %@", contactFromDB);
    contactFromDB = [_facade getContactByCompanyName:@"Oxygen Ventures"];
    NSLog(@"contactFromDB filled up: %@", contactFromDB);
    
    //display
}

- (void)fetchingJSONFailedWithError:(NSError *)error {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
