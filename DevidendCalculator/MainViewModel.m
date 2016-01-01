//
//  MainViewModel.m
//  DevidendCalculator
//
//  Created by Kiattisak Anoochitarom on 1/2/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

#import "MainViewModel.h"
#import "NSNumber+Helper.h"
#import "Participant.h"

@implementation MainViewModel

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    
    self.totalFund = 0;
    self.interest = 0;
    self.participants = [@[] mutableCopy];
    
    return self;
}

#pragma mark - Public Accessor

- (void)addParticipantWithFund:(double)fund {
    [self.participants addObject:[[Participant alloc] initWithFund:fund]];
    [self calculateTotalFund];
}

- (NSString *)totalFundText {
    return [@(self.totalFund) addThousandSeperator];
}

- (NSString *)interestText {
    return [@(self.interest) addThousandSeperator];
}

- (NSString *)addParticipantText {
    return [NSString stringWithFormat:@"เพิ่มผู้ร่วมทุนคนที่ %ld", self.participants.count];
}

#pragma mark - Internal Methods

- (void)calculateTotalFund {
    double sum = 0;
    for (Participant *participant in self.participants) {
        sum += participant.fund;
    }
    
    self.totalFund = sum;
}

@end
