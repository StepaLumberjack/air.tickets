//
//  APIManager.h
//  air.tickets
//
//  Created by macbookpro on 02.05.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//
# import "DataManager.h"

@interface APIManager: NSObject

+(instancetype)sharedInstance;
-(void)cityForCurrentIP:(void(^)(City *city))completion;
-(void)ticketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion;
-(void)mapPricesFor:(City *)origin withCompletion:(void (^)(NSArray *prices))completion;

@end
