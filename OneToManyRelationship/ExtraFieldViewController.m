//
//  ExtraFieldViewController.m
//  OneToManyRelationship
//
//  Created by Ranjith on 27/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "ExtraFieldViewController.h"
#import "AppDelegate.h"
#import "Address.h"

@interface ExtraFieldViewController (){
    AppDelegate *apDelegate;
}

@end

@implementation ExtraFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    apDelegate = [[UIApplication sharedApplication]delegate];
    [_streetTextField setHidden:YES];
    [_doornoTextField setHidden:YES];
    _nameTextField.text = _contactInfo.name;
    _phoneTextField.text = [NSString stringWithFormat:@"%@",_contactInfo.phone];
}


#pragma mark - Action methods

- (IBAction)dismissKeyboard:(id)sender {
}


- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addAddressBtn:(id)sender {
    [_streetTextField setHidden:NO];
    [_doornoTextField setHidden:NO];
}
- (IBAction)saveAction:(id)sender {
    if(([_nameTextField.text isEqualToString:_contactInfo.name])&&([_phoneTextField.text isEqual:_contactInfo.phone])){
        // we don't want to touch with Contacts table.
        // we use updated some values on Names & phone Fields, we have update into contacts table
    }
    if(_streetTextField.text&&_doornoTextField.text){
        // save into Address Table
        NSEntityDescription *employeeEntityDescription = [NSEntityDescription entityForName:@"Address" inManagedObjectContext:apDelegate.managedObjectContext];
                Address *address = (Address *)[[NSManagedObject alloc] initWithEntity:employeeEntityDescription insertIntoManagedObjectContext:apDelegate.managedObjectContext];
        address.street = _streetTextField.text;
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        address.doorno = [f numberFromString:_doornoTextField.text];
        address.contacts = _contactInfo;
        [apDelegate saveContext];
    }
}

@end
