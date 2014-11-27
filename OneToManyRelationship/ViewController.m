//
//  ViewController.m
//  OneToManyRelationship
//
//  Created by Ranjith on 27/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "ViewController.h"
#import "Contacts.h"
#import "ExtraFieldViewController.h"
#import "Address.h"
#import "AddressDisplayTableViewController.h"

@interface ViewController (){
    AppDelegate *apdelegate;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"app dir: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    apdelegate = [[UIApplication sharedApplication]delegate];
    [self pr_fetchContacts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

- (IBAction)dismissKeyboard:(id)sender {
}

- (IBAction)saveAction:(id)sender {
    if(_nameTextField.text){
    NSEntityDescription *employeeEntityDescription = [NSEntityDescription entityForName:@"Contacts" inManagedObjectContext:apdelegate.managedObjectContext];
    Contacts *newEmployee = (Contacts *)[[NSManagedObject alloc] initWithEntity:employeeEntityDescription insertIntoManagedObjectContext:apdelegate.managedObjectContext];
    newEmployee.name = _nameTextField.text;
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    newEmployee.phone = [f numberFromString:_phoneTextField.text];
    [apdelegate saveContext];
    }
    // The employee basic details hopefully stored into Coredata
    // easily we can fetch using NSFetchResultsController
    
    [self pr_fetchContacts];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ContactsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    Contacts *contactInfo = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = contactInfo.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",contactInfo.phone];
      return cell;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSError *error;
        NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
        if (record) {
            [apdelegate.managedObjectContext deleteObject:record];
            [apdelegate.managedObjectContext save:&error];
            [self pr_fetchContacts];
        }
    }}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    //Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ExtraFieldViewController *extraFieldVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ExtraFieldVC"];
    [extraFieldVC setContactInfo:[self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row]];
    [self presentViewController:extraFieldVC animated:YES completion:nil];
}


#pragma mark - PrivateMethods
-(void)pr_fetchContacts{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Contacts"];
    NSString *cacheName = @"ContactsCache";
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:apdelegate.managedObjectContext sectionNameKeyPath:nil cacheName:cacheName];
    NSError *error;
    if(![self.fetchedResultsController performFetch:&error]){
        NSLog(@"Fetch Failure: %@",error);
    }
    [self.tableView reloadData];
}
- (IBAction)addressTableAction:(id)sender {
    AddressDisplayTableViewController *addressDisplayTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressDisplayTVC"];
    [self presentViewController:addressDisplayTVC animated:YES completion:nil];
}


@end
