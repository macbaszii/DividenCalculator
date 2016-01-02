//
//  MainViewModel.h
//  DevidendCalculator
//
//  Created by Kiattisak Anoochitarom on 1/2/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Participant;
@class RACCommand;

@interface MainViewModel : NSObject

@property (strong, nonatomic) RACCommand *calculateDividendCommand;
@property (nonatomic) BOOL canCalculateDividend;
@property (nonatomic) BOOL tableViewNeedsReload;

@property (nonatomic) double totalFund;
@property (strong, nonatomic) NSMutableArray<Participant *> *participants;
@property (nonatomic) double interest;

- (NSString *)totalFundText;
- (NSString *)interestText;

- (NSString *)addParticipantText;
- (void)addParticipantWithFund:(double)fund;

- (void)clearAllData;

@end
