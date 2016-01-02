//
//  MainViewModel.m
//  DevidendCalculator
//
//  Created by Kiattisak Anoochitarom on 1/2/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "MainViewModel.h"
#import "NSNumber+Helper.h"
#import "Participant.h"
#import "DividendCalculator.h"

@interface MainViewModel()

@property (strong, nonatomic) RACSignal *dataValidationSignal;

@end

@implementation MainViewModel

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    
    [self initializeData];
    [self setupBindings];
    
    return self;
}

#pragma mark - Public Accessor

- (void)addParticipantWithFund:(double)fund {
    NSMutableArray *participants = [self mutableArrayValueForKeyPath:@keypath(self, participants)];
    [participants addObject:[[Participant alloc] initWithFund:fund]];
    [self resetParticipantsDividend];
    self.totalFund = [DividendCalculator calculateTotalFundForParticipants:self.participants].doubleValue;
}

- (void)deleteLatestPaticipant {
    NSMutableArray *participants = [self mutableArrayValueForKeyPath:@keypath(self, participants)];
    [participants removeLastObject];
    [self resetParticipantsDividend];
    self.totalFund = [DividendCalculator calculateTotalFundForParticipants:self.participants].doubleValue;
}

- (NSString *)totalFundText {
    return [@(self.totalFund) addThousandSeperator];
}

- (NSString *)interestText {
    return [@(self.interest) addThousandSeperator];
}

- (NSString *)addParticipantText {
    return [NSString stringWithFormat:@"เพิ่มผู้ร่วมทุนคนที่ %ld", self.participants.count + 1];
}

- (void)clearAllData {
    [self initializeData];
}

#pragma mark - Internal Methods

- (void)resetParticipantsDividend {
    for (Participant *participant in self.participants) {
        participant.dividend = -1;
    }
}

- (void)initializeData {
    self.totalFund = 0;
    self.interest = 0;
    self.participants = [@[] mutableCopy];
    self.tableViewNeedsReload = NO;
}

- (void)setupBindings {
    RACSignal *validParticipants = [RACObserve(self, participants) map:^id(NSArray<Participant *> *participants) {
        return @(participants.count > 1);
    }];
    
    RACSignal *validTotalFind = [RACObserve(self, totalFund) map:^id(NSNumber *value) {
        return @(value.doubleValue > 0);
    }];
    
    RACSignal *validInterest = [RACObserve(self, interest) map:^id(NSNumber *value) {
        return @(value.doubleValue > 0);
    }];
    
    RAC(self, canCalculateDividend) = [RACSignal combineLatest:@[validParticipants, validTotalFind, validInterest] reduce:^id(NSNumber *isParticipantsValid, NSNumber *isTotalFundValid, NSNumber *isInterestValid){
        
        return @(isParticipantsValid.boolValue &&
                    isTotalFundValid.boolValue &&
                        isInterestValid.boolValue);
    }];
    
    RAC(self, participants) = [self.calculateDividendCommand.executionSignals switchToLatest];
}

- (RACCommand *)calculateDividendCommand {
    if (!_calculateDividendCommand) {
        @weakify(self);
        _calculateDividendCommand = [[RACCommand alloc] initWithEnabled:RACObserve(self, canCalculateDividend) signalBlock:^RACSignal *(id input) {
            @strongify(self);
            
            return [DividendCalculator signalForCalculateDividendWithParticipants:self.participants andCollectedInterest:@(self.interest)];
        }];
    }
    
    return _calculateDividendCommand;
}

- (void)setParticipants:(NSMutableArray<Participant *> *)participants {
    _participants = participants;
    self.tableViewNeedsReload = YES;
}

@end
