//
//  BillDetailsViewController.m
//  PayGratuity
//
//  Created by Jian Yao Ang on 10/31/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "BillDetailsViewController.h"

@interface BillDetailsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *totalBillAmountPlusTipLabel;
@property (strong, nonatomic) IBOutlet UILabel *paymentPerPersonLabel;

@property (strong, nonatomic) IBOutlet UILabel *billAmountHeaderLabel;
@property (strong, nonatomic) IBOutlet UILabel *paymentPerPersonHeaderLabel;
@property (strong, nonatomic) IBOutlet UIButton *backButton;


@end

@implementation BillDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1];
    
    [self stylingTheBackButton];
    
    NSString *totalBillAmountPlusTip = [NSString stringWithFormat:@"%.02f", self.bill.totalBillAmount];
    
    self.totalBillAmountPlusTipLabel.text = totalBillAmountPlusTip;
    
    self.billAmountHeaderLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:22];
    self.paymentPerPersonHeaderLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:22];
    self.totalBillAmountPlusTipLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:25];
    self.paymentPerPersonLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:25];
    
    
    NSString *paymentPerPerson = [NSString stringWithFormat:@"%.02f", self.bill.billToBePaidPerson];
    
    if ([paymentPerPerson isEqualToString:@"Nan"] || [paymentPerPerson isEqualToString:@"nan"])
    {
        self.paymentPerPersonLabel.text = [NSString stringWithFormat:@"0.00"];
    }
    else
    {
        self.paymentPerPersonLabel.text = paymentPerPerson;
    }
    
    if ([paymentPerPerson isEqualToString:@"0.00"])
    {
        self.totalBillAmountPlusTipLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:16];
        self.totalBillAmountPlusTipLabel.text = @"Please ensure all fields are entered";
    }
    else
    {
        self.paymentPerPersonLabel.text = paymentPerPerson;
    }
    
    if ([paymentPerPerson isEqualToString:@"inf"])
    {
        self.paymentPerPersonLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:18];
        self.paymentPerPersonLabel.text = @"Please enter number of people";
    }
    else
    {
        self.paymentPerPersonLabel.text = paymentPerPerson;
    }
}

-(void)stylingTheBackButton
{
    [self.backButton setBackgroundColor:[UIColor colorWithRed:1.13 green:0.39 blue:0.44 alpha:1]];
    [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.backButton.titleLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:20];
}

- (IBAction)onBackButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
