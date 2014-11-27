//
//  Address.h
//  OneToManyRelationship
//
//  Created by Ranjith on 27/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contacts;

@interface Address : NSManagedObject

@property (nonatomic, retain) NSNumber * doorno;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) Contacts *contacts;

@end
