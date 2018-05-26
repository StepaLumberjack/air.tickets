//
//  Ticket.h
//  air.tickets
//
//  Created by macbookpro on 02.05.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//

@interface Ticket: NSObject

@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *airline;
@property (nonatomic, strong) NSDate *departure;
@property (nonatomic, strong) NSDate *expires;
@property (nonatomic, strong) NSNumber *flightNumber;
@property (nonatomic, strong) NSDate *returnDate;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *to;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
