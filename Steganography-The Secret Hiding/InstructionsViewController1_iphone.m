//
//  InstructionsViewController1_iphone.m
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 12/01/14.
//  Copyright (c) 2014 Rohan Tondulkar. All rights reserved.
//

#import "InstructionsViewController1_iphone.h"
#import "MainViewController_iphone.h"
#import "InstructionViewController2_iphone.h"

@interface InstructionsViewController1_iphone ()

@end

@implementation InstructionsViewController1_iphone

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
    MainViewController_iphone *mvc=[[MainViewController_iphone alloc] init];
    [[self navigationController] pushViewController:mvc animated:NO];
}

- (IBAction)goToInst2:(id)sender
{
    InstructionViewController2_iphone *inst2=[[InstructionViewController2_iphone alloc] init];
    [[self navigationController] pushViewController:inst2 animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background1.png"]]];
}
@end
