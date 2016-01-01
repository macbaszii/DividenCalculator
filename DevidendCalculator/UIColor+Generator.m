//
//  UIColor+Generator.m
//  DevidendCalculator
//
//  Created by Kiattisak Anoochitarom on 1/2/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

#import "UIColor+Generator.h"

@implementation UIColor (Generator)

+ (UIColor *)calculateButtonColor {
    return [self colorWithDecimalRed:63
                               green:195
                             andBlue:128];
}

+ (UIColor *)addParticipantButtonColor {
    return [self colorWithDecimalRed:34
                               green:167
                             andBlue:240];
}

+ (UIColor *)editInterestButtonColor {
    return [self colorWithDecimalRed:233
                               green:212
                             andBlue:96];
}

#pragma mark - Internal Methods

+ (UIColor *)colorWithDecimalRed:(CGFloat)red
                           green:(CGFloat)green
                         andBlue:(CGFloat)blue {
    
    return [UIColor colorWithRed:red / 255.0
                           green:green / 255.0
                            blue:blue / 255.0
                           alpha:1.0];
}

@end
