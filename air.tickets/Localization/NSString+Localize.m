//
//  NSString+Localize.m
//  air.tickets
//
//  Created by macbookpro on 24.05.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Localize.h"

@implementation NSString (Localize)

-(NSString *)localize {
    return NSLocalizedString(self, "");
}

@end
