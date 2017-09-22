//
//  InstructionViewController4_iphone.m
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 12/01/14.
//  Copyright (c) 2014 Rohan Tondulkar. All rights reserved.
//

#import "InstructionViewController4_iphone.h"
#import "MainViewController_iphone.h"

@interface InstructionViewController4_iphone ()

@end

@implementation InstructionViewController4_iphone

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

- (IBAction)mainScreen:(id)sender
{
    MainViewController_iphone *mvc=[[MainViewController_iphone alloc] init];
    [[self navigationController] pushViewController:mvc animated:NO];
}
@end
