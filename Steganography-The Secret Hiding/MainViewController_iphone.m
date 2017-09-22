//
//  MainViewController_iphone.m
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 30/12/13.
//  Copyright (c) 2013 Rohan Tondulkar. All rights reserved.
//

#import "MainViewController_iphone.h"
#import "EncoderViewController_iphone.h"
#import "DecoderViewController_iphone.h"
#import "InstructionsViewController1_iphone.h"

@interface MainViewController_iphone ()

@end

@implementation MainViewController_iphone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES];

}
- (void)viewDidLoad
{
    [[self navigationItem] setTitle:@"Steganography"];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openEncoder:(id)sender
{
    EncoderViewController_iphone *encoder_iphone=[[EncoderViewController_iphone alloc] init];
    [[self navigationController] pushViewController:encoder_iphone animated:YES];
}

- (IBAction)openDecoder:(id)sender
{
    DecoderViewController_iphone *decoder_iphone=[[DecoderViewController_iphone alloc] init];
    [[self navigationController] pushViewController:decoder_iphone animated:YES];
}

- (IBAction)openTutorial:(id)sender
{
    InstructionsViewController1_iphone *inst1=[[InstructionsViewController1_iphone alloc] init];
    [[self navigationController] pushViewController:inst1 animated:NO];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background1.png"]]];
    //[[[self navigationController] navigationBar] setTintColor:[UIColor colorWithRed:0 green:71  blue:71 alpha:1]];
}
@end
