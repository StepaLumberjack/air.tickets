//
//  CoreDataHelper.h
//  air.tickets
//
//  Created by macbookpro on 17.05.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DataManager.h"
#import "Ticket.h"
#import "FavouriteTicket+CoreDataClass.h"

@interface CoreDataHelper : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isFavourite:(Ticket *)ticket;
- (NSArray *)favourites;
- (void)addToFavourite:(Ticket *)ticket;
- (void)removeFromFavourite:(Ticket *)ticket;

@end

