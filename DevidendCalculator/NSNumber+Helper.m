//
//  NSNumber+Helper.m
//  DevidendCalculator
//
//  Created by Kiattisak Anoochitarom on 1/2/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

#import "NSNumber+Helper.h"

@implementation NSNumber (Helper)

- (NSString *)addThousandSeperator {
    return [self descriptionWithLocale:[NSLocale currentLocale]];
}

@end
