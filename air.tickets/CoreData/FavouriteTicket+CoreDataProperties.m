//
//  FavouriteTicket+CoreDataProperties.m
//  air.tickets
//
//  Created by macbookpro on 17.05.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//
//

#import "FavouriteTicket+CoreDataProperties.h"

@implementation FavouriteTicket (CoreDataProperties)

+ (NSFetchRequest<FavouriteTicket *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FavouriteTicket"];
}

@dynamic airline;
@dynamic created;
@dynamic departure;
@dynamic expires;
@dynamic flightNumber;
@dynamic from;
@dynamic price;
@dynamic returnDate;
@dynamic to;

@end
