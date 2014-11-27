//
//  ExtraFieldViewController.h
//  OneToManyRelationship
//
//  Created by Ranjith on 27/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contacts.h"

@interface ExtraFieldViewController : UIViewController
@property (nonatomic,strong)Contacts *contactInfo;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *doornoTextField;
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
@end
