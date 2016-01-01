//
//  ParticipantCell.m
//  DevidendCalculator
//
//  Created by Kiattisak Anoochitarom on 1/2/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

#import "ParticipantCell.h"
#import "Participant.h"

@interface ParticipantCell()

@property (weak, nonatomic) IBOutlet UILabel *fundLabel;
@property (weak, nonatomic) IBOutlet UILabel *dividendLabel;

@end

@implementation ParticipantCell

- (void)configureWithParticipant:(Participant *)participant
                           atRow:(NSInteger)row {
    
    self.fundLabel.text = [NSString stringWithFormat:@"%ld. %.2f", row + 1, participant.fund];
    self.dividendLabel.text = (participant.dividend == -1) ? @"-" : [NSString stringWithFormat:@"%.2f", participant.fund];
}

@end
