//
//  NSString+Helper.m
//  DevidendCalculator
//
//  Created by Kiattisak Anoochitarom on 1/2/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

- (BOOL)isNumeric {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    return ([scanner scanDouble:NULL] || [scanner scanInteger:NULL]) && [scanner isAtEnd];
}

@end
