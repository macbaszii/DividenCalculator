//
//  ViewController.m
//  DevidendCalculator
//
//  Created by Kiattisak Anoochitarom on 1/2/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

#import "MainViewController.h"
#import "CircleButton.h"
#import "ParticipantCell.h"

static NSString * const ParticipantCellIdentifier = @"ParticipantCell";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *interestLabel;

@property (weak, nonatomic) IBOutlet CircleButton *addParticipantButton;
@property (weak, nonatomic) IBOutlet CircleButton *calcualteButton;
@property (weak, nonatomic) IBOutlet CircleButton *editInterestButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - Actions

- (IBAction)addParticipant:(id)sender {

}

- (IBAction)editInterest:(id)sender {

}

- (IBAction)calculateDividend:(id)sender {
    
}

#pragma mark - UITableViewDataSource and UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ParticipantCell *cell = [tableView dequeueReusableCellWithIdentifier:ParticipantCellIdentifier
                                                            forIndexPath:indexPath];
    return cell;
}

#pragma mark - Internal Methods

- (void)setupView {
    
}

@end
