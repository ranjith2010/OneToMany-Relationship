//
//  AddressDisplayTableViewController.m
//  OneToManyRelationship
//
//  Created by Ranjith on 27/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "AddressDisplayTableViewController.h"
#import "Address.h"

@interface AddressDisplayTableViewController (){
    AppDelegate *apdelegate;
}
@end

@implementation AddressDisplayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    apdelegate = [[UIApplication sharedApplication]delegate];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self pr_fetchAddress];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.fetchedResultsController.fetchedObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell" forIndexPath:indexPath];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddressCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    Address *address = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",address.doorno];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",address.street];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSError *error;
        NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
        if (record) {
            [apdelegate.managedObjectContext deleteObject:record];
            [apdelegate.managedObjectContext save:&error];
            [self pr_fetchAddress];
        }
    }}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    //Return NO if you do not want the specified item to be editable.
    return YES;
}

#pragma mark - Private methods

-(void)pr_fetchAddress{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Address"];
    NSString *cacheName = @"AddressCache";
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"doorno" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:apdelegate.managedObjectContext sectionNameKeyPath:nil cacheName:cacheName];
    NSError *error;
    if(![self.fetchedResultsController performFetch:&error]){
        NSLog(@"Fetch Failure: %@",error);
    }
    [self.tableView reloadData];
}

#pragma mark - Button Actions methods

- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
