//
//  ViewController.m
//  PayGratuity
//
//  Created by Jian Yao Ang on 10/31/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "ViewController.h"
#import "Bill.h"
#import "BillDetailsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *totalBillAmountTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberOfPeopleTextField;
@property (strong, nonatomic) Bill *bill;
@property (strong, nonatomic) IBOutlet UIButton *tenPercentButton;
@property (strong, nonatomic) IBOutlet UIButton *twelvePercentButton;
@property (strong, nonatomic) IBOutlet UIButton *fifteenPercentButton;
@property (strong, nonatomic) IBOutlet UIButton *eighteenPercentButton;
@property (strong, nonatomic) IBOutlet UIButton *twentyPercentButton;
@property (strong, nonatomic) IBOutlet UIButton *twentyFivePercentButton;
@property (strong, nonatomic) IBOutlet UIButton *calculateButton;

@property (strong, nonatomic) IBOutlet UILabel *totalBillAmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *tipPercentageLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfPeopleLabel;
@property (strong, nonatomic) IBOutlet UIView *tipView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1];
    self.tipView.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1];
    
    [self settingKeyboard];
    [self creatingAdditionalFeaturesToButton];
    
    self.bill = [Bill new];

    [self stylingTheButtons:self.tenPercentButton];
    [self stylingTheButtons:self.twelvePercentButton];
    [self stylingTheButtons:self.fifteenPercentButton];
    [self stylingTheButtons:self.eighteenPercentButton];
    [self stylingTheButtons:self.twentyPercentButton];
    [self stylingTheButtons:self.twentyFivePercentButton];
    [self stylingCalculateButton:self.calculateButton];
    
    self.numberOfPeopleLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:22];
    self.totalBillAmountLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:22];
    self.tipPercentageLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:22];
    
    
    [self enableTheButtonWhenTotalBillIsAvailable];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.totalBillAmountTextField.text = @"";
    self.numberOfPeopleTextField.text = @"";
    
    for (UIView *button in self.tenPercentButton.superview.subviews)
    {
        if ([button isKindOfClass:[UIButton class]])
        {
            [(UIButton*)button setSelected:NO];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self calculateTipAmount:0.0];
}

-(void)enableTheButtonWhenTotalBillIsAvailable
{
    if (![self.totalBillAmountTextField.text isEqualToString:@""])
    {
        [self.tenPercentButton setEnabled:YES];
        [self.twelvePercentButton setEnabled:YES];
        [self.fifteenPercentButton setEnabled:YES];
        [self.eighteenPercentButton setEnabled:YES];
        [self.twentyPercentButton setEnabled:YES];
        [self.twentyFivePercentButton setEnabled:YES];
    }
}

