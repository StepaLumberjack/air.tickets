//
//  ProgreaaView.h
//  air.tickets
//
//  Created by macbookpro on 19.05.2018.
//  Copyright © 2018 macbookpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView: UIView

+(instancetype)sharedInstance;

-(void)show:(void (^)(void))completion;
-(void)dismiss:(void (^)(void))completion;

@end
