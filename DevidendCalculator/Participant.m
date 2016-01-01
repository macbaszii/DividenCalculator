//
//  Participant.m
//  DevidendCalculator
//
//  Created by Kiattisak Anoochitarom on 1/2/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

#import "Participant.h"

@implementation Participant

- (instancetype)initWithFund:(double)fund {
    if (!(self = [super init])) {
        return nil;
    }
    
    self.fund = fund;
    self.dividend = -1;
    
    return self;
}

@end
