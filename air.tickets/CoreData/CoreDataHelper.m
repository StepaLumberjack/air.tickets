//
//  CoreDataHelper.m
//  air.tickets
//
//  Created by macbookpro on 17.05.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//

#import "CoreDataHelper.h"
#import "Ticket.h"

@interface CoreDataHelper ()
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@end

@implementation CoreDataHelper

+ (instancetype)sharedInstance {
    static CoreDataHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataHelper alloc] init];
        [instance setup];
    });
    return instance;
}

- (void)setup {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"air_tickets" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [docsURL URLByAppendingPathComponent:@"base.sqlite"];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    
    NSPersistentStore* store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
    if (!store) {
        abort();
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
    //NSLog(@"path - %@", storeURL);
}

- (void)save {
    NSError *error;
    [_managedObjectContext save: &error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (FavouriteTicket *)favouriteFromTicket:(Ticket *)ticket {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavouriteTicket"];
    request.predicate = [NSPredicate predicateWithFormat:@"price == %ld AND airline == %@ AND from == %@ AND to == %@ AND departure == %@ AND expires == %@ AND flightNumber == %ld", (long)ticket.price.integerValue, ticket.airline, ticket.from, ticket.to, ticket.departure, ticket.expires, (long)ticket.flightNumber.integerValue];
    return [[_managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (BOOL)isFavourite:(Ticket *)ticket {
    return [self favouriteFromTicket:ticket] != nil;
}

- (void)addToFavourite:(Ticket *)ticket {
    FavouriteTicket *favourite = [NSEntityDescription insertNewObjectForEntityForName:@"FavouriteTicket" inManagedObjectContext:_managedObjectContext];
    favourite.price = ticket.price.intValue;
    favourite.airline = ticket.airline;
    favourite.departure = ticket.departure;
    favourite.expires = ticket.expires;
    favourite.flightNumber = ticket.flightNumber.intValue;
    favourite.returnDate = ticket.returnDate;
    favourite.from = ticket.from;
    favourite.to = ticket.to;
    favourite.created = [NSDate date];
    [self save];
}

- (void)removeFromFavourite:(Ticket *)ticket {
    FavouriteTicket *favourite = [self favouriteFromTicket:ticket];
    if (favourite) {
        [_managedObjectContext deleteObject:favourite];
        [self save];
    }
}

- (NSArray *)favourites {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavouriteTicket"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO]];
    return [_managedObjectContext executeFetchRequest:request error:nil];
}

@end
