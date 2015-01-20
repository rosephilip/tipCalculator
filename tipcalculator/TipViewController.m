//
//  TipViewController.m
//  tipcalculator
//
//  Created by Rose Marie Philip on 1/19/15.
//  Copyright (c) 2015 Rose Marie Philip. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"
@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *billAmount;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
- (IBAction)returnKey:(id)sender;
- (IBAction)onTap:(id)sender;
- (IBAction)clearButton:(id)sender;
- (void)updateValues;
- (void)setBillTotal:(float)newValue;
- (void)setCurrentTip;
- (void)setDefaultTip;
@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateValues];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    [self setBillTotal: 0.0];
    [self setDefaultTip];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)returnKey:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (IBAction)clearButton:(id)sender {
    self.billTextField.text = @"";
    [self setBillTotal: 0.0];
    [self setCurrentTip];
    [self updateValues];
}

- (void)updateValues {
    float addedPrice = [self.billTextField.text floatValue];
    self.billTextField.text = @"";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float billTotal = [defaults floatForKey:@"billTotal"];
    billTotal = billTotal + addedPrice;
    [self setBillTotal: billTotal];
    
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billTotal * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    
    self.billAmount.text = [NSString stringWithFormat:@"$%0.2f", billTotal];
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", billTotal + tipAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setCurrentTip];
    [self updateValues];
}

- (void)setBillTotal:(float)newValue{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:newValue forKey:@"billTotal"];
    [defaults synchronize];
}

- (void)setDefaultTip {
    int defaultTipIndex = 2;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:defaultTipIndex forKey:@"defaultTip"];
    [defaults synchronize];
    self.tipControl.selectedSegmentIndex = defaultTipIndex;
}

- (void)setCurrentTip {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger tipValueIndex = [defaults integerForKey:@"defaultTip"];
    self.tipControl.selectedSegmentIndex = tipValueIndex;
}

@end
