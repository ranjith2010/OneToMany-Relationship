//
//  AddressDisplayTableViewController.h
//  OneToManyRelationship
//
//  Created by Ranjith on 27/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AddressDisplayTableViewController : UITableViewController
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end
