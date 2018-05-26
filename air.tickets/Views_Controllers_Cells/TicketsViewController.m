//
//  TicketsViewController.m
//  air.tickets
//
//  Created by macbookpro on 02.05.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TicketsViewController.h"
#import "TicketTableViewCell.h"
#import "NotificationCenter.h"
#import "CoreDataHelper.h"
#import <UIKit/UIKit.h>
#import "NSString+Localize.h"

#define TicketCellReuseIdentifier @"TicketCellIdentifier"

@interface TicketsViewController()
@property (nonatomic, strong) NSArray *tickets;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UITextField *dateTextField;
@end

@implementation TicketsViewController {
    BOOL isFavourites;
    TicketTableViewCell *notificationCell;
}

-(instancetype)initFavouriteTicketsController {
    self = [super init];
    if (self) {
        isFavourites = YES;
        self.tickets = [NSArray new];
        self.title = [@"favourites_tab" localize];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
    }
    return self;
}

-(instancetype)initWithTickets:(NSArray *)tickets {
    self = [super init];
    if (self) {
        _tickets = tickets;
        self.title = [@"tickets_title" localize];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier: TicketCellReuseIdentifier];
        
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.minimumDate = [NSDate date];
        
        _dateTextField = [[UITextField alloc] initWithFrame:self.view.bounds];
        _dateTextField.hidden = YES;
        _dateTextField.inputView = _datePicker;
        
        UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
        [keyboardToolbar sizeToFit];
        UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidTap:)];
        keyboardToolbar.items = @[flexBarButton, doneBarButton];
        
        _dateTextField.inputAccessoryView = keyboardToolbar;
        [self.view addSubview:_dateTextField];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if(isFavourites) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        _tickets = [[CoreDataHelper sharedInstance] favourites];
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tickets.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketCellReuseIdentifier forIndexPath:indexPath];
    if (isFavourites) {
        cell.favouriteTicket = [_tickets objectAtIndex:indexPath.row];
    } else {
       cell.ticket = [_tickets objectAtIndex:indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 140.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isFavourites) return;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[@"actions_with_tickets" localize] message:[@"actions_with_tickets_describe" localize] preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *favouriteAction;
    if ([[CoreDataHelper sharedInstance] isFavourite:[_tickets objectAtIndex:indexPath.row]]) {
        favouriteAction = [UIAlertAction actionWithTitle:[@"remove_from_favourite" localize] style:UIAlertActionStyleDestructive handler:^(UIAlertAction *_Nonnull action) {
            [[CoreDataHelper sharedInstance] removeFromFavourite:[_tickets objectAtIndex:indexPath.row]];
        }];
    } else {
        favouriteAction = [UIAlertAction actionWithTitle:[@"add_to_favourite" localize] style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            [[CoreDataHelper sharedInstance] addToFavourite:[_tickets objectAtIndex:indexPath.row]];
        }];
    }
    
    UIAlertAction *notificationAction = [UIAlertAction actionWithTitle:[@"remind_me" localize] style:(UIAlertActionStyleDefault) handler: ^(UIAlertAction *_Nonnull action) {
        notificationCell = [tableView cellForRowAtIndexPath:indexPath];
        [_dateTextField becomeFirstResponder];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[@"close" localize] style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favouriteAction];
    [alertController addAction:notificationAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)doneButtonDidTap:(UIBarButtonItem *)sender {
    if (_datePicker && notificationCell) {
        NSString *message = [NSString stringWithFormat:@"%@ - %@ за %@ руб.", notificationCell.ticket.from, notificationCell.ticket.to, notificationCell.ticket.price];
        
        NSURL *imageURL;
        if (notificationCell.airlineLogoView.image) {
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/%@.png", notificationCell.ticket.airline]];
            if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
                UIImage *logo = notificationCell.airlineLogoView.image;
                NSData *pngData = UIImagePNGRepresentation(logo);
                [pngData writeToFile:path atomically:YES];
            }
            imageURL = [NSURL fileURLWithPath:path];
        }
        Notification notification = NotificationMake([@"ticket_reminder" localize], message, _datePicker.date, imageURL);
        [[NotificationCenter sharedInstance] sendNotification: notification];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[@"success" localize] message:[NSString stringWithFormat:@"%@ - %@", [@"notification_will_be_sent" localize], _datePicker.date] preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[@"close" localize] style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    _datePicker.date = [NSDate date];
    notificationCell = nil;
    [self.view endEditing:YES];
}

@end
