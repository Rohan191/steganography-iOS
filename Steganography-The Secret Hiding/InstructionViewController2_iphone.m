//
//  InstructionViewController2_iphone.m
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 12/01/14.
//  Copyright (c) 2014 Rohan Tondulkar. All rights reserved.
//

#import "InstructionViewController2_iphone.h"
#import "MainViewController_iphone.h"
#import "InstructionViewController3_iphone.h"

@interface InstructionViewController2_iphone ()

@end

@implementation InstructionViewController2_iphone

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
    MainViewController_iphone *mvc=[[MainViewController_iphone alloc] init];
    [[self navigationController] pushViewController:mvc animated:NO];
}

- (IBAction)goToScreen3:(id)sender
{
    InstructionViewController3_iphone *inst3=[[InstructionViewController3_iphone alloc] init];
    [[self navigationController] pushViewController:inst3 animated:YES];
}

@end
