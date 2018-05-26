//
//  NotificationCenter.h
//  air.tickets
//
//  Created by macbookpro on 19.05.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>

typedef struct Notification {
    __unsafe_unretained NSString *_Nullable title;
    __unsafe_unretained NSString *_Nonnull body;
    __unsafe_unretained NSDate *_Nonnull date;
    __unsafe_unretained NSURL *_Nullable imageURL;
} Notification;

@interface NotificationCenter: NSObject

+(instancetype _Nonnull)sharedInstance;

-(void)registerService;
-(void)sendNotification:(Notification)notification;

Notification NotificationMake(NSString* _Nullable title, NSString* _Nonnull body, NSDate* _Nonnull date, NSURL *_Nullable imageURL);

@end
