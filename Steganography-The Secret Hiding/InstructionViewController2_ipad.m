//
//  InstructionViewController2_ipad.m
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 15/01/14.
//  Copyright (c) 2014 Rohan Tondulkar. All rights reserved.
//

#import "InstructionViewController2_ipad.h"
#import "InstructionViewController3_ipad.h"
#import "MainViewController_ipad.h"

@interface InstructionViewController2_ipad ()

@end

@implementation InstructionViewController2_ipad

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeScreen:(id)sender
{
    MainViewController_ipad*mvc=[[MainViewController_ipad alloc] init];
    [[self navigationController] pushViewController:mvc animated:NO];
}

- (IBAction)goToScreen3:(id)sender
{
    InstructionViewController3_ipad *inst3=[[InstructionViewController3_ipad alloc] init];
    [[self navigationController] pushViewController:inst3 animated:YES];
}

@end
