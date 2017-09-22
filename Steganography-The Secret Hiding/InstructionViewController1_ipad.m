//
//  InstructionViewController1_ipad.m
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 15/01/14.
//  Copyright (c) 2014 Rohan Tondulkar. All rights reserved.
//

#import "InstructionViewController1_ipad.h"
#import "InstructionViewController2_ipad.h"
#import "MainViewController_ipad.h"

@interface InstructionViewController1_ipad ()

@end

@implementation InstructionViewController1_ipad

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
    [[self navigationController] setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)openmainScreen:(id)sender
{
    MainViewController_ipad *mvc=[[MainViewController_ipad alloc] init];
    [[self navigationController] pushViewController:mvc animated:NO];
}

- (IBAction)goToInst2:(id)sender
{
    InstructionViewController2_ipad *inst2=[[InstructionViewController2_ipad alloc] init];
    [[self navigationController] pushViewController:inst2 animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
}
@end
