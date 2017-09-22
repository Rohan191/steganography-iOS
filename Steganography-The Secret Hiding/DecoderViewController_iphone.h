//
//  DecoderViewController_iphone.h
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 30/12/13.
//  Copyright (c) 2013 Rohan Tondulkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DecoderViewController_iphone : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *hiddenMessage;
@property (strong,nonatomic) NSDictionary *imgdict;
@property (strong, nonatomic) UIImage *stegoImage;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *photosInstruction;
@property BOOL pwdFlag;
@property unsigned long textLimit;
- (IBAction)selectImage:(id)sender;
- (IBAction)clearImage:(id)sender;
- (IBAction)getMessage:(id)sender;
- (IBAction)goHome:(id)sender;
- (IBAction)copyToClipboard:(id)sender;
- (IBAction)backgroundTouched:(id)sender;
@end
