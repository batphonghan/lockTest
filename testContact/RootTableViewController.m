//
//  RootTableViewController.m
//  testContact
//
//  Created by East Agile on 9/27/18.
//  Copyright © 2018 IMac. All rights reserved.
//

#import "RootTableViewController.h"
#import <Contacts/Contacts.h>
#import "AppDelegate.h"
#import "TestRACViewController.h"

@interface RootTableViewController ()

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self deleteAllContacts];
            break;
        case 1:
            [self importContact];
            break;
            
        case 2:
            [self importContactPYK];
            break;
        case 3:
            [self testRetain];
            break;
        case 4:
            [self testCycle];
            break;
        default:
            break;
    }
}
- (void)testCycle {
    TestRACViewController *racVC = [TestRACViewController new];
    
    [self.navigationController pushViewController:racVC animated:YES];
}

- (void)testRetain {
    NSMutableArray *arr = ((AppDelegate *)[UIApplication sharedApplication].delegate).arr;
    for (int i = 0; i < 1000; i ++) {
        int k = arc4random_uniform(999);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        });
    }
}

- (void)importContactPYK {
    CNContactStore *contactStore = [CNContactStore new];
    
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted == YES) {
            CNSaveRequest *rq = [CNSaveRequest new];
           
            CNMutableContact *locPYk = [CNMutableContact new];
            CNPhoneNumber *phoneNumber = [[CNPhoneNumber alloc] initWithStringValue:@"0933687727"];
            CNLabeledValue<CNPhoneNumber *> *phone = [[CNLabeledValue alloc] initWithLabel:CNLabelHome value:phoneNumber];
            
            locPYk.givenName = @"LOC PYK";
            locPYk.phoneNumbers = @[phone];
            [rq addContact:locPYk toContainerWithIdentifier:nil];
            
            
            CNMutableContact *tanPYk = [CNMutableContact new];
            
            CNLabeledValue<NSString *> *email1 = [[CNLabeledValue alloc] initWithLabel:CNLabelHome value:@"sample@bbmtek.com"];
            CNLabeledValue<NSString *> *email2 = [[CNLabeledValue alloc] initWithLabel:CNLabelHome value:@"tvu-eastagile+1@bbmtek.com"];
            
            tanPYk.givenName = @"tvu PYK";
            tanPYk.emailAddresses = @[email1, email2];
            
            [rq addContact:tanPYk toContainerWithIdentifier:nil];
            
            
            CNMutableContact *nghiaPYk = [CNMutableContact new];
            
            CNLabeledValue<NSString *> *nemail0 = [[CNLabeledValue alloc] initWithLabel:CNLabelHome value:@"nghia.doan.sample+1@eastagile.com"];
            CNLabeledValue<NSString *> *nemail1 = [[CNLabeledValue alloc] initWithLabel:CNLabelHome value:@"nghia.doan+1@eastagile.com"];
            CNLabeledValue<NSString *> *nemail2 = [[CNLabeledValue alloc] initWithLabel:CNLabelHome value:@"nghia.doan+2@eastagile.com"];
            
            nghiaPYk.givenName = @"nghia PYK";
            nghiaPYk.emailAddresses = @[nemail1, nemail2, nemail0];
            
            [rq addContact:nghiaPYk toContainerWithIdentifier:nil];
            
            CNMutableContact *robeleePYK = [CNMutableContact new];
            CNLabeledValue<NSString *> *robeleeE0 = [[CNLabeledValue alloc] initWithLabel:CNLabelHome value:@"sample+1@robelee.com"];
            CNLabeledValue<NSString *> *robeleeE = [[CNLabeledValue alloc] initWithLabel:CNLabelHome value:@"robelee+88@bbmtek.com"];
            
            robeleePYK.givenName = @"robeleePYK ";
            robeleePYK.emailAddresses = @[robeleeE0, robeleeE];
            
            [rq addContact:robeleePYK toContainerWithIdentifier:nil];
            
            
            CNMutableContact *hPYk = [CNMutableContact new];
            CNPhoneNumber *hPhoneNumber = [[CNPhoneNumber alloc] initWithStringValue:@"841689908109"];
            CNLabeledValue<CNPhoneNumber *> *hPhone = [[CNLabeledValue alloc] initWithLabel:CNLabelHome value:hPhoneNumber];
            
            hPYk.givenName = @"H PYK";
            hPYk.phoneNumbers = @[hPhone];
            [rq addContact:hPYk toContainerWithIdentifier:nil];
            
            
            NSError *err;
            
            [contactStore executeSaveRequest:rq error:&err];
            
            if (!err) {
                NSLog(@"import done");
            }
        }
    }];
    
}

- (void)importContact {
    CNContactStore *contactStore = [CNContactStore new];
    
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted == YES) {
            CNSaveRequest *rq = [CNSaveRequest new];
            for (CNContact *contact in [self contacts]) {
                [rq addContact:contact.mutableCopy toContainerWithIdentifier:nil];
            }
            NSError *err;
            [contactStore executeSaveRequest:rq error:&err];
            
        }
    }];
    
}

- (NSArray<CNContact *> *)contacts {
    NSURL *vCardURL = [[NSBundle mainBundle] URLForResource:@"contacts" withExtension:@"vcf"];
    NSData *david1Data = [NSData dataWithContentsOfURL:vCardURL];
    NSError *error;
    NSArray *contacts = [CNContactVCardSerialization contactsWithData:david1Data error:&error];
    
    return contacts;
}


- (void) deleteAllContacts {
    CNContactStore *contactStore = [CNContactStore new];
    
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted == YES) {
            NSArray *keys = @[CNContactPhoneNumbersKey];
            NSString *containerId = contactStore.defaultContainerIdentifier;
            NSPredicate *predicate = [CNContact predicateForContactsInContainerWithIdentifier:containerId];
            NSError *error;
            NSArray *cnContacts = [contactStore unifiedContactsMatchingPredicate:predicate keysToFetch:keys error:&error];
            
            if (error) {
                NSLog(@"error fetching contacts %@", error);
            } else {
                CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
                
                for (CNContact *contact in cnContacts) {
                    [saveRequest deleteContact:[contact mutableCopy]];
                }
                
                [contactStore executeSaveRequest:saveRequest error:nil];
                NSLog(@"Deleted contacts %lu", cnContacts.count);
            }
        }
    }];
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
