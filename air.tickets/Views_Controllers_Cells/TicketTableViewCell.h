//
//  TicketTableViewCell.h
//  air.tickets
//
//  Created by macbookpro on 02.05.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "APIManager.h"
#import "Ticket.h"
#import "FavouriteTicket+CoreDataClass.h"

@interface TicketTableViewCell: UITableViewCell

@property (nonatomic, strong) UIImageView *airlineLogoView;
@property (nonatomic, strong) Ticket *ticket;
@property (nonatomic, strong) FavouriteTicket *favouriteTicket;

@end
