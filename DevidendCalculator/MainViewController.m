//
//  ViewController.m
//  DevidendCalculator
//
//  Created by Kiattisak Anoochitarom on 1/2/2559 BE.
//  Copyright © 2559 Kiattisak Anoochitarom. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "MainViewController.h"
#import "CircleButton.h"
#import "ParticipantCell.h"
#import "UIColor+Generator.h"
#import "MainViewModel.h"
#import "Participant.h"
#import "NSString+Helper.h"

static NSString * const ParticipantCellIdentifier = @"ParticipantCell";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *totalFundLabel;
@property (weak, nonatomic) IBOutlet UILabel *interestLabel;

@property (weak, nonatomic) IBOutlet CircleButton *addParticipantButton;
@property (weak, nonatomic) IBOutlet CircleButton *calculateButton;
@property (weak, nonatomic) IBOutlet CircleButton *editInterestButton;

@property (strong, nonatomic) MainViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSIndexPath *latestIndexPath;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBindings];
    [self setupView];
}

#pragma mark - Actions

- (IBAction)addParticipant:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[self.viewModel addParticipantText] message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.placeholder = @"ใส่จำนวนเงินเป็นตัวเลข";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"เพิ่ม" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *input = alert.textFields.firstObject.text;
        if ([input isNumeric]) {
            [self.viewModel addParticipantWithFund:[input doubleValue]];
            [self updateLabels];
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"ยกเลิก" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)editInterest:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"แก้ไขดอกเบี้ย" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.placeholder = @"ใส่จำนวนดอกเบี้ยเป็นตัวเลข";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"แก้ไข" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *input = alert.textFields.firstObject.text;
        if ([input isNumeric]) {
            self.viewModel.interest = [input doubleValue];
            [self updateLabels];
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"ยกเลิก" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)clear:(id)sender {
    [self.viewModel clearAllData];
    [self updateLabels];
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

- (void)setupView {
    [self.addParticipantButton setTitle:@"เพิ่ม\nผู้ร่วมทุน"
                               forState:UIControlStateNormal];
    self.addParticipantButton.backgroundColor = [UIColor addParticipantButtonColor];
    self.calculateButton.backgroundColor = [UIColor calculateButtonColor];
    self.editInterestButton.backgroundColor = [UIColor editInterestButtonColor];
    
    [self updateLabels];
}

- (void)setupBindings {
    self.viewModel = [[MainViewModel alloc] init];
    self.calculateButton.rac_command = self.viewModel.calculateDividendCommand;
    
    RAC(self, calculateButton.enabled) = RACObserve(self, viewModel.canCalculateDividend);
    RAC(self, calculateButton.alpha) = [RACObserve(self, viewModel.canCalculateDividend) map:^id(NSNumber *canCalculate) {
        return (canCalculate.boolValue) ? @1.0 : @0.4;
    }];
    
    RAC(self, latestIndexPath) = [RACObserve(self, viewModel.participants) map:^id(NSArray<Participant *> *participants) {
        return [NSIndexPath indexPathForRow:participants.count
                                  inSection:0];
    }];
    
    [self rac_liftSelector:@selector(calculationCompleted:)
               withSignals:[RACObserve(self, viewModel.tableViewNeedsReload) ignore:@NO], nil];
}

- (void)calculationCompleted:(NSNumber *)completed {
    NSIndexPath *addingIndexPath = [NSIndexPath indexPathForRow:(self.viewModel.participants.count - 1)
                                                      inSection:0];
    if ([self.latestIndexPath isEqual:addingIndexPath]) {
        [self.tableView insertRowsAtIndexPaths:@[addingIndexPath]
                              withRowAnimation:UITableViewRowAnimationRight];
    } else {
        [self.tableView reloadData];
    }
    
    self.viewModel.tableViewNeedsReload = NO;
}

- (void)updateLabels {
    self.totalFundLabel.text = self.viewModel.totalFundText;
    self.interestLabel.text = self.viewModel.interestText;
}

@end
