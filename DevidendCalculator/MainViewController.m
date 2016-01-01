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
#import "UIColor+Generator.h"
#import "MainViewModel.h"
#import "Participant.h"

static NSString * const ParticipantCellIdentifier = @"ParticipantCell";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *totalFundLabel;
@property (weak, nonatomic) IBOutlet UILabel *interestLabel;

@property (weak, nonatomic) IBOutlet CircleButton *addParticipantButton;
@property (weak, nonatomic) IBOutlet CircleButton *calcualteButton;
@property (weak, nonatomic) IBOutlet CircleButton *editInterestButton;

@property (strong, nonatomic) MainViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
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
    return self.viewModel.participants.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ParticipantCell *cell = [tableView dequeueReusableCellWithIdentifier:ParticipantCellIdentifier
                                                            forIndexPath:indexPath];
    Participant *participant = self.viewModel.participants[indexPath.row];
    [cell configureWithParticipant:participant atRow:indexPath.row];
    
    return cell;
}

#pragma mark - Internal Methods

- (void)setupData {
    self.viewModel = [[MainViewModel alloc] init];
}

- (void)setupView {
    self.addParticipantButton.backgroundColor = [UIColor addParticipantButtonColor];
    self.calcualteButton.backgroundColor = [UIColor calculateButtonColor];
    self.editInterestButton.backgroundColor = [UIColor editInterestButtonColor];
    
    [self updateLabels];
}

- (void)updateLabels {
    self.totalFundLabel.text = self.viewModel.totalFundText;
    self.interestLabel.text = self.viewModel.interestText;
}

@end