#pragma mark - styling percentage uibutton
-(void)stylingTheButtons: (UIButton*)button
{
    button.layer.cornerRadius = 30;
    button.layer.borderWidth = 2;
    button.layer.borderColor = [UIColor colorWithRed:1.13 green:0.39 blue:0.44 alpha:1].CGColor;
//    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:18];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

#pragma mark - styling calculate button
-(void)stylingCalculateButton:(UIButton*)button
{
    [button setBackgroundColor:[UIColor colorWithRed:1.13 green:0.39 blue:0.44 alpha:1]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:20];
//  [button setBackgroundColor:[UIColor colorWithRed:0.22f green:0.42f blue:0.58f alpha:0.7f]];
}

#pragma mark - setting keyboard
-(void)settingKeyboard
{
        self.totalBillAmountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.totalBillAmountTextField.textAlignment = NSTextAlignmentCenter;
    self.numberOfPeopleTextField.textAlignment = NSTextAlignmentCenter;
    self.numberOfPeopleTextField.delegate = self;
    self.totalBillAmountTextField.backgroundColor = [UIColor clearColor];
    self.numberOfPeopleTextField.backgroundColor = [UIColor clearColor];
    self.totalBillAmountTextField.layer.borderColor = [[UIColor grayColor]CGColor];
    self.numberOfPeopleTextField.layer.borderColor = [[UIColor grayColor]CGColor ];
    self.totalBillAmountTextField.layer.borderWidth = 1;
    self.numberOfPeopleTextField.layer.borderWidth = 1;
    
    self.totalBillAmountTextField.font = [UIFont fontWithName:@"Raleway-Regular" size:20];
    self.numberOfPeopleTextField.font = [UIFont fontWithName:@"Raleway-Regular" size:20];
}

#pragma mark - calculation
- (IBAction)onCalculateButtonPressed:(id)sender
{
    self.bill.billToBePaidPerson = self.bill.totalBillAmount / self.numberOfPeopleTextField.text.floatValue;
    NSLog(@"%f", self.bill.billToBePaidPerson);
}

- (IBAction)onTenPercentButtonPressed:(id)sender
{
    if (![self.totalBillAmountTextField.text isEqualToString:@""])
    {
        [self.tenPercentButton setEnabled:YES];
        
        for (UIView *button in self.tenPercentButton.superview.subviews)
        {
            if ([button isKindOfClass:[UIButton class]])
            {
                [(UIButton*)button setSelected:NO];
            }
        }
        
        [self.tenPercentButton setSelected:YES];
        
        [self calculateTipAmount:0.1];
        [self.totalBillAmountTextField resignFirstResponder];
    }
    else
    {
        [self.tenPercentButton setSelected:NO];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Pay Gratuity" message:@"Please type in total bill amount first" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"Done was selected to dismiss alert controller");
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)onTwelvePercentButtonPressed:(id)sender
{
    if (![self.totalBillAmountTextField.text isEqualToString:@""])
    {
        for (UIView *button in self.twelvePercentButton.superview.subviews)
        {
            if ([button isKindOfClass:[UIButton class]])
            {
                [(UIButton*)button setSelected:NO];
            }
        }
        [self.twelvePercentButton setSelected:YES];
        
        [self calculateTipAmount:0.12];
        [self.totalBillAmountTextField resignFirstResponder];
    }
    else
    {
        [self.twelvePercentButton setSelected:NO];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Pay Gratuity" message:@"Please type in total bill amount first" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"Done was selected to dismiss alert controller");
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

- (IBAction)onFifteenPercentButtonPressed:(id)sender
{
    if (![self.totalBillAmountTextField.text isEqualToString:@""])
    {
        for (UIView *button in self.fifteenPercentButton.superview.subviews)
        {
            if ([button isKindOfClass:[UIButton class]])
            {
                [(UIButton*)button setSelected:NO];
            }
        }
        [self.fifteenPercentButton setSelected:YES];
        
        [self calculateTipAmount:0.15];
        [self.totalBillAmountTextField resignFirstResponder];
    }
    else
    {
        [self.fifteenPercentButton setSelected:NO];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Pay Gratuity" message:@"Please type in total bill amount first" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"Done was selected to dismiss alert controller");
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];

    }
    
}

- (IBAction)onEigteenPercentButtonPrecent:(id)sender
{
    if (![self.totalBillAmountTextField.text isEqualToString:@""])
    {
        for (UIView *button in self.eighteenPercentButton.superview.subviews)
        {
            if ([button isKindOfClass:[UIButton class]])
            {
                [(UIButton*)button setSelected:NO];
            }
        }
        [self.eighteenPercentButton setSelected:YES];
        
        [self calculateTipAmount:0.18];
        [self.totalBillAmountTextField resignFirstResponder];
    }
    else
    {
        [self.eighteenPercentButton setSelected:NO];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Pay Gratuity" message:@"Please type in total bill amount first" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"Done was selected to dismiss alert controller");
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}

- (IBAction)onTwentyPercentButtonPressed:(id)sender
{
    if (![self.totalBillAmountTextField.text isEqualToString:@""])
    {
        for (UIView *button in self.twentyPercentButton.superview.subviews)
        {
            if ([button isKindOfClass:[UIButton class]])
            {
                [(UIButton*)button setSelected:NO];
            }
        }
        [self.twentyPercentButton setSelected:YES];
        
        
        [self calculateTipAmount:0.20];
        [self.totalBillAmountTextField resignFirstResponder];
    }
    else
    {
        [self.twentyPercentButton setSelected:NO];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Pay Gratuity" message:@"Please type in total bill amount first" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"Done was selected to dismiss alert controller");
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


- (IBAction)onTwentyFivePercentButtonPressed:(id)sender
{
    
    if (![self.totalBillAmountTextField.text isEqualToString:@""])
    {
        for (UIView *button in self.twentyFivePercentButton.superview.subviews)
        {
            if ([button isKindOfClass:[UIButton class]])
            {
                [(UIButton*)button setSelected:NO];
            }
        }
        [self.twentyFivePercentButton setSelected:YES];
        
        [self calculateTipAmount:0.25];
        [self.totalBillAmountTextField resignFirstResponder];
    }
    else
    {
        [self.twentyFivePercentButton setSelected:NO];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Pay Gratuity" message:@"Please type in total bill amount first" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"Done was selected to dismiss alert controller");
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)calculateTipAmount:(float)tipPercentage
{
    self.bill.billAmount = self.totalBillAmountTextField.text.floatValue;
    
    float tipAmount = tipPercentage * self.bill.billAmount;
    
    self.bill.totalBillAmount = tipAmount + self.bill.billAmount;
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 180, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 180, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

#pragma mark - touches Began
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.totalBillAmountTextField resignFirstResponder];
    [self.numberOfPeopleTextField resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma adding buttons to number pad
-(void)creatingAdditionalFeaturesToButton
{
    UIToolbar *numberToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButtonPressed)],
                           [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onDoneButtonPressed)],
                           nil];
    [numberToolbar sizeToFit];
    self.numberOfPeopleTextField.inputAccessoryView = numberToolbar;
    self.totalBillAmountTextField.inputAccessoryView = numberToolbar;

}

-(void)onCancelButtonPressed
{
    [self.numberOfPeopleTextField resignFirstResponder];
    [self.totalBillAmountTextField resignFirstResponder];
    self.numberOfPeopleTextField.text = @"";
    self.totalBillAmountTextField.text = @"";
}
                           
-(void)onDoneButtonPressed
{
    [self.totalBillAmountTextField resignFirstResponder];
    [self.numberOfPeopleTextField resignFirstResponder];

}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BillDetailsViewController *bdvc = segue.destinationViewController;
    bdvc.bill = self.bill;
}

@end
