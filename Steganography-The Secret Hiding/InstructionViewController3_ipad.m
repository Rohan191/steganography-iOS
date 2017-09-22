//
//  InstructionViewController3_ipad.m
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 15/01/14.
//  Copyright (c) 2014 Rohan Tondulkar. All rights reserved.
//

#import "InstructionViewController3_ipad.h"
#import "InstructionViewController4_ipad.h"
#import "MainViewController_ipad.h"

@interface InstructionViewController3_ipad ()

@end

@implementation InstructionViewController3_ipad

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
    MainViewController_ipad *mvc=[[MainViewController_ipad alloc] init];
    [[self navigationController] pushViewController:mvc animated:NO];
}

- (IBAction)goToInstruction4:(id)sender
{
    InstructionViewController4_ipad *inst4=[[InstructionViewController4_ipad alloc]init];
    [[self navigationController] pushViewController:inst4 animated:YES];
}
@end
