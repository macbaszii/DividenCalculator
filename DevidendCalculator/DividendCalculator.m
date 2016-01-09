//
//  DividendCalculator.m
//  DevidendCalculator
//
//  Created by Kiattisak Anoochitarom on 1/2/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "DividendCalculator.h"
#import "Participant.h"

@interface DividendCalculator()

@end

@implementation DividendCalculator

+ (NSNumber *)calculateTotalFundForParticipants:(NSArray<Participant *> *)participants {
    double sum = 0;
    for (Participant *participant in participants) {
        sum += participant.fund;
    }
    
    return @(sum);
}

+ (RACSignal *)signalForCalculateDividendWithParticipants:(NSArray<Participant *> *)participants andCollectedInterest:(NSNumber *)interest {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       @strongify(self)
        double totalFund = [self calculateTotalFundForParticipants:participants].doubleValue;
        for (Participant *participant in participants) {
            double percentageOfParticipation = @(participant.fund * 100 / totalFund).doubleValue;
            double dividend = interest.doubleValue * percentageOfParticipation / 100;
            participant.dividend = dividend;
        }
        
        [subscriber sendNext:participants];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

@end
