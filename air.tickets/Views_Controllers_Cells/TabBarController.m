//
//  TabBarController.m
//  air.tickets
//
//  Created by macbookpro on 02.05.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//

#import "TabBarController.h"
#import "MainViewController.h"
#import "MapViewController.h"
#import "TicketsViewController.h"
#import "NSString+Localize.h"


@implementation TabBarController

- (instancetype)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.viewControllers = [self createViewControllers];
        self.tabBar.tintColor = [UIColor blackColor];
        self.selectedIndex = 0;
    }
    return self;
}

- (NSArray<UIViewController*> *)createViewControllers {
    NSMutableArray<UIViewController*> *controllers = [NSMutableArray new];
    
    MainViewController *mainViewController = [[MainViewController alloc] init];
    mainViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:[@"search_tab" localize] image:[UIImage imageNamed:@"search"] selectedImage:[UIImage imageNamed:@"search_selected"]];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    [controllers addObject:mainNavigationController];
    
    MapViewController *mapViewController = [[MapViewController alloc] init];
    mapViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:[@"map_tab" localize] image:[UIImage imageNamed:@"map"] selectedImage:[UIImage imageNamed:@"map_selected"]];
    UINavigationController *mapNavigationController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    [controllers addObject:mapNavigationController];
    
    TicketsViewController *favouriteViewController = [[TicketsViewController alloc] initFavouriteTicketsController];
    favouriteViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:[@"favourites_tab" localize] image:[UIImage imageNamed:@"favorite"] selectedImage:[UIImage imageNamed:@"favorite_selected"]];
    UINavigationController *favouriteNavigationController = [[UINavigationController alloc] initWithRootViewController:favouriteViewController];
    [controllers addObject:favouriteNavigationController];
    
    return controllers;
}

@end
