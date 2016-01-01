//
//  ParticipantCell.h
//  DevidendCalculator
//
//  Created by Kiattisak Anoochitarom on 1/2/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Participant;

@interface ParticipantCell : UITableViewCell

- (void)configureWithParticipant:(Participant *)participant
                           atRow:(NSInteger)row;

@end
