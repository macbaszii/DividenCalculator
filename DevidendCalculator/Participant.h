//
//  Participant.h
//  DevidendCalculator
//
//  Created by Kiattisak Anoochitarom on 1/2/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Participant : NSObject

@property (nonatomic) double fund;
@property (nonatomic) double dividend;

- (instancetype)initWithFund:(double)fund;

@end
