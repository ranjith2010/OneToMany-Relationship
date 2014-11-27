//
//  Contacts.h
//  OneToManyRelationship
//
//  Created by Ranjith on 27/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Address;

@interface Contacts : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * phone;
@property (nonatomic, retain) NSOrderedSet *addresses;
@end

@interface Contacts (CoreDataGeneratedAccessors)

- (void)insertObject:(Address *)value inAddressesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromAddressesAtIndex:(NSUInteger)idx;
- (void)insertAddresses:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeAddressesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInAddressesAtIndex:(NSUInteger)idx withObject:(Address *)value;
- (void)replaceAddressesAtIndexes:(NSIndexSet *)indexes withAddresses:(NSArray *)values;
- (void)addAddressesObject:(Address *)value;
- (void)removeAddressesObject:(Address *)value;
- (void)addAddresses:(NSOrderedSet *)values;
- (void)removeAddresses:(NSOrderedSet *)values;
@end
