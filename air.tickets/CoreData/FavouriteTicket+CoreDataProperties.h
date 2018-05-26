//
//  FavouriteTicket+CoreDataProperties.h
//  air.tickets
//
//  Created by macbookpro on 17.05.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//
//

#import "FavouriteTicket+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavouriteTicket (CoreDataProperties)

+ (NSFetchRequest<FavouriteTicket *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *airline;
@property (nullable, nonatomic, copy) NSDate *created;
@property (nullable, nonatomic, copy) NSDate *departure;
@property (nullable, nonatomic, copy) NSDate *expires;
@property (nonatomic) int16_t flightNumber;
@property (nullable, nonatomic, copy) NSString *from;
@property (nonatomic) int64_t price;
@property (nullable, nonatomic, copy) NSDate *returnDate;
@property (nullable, nonatomic, copy) NSString *to;

@end

NS_ASSUME_NONNULL_END
