//
//  EncoderViewController_iphone.h
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 30/12/13.
//  Copyright (c) 2013 Rohan Tondulkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EncoderViewController_iphone : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextField *message;
@property (strong,nonatomic) NSDictionary *imgdict;
@property  unsigned long textLimit;
@property (strong, nonatomic) UIImage *user_image;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UISwitch *onOffpassword;
@property (weak, nonatomic) IBOutlet UILabel *charDisplay;
@property (weak, nonatomic) IBOutlet UILabel *photosInstruction;
@property BOOL pwdFlag;
- (IBAction)create_stego:(id)sender;
- (IBAction)checkLength:(id)sender;
- (IBAction)goHome:(id)sender;
- (IBAction)browseDocs:(id)sender;
- (IBAction)pwdSwitch:(id)sender;

- (IBAction)selectImage:(id)sender;
- (IBAction)clearImage:(id)sender;
- (IBAction)saveImage:(id)sender;
- (IBAction)backgroundTouched:(id)sender;
@end
