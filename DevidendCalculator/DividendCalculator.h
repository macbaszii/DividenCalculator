//
//  DividendCalculator.h
//  DevidendCalculator
//
//  Created by Kiattisak Anoochitarom on 1/2/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Participant;
@class RACSignal;

@interface DividendCalculator : NSObject

+ (NSNumber *)calculateTotalFundForParticipants:(NSArray<Participant *> *)participants;
+ (RACSignal *)signalForCalculateDividendWithParticipants:(NSArray<Participant *> *)participants andCollectedInterest:(NSNumber *)interest;

@end
