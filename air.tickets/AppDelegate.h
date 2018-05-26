//
//  AppDelegate.h
//  air.tickets
//
//  Created by macbookpro on 25.04.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

