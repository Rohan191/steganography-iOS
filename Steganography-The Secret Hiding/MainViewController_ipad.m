//
//  MainViewController_ipad.m
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 30/12/13.
//  Copyright (c) 2013 Rohan Tondulkar. All rights reserved.
//

#import "MainViewController_ipad.h"
#import "EncoderViewController_ipad.h"
#import "DecoderViewController_ipad.h"
#import "InstructionViewController1_ipad.h"

@interface MainViewController_ipad ()

@end

@implementation MainViewController_ipad

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openEncoder:(id)sender
{
    EncoderViewController_ipad *encoder_ipad=[[EncoderViewController_ipad alloc] init];
    [[self navigationController] pushViewController:encoder_ipad animated:YES];
}

-(void)openDecoder:(id)sender
{
    DecoderViewController_ipad *decoder_ipad=[[DecoderViewController_ipad alloc] init];
    [[self navigationController] pushViewController:decoder_ipad animated:YES];
}

- (IBAction)openTutorial:(id)sender
{
    InstructionViewController1_ipad *inst1=[[InstructionViewController1_ipad alloc] init];
    [[self navigationController] pushViewController:inst1 animated:NO];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    //[[[self navigationController] navigationBar] setTintColor:[UIColor colorWithRed:0 green:71  blue:71 alpha:1]];
}

@end
