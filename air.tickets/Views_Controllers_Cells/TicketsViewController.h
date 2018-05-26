//
//  TicketsViewController.h
//  air.tickets
//
//  Created by macbookpro on 02.05.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "APIManager.h"
#import "Ticket.h"

@interface TicketsViewController: UITableViewController

-(instancetype)initWithTickets:(NSArray *)tickets;
-(instancetype)initFavouriteTicketsController;

@end
