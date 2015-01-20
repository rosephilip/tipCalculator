//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Rose Marie Philip on 1/19/15.
//  Copyright (c) 2015 Rose Marie Philip. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipDefaultControl;
- (IBAction)onSettingsTap:(id)sender;
- (void)updateDefaultTip;
@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger intValue = [defaults integerForKey:@"defaultTip"];
    self.tipDefaultControl.selectedSegmentIndex = intValue;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSettingsTap:(id)sender {
    [self updateDefaultTip];
}

- (void)updateDefaultTip {
    NSInteger tipSelection = self.tipDefaultControl.selectedSegmentIndex;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:tipSelection forKey:@"defaultTip"];
    [defaults synchronize];
}

@end
