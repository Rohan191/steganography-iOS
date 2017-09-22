//
//  EncoderViewController_ipad.m
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 30/12/13.
//  Copyright (c) 2013 Rohan Tondulkar. All rights reserved.
//

#import "EncoderViewController_ipad.h"
#import "Text_Binary_Converter.h"
#import "NSString+Encryption.h"
#import "NSData+Encryption.h"
#import <CommonCrypto/CommonCryptor.h>

@interface EncoderViewController_ipad ()

@end

@implementation EncoderViewController_ipad

@synthesize image,message,imgdict,user_image, textLimit,charDisplay, pwdFlag, password,onOffpassword,photosInstruction,po;

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
    //[[[self navigationController] navigationBar] setTintColor:[UIColor colorWithRed:20 green:100  blue:100 alpha:1]];
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[self navigationItem] setTitle:@"Stego Image"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)create_stego:(id)sender
{
    
    if (([[message text] isEqualToString:@"" ] || [image image]==nil) && (pwdFlag==YES && [[password text] isEqualToString:@"" ]) )
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Please insert all of image, message and password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([[message text] isEqualToString:@"" ] || [image image]==nil)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Please insert both image and message" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (pwdFlag==YES && [[password text] isEqualToString:@"" ])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Please use a password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
       
        //message.text=@"done";
        CGContextRef ctx;
        CGImageRef imageRef = [self.user_image CGImage];
        NSUInteger width = CGImageGetWidth(imageRef);
        NSUInteger height = CGImageGetHeight(imageRef);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        //int x[width*height*4];
        unsigned char *rawData  = malloc(width*height*4);
        NSUInteger bytesPerPixel = 4;
        NSUInteger bytesPerRow = bytesPerPixel * width;
        NSUInteger bitsPerComponent = 8;
        CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                     bitsPerComponent, bytesPerRow, colorSpace,
                                                     kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
        CGColorSpaceRelease(colorSpace);
        
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
        CGContextRelease(context);
        //NSLog(@"%d,%d",width,height);
        
        
        //**********************************************************
        //**** to make sure the image contains a hidden message ****
        //**********************************************************
        unsigned long byteIndex = (width)*(height/2)*4 + (width/2)*4;
        //int byteIndex=0;
        for (int ii = 0 ; ii < 30; ii++)
        {
            //NSLog(@"%hhu, %hhu, %hhu",rawData[byteIndex],rawData[byteIndex+1],rawData[byteIndex+2]);
            if (rawData[byteIndex]%2==1) {
                rawData[byteIndex]=(unsigned char) (rawData[byteIndex]-1);
            }
            if (rawData[byteIndex+ 1]%2==1) {
                rawData[byteIndex+1]=(unsigned char) (rawData[byteIndex+1]-1);
            }
            if (rawData[byteIndex+2]%2==1) {
                rawData[byteIndex+2]=(unsigned char) (rawData[byteIndex+2]-1);
            }
            //NSLog(@"%hhu %hhu %hhu",rawData[byteIndex],rawData[byteIndex+1],rawData[byteIndex+2]);
            
            byteIndex += 4;
        }
        //NSLog(@"%d",byteIndex);
        //************************************************************
        //****** to embed the number of characters in image **********
        //************************************************************
        NSString *key=@"r1o2h3a4n5";
        NSString *encrpted=[[message text] AES256EncryptWithKey:key];
        unsigned long msgLength=[encrpted length];
        NSLog(@"%@",encrpted);
        Text_Binary_Converter *tbc=[[Text_Binary_Converter alloc]init];
        int power=[tbc getPower:textLimit];
        int b[power];
        [tbc integerToBinary:msgLength andArray:b andPower:power];
        byteIndex=width*2*4;
        //NSLog(@"%d, %d",textLimit, power);
        for (int i=0; i<power; i++) {
            //NSLog(@"%d",b[i]);
            if (b[i]==1) {
                if (rawData[byteIndex]%2==0) {
                    rawData[byteIndex]=(unsigned char)(rawData[byteIndex]+1);
                }
            }
            else    //b[i]==0
            {
                if (rawData[byteIndex]%2==1) {
                    rawData[byteIndex]=(unsigned char)(rawData[byteIndex]-1);
                }
            }
            
            byteIndex+=4;
        }
        
        //*************************************************************
        //****** to embed the text in image ***************************
        //*************************************************************
        byteIndex=width*3*4;
        int charBin[8],val,count=0,j=0;
        unsigned char current;
        for (NSUInteger i=0; i<msgLength; i++) {
            current=[encrpted characterAtIndex:i];
            val=current;
            [tbc integerToBinary:val andArray:charBin andPower:8];
            j=0;
            count=0;
            while (j<8) {
                if (charBin[j]==1) {
                    if (rawData[byteIndex]%2==0) {
                        rawData[byteIndex]=(unsigned char)(rawData[byteIndex]+1);
                    }
                }
                else    //b[i]==0
                {
                    if (rawData[byteIndex]%2==1) {
                        rawData[byteIndex]=(unsigned char)(rawData[byteIndex]-1);
                    }
                }
                //NSLog(@"%d, %d",rawData[byteIndex]%2, byteIndex);
                j++;
                count++;
                byteIndex++;
                if (count==3) {
                    count=0;
                    byteIndex++;
                }
            }
            if (count==2) {
                byteIndex+=2;
            }
        }
        if(pwdFlag){
            //*************************************************************
            //****** to put if password is present ************************
            //*************************************************************
            byteIndex = (width)*(height/2+2)*4;
            //NSLog(@"%d",byteIndex);
            //int byteIndex=0;
            for (int ii = 0 ; ii < 30; ii++)
            {
                //NSLog(@"%hhu, %hhu, %hhu",rawData[byteIndex],rawData[byteIndex+1],rawData[byteIndex+2]);
                if (rawData[byteIndex]%2==1) {
                    rawData[byteIndex]=(unsigned char) (rawData[byteIndex]-1);
                }
                if (rawData[byteIndex+ 1]%2==1) {
                    rawData[byteIndex+1]=(unsigned char) (rawData[byteIndex+1]-1);
                }
                if (rawData[byteIndex+2]%2==1) {
                    rawData[byteIndex+2]=(unsigned char) (rawData[byteIndex+2]-1);
                }
                //NSLog(@"%hhu %hhu %hhu",rawData[byteIndex],rawData[byteIndex+1],rawData[byteIndex+2]);
                
                byteIndex += 4;
            }
            
            //************************************************************
            //****** to embed the number of characters of password *******
            //************************************************************
            NSString *pwdencrypted=[[password text] AES256EncryptWithKey:key];
            unsigned long pwdlength=[pwdencrypted length];
            NSLog(@"%@",pwdencrypted);
            int c[6];
            [tbc integerToBinary:pwdlength andArray:c andPower:6];
            byteIndex = (width)*(height/2+3)*4;
            //NSLog(@"%d, %d",textLimit, power);
            for (int i=0; i<6; i++) {
                //NSLog(@"%d",b[i]);
                if (c[i]==1) {
                    if (rawData[byteIndex]%2==0) {
                        rawData[byteIndex]=(unsigned char)(rawData[byteIndex]+1);
                    }
                }
                else    //b[i]==0
                {
                    if (rawData[byteIndex]%2==1) {
                        rawData[byteIndex]=(unsigned char)(rawData[byteIndex]-1);
                    }
                }
                
                byteIndex+=4;
            }
            
            
            //*************************************************************
            //****** to embed the password in image ***********************
            //*************************************************************
            byteIndex = (width)*(height/2+4)*4;
            int pwdBin[8],val,count=0,j=0;
            unsigned char current;
            for (NSUInteger i=0; i<pwdlength; i++) {
                current=[pwdencrypted characterAtIndex:i];
                val=current;
                [tbc integerToBinary:val andArray:pwdBin andPower:8];
                j=0;
                count=0;
                while (j<8) {
                    if (pwdBin[j]==1) {
                        if (rawData[byteIndex]%2==0) {
                            rawData[byteIndex]=(unsigned char)(rawData[byteIndex]+1);
                        }
                    }
                    else    //b[i]==0
                    {
                        if (rawData[byteIndex]%2==1) {
                            rawData[byteIndex]=(unsigned char)(rawData[byteIndex]-1);
                        }
                    }
                    //NSLog(@"%d, %d",rawData[byteIndex]%2, byteIndex);
                    j++;
                    count++;
                    byteIndex++;
                    if (count==3) {
                        count=0;
                        byteIndex++;
                    }
                }
                if (count==2) {
                    byteIndex+=2;
                }
            }
            
        }
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Message Hidden in image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        ctx = CGBitmapContextCreate(rawData,
                                    CGImageGetWidth( imageRef ),
                                    CGImageGetHeight( imageRef ),
                                    8,
                                    CGImageGetBytesPerRow( imageRef ),
                                    CGImageGetColorSpace( imageRef ),
                                    kCGImageAlphaPremultipliedLast );
        
        imageRef = CGBitmapContextCreateImage (ctx);
        UIImage* rawImage = [UIImage imageWithCGImage:imageRef];
        
        CGContextRelease(ctx);
        
        self.user_image = rawImage;
        [self.image setImage:self.user_image];
        
        free(rawData);
    }
}
-(IBAction)checkLength:(id)sender
    {
        if ([[message text] length]>=textLimit) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Length limit reached" delegate:self cancelButtonTitle:@"Back" otherButtonTitles:nil, nil];
            [message endEditing:YES];
            [alert show];
        }
        charDisplay.text=[NSString stringWithFormat:@"%lu/%lu",([message.text length]+1),textLimit];

    }
    
- (IBAction)goHome:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}
    
- (IBAction)pwdSwitch:(id)sender
{
    pwdFlag=[onOffpassword isOn];
    if (!pwdFlag) {
        password.text=nil;
        [password setHidden:YES];
    }
    else
    {
        [password setHidden:NO];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imgdict=info;
    /*UIImage *image1=[info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *originalImage=[info objectForKey:UIImagePickerControllerOriginalImage];
    [image setImage:image1];
    [self dismissViewControllerAnimated:YES completion:nil];*/
    UIImage *image1=[info objectForKey:UIImagePickerControllerOriginalImage];
    [image setImage:image1];
    NSLog(@"%f %f",[image bounds].size.width, [image bounds].size.height);
    NSLog(@"%f %f",[image1 size].width, [image1 size].height);
    [self dismissViewControllerAnimated:YES completion:nil];
    user_image=image1;
    charDisplay.text=[NSString stringWithFormat:@"%lu/%lu",(unsigned long)[message.text length],textLimit];
    Text_Binary_Converter *tbc=[[Text_Binary_Converter alloc]init];
    textLimit=[tbc setLimitWithWidth:image1.size.width andHeight:image1.size.height];
    int temp=[tbc getPower:textLimit];
    textLimit=pow(2.0, temp);
    charDisplay.text=[NSString stringWithFormat:@"%lu/%lu",(unsigned long)message.text.length, textLimit];
    [photosInstruction setHidden:YES];
    [[self po] dismissPopoverAnimated:YES];
}

- (IBAction)selectImage:(id)sender
{
    UIImagePickerController *imagpicker=[[UIImagePickerController alloc] init];
    /*if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagpicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else{
        
        [imagpicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }*/
    [imagpicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagpicker setAllowsEditing:NO];
    [imagpicker setDelegate:self];
    self.po=[[UIPopoverController alloc] initWithContentViewController:imagpicker];
    //self.po.delegate=self;
    [po setDelegate:self];
    
    [[self po] presentPopoverFromRect:image.bounds inView:image permittedArrowDirections:UIPopoverArrowDirectionRight
                             animated:YES];
    //[self presentingViewController:imagpicker animated:YES completion:nil];    
}

- (IBAction)clearImage:(id)sender
{
    [image setImage:nil];
    [photosInstruction setHidden:NO];
}

- (IBAction)saveImage:(id)sender
{
    NSData *saved_image=UIImagePNGRepresentation(user_image);
    UIImage *saving=[[UIImage alloc] initWithData:saved_image];
    UIImageWriteToSavedPhotosAlbum(saving, nil, nil, nil);
    // NSString *fullpath=[NSHomeDirectory() stringByAppendingPathComponent:@"/Pictures/img.png"];
    //[saved_image writeToFile:fullpath atomically:YES];
    if([image image]!=nil)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Image Saved" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)backgroundTouched:(id)sender
{
    [[self view] endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==message){
        if ([image image]==nil) {
            [message setPlaceholder:@"Select an image first"];
            return NO;
        }
        else
        {
            charDisplay.text=[NSString stringWithFormat:@"%lu/%lu",(unsigned long)[message.text length],textLimit];
            //NSUInteger newLength = [textField.text length];
            unsigned long newLength=[[textField text]length];
            //NSLog(@"%d",newLength);
            return (newLength >= textLimit) ? NO : YES;
        }}
    if(textField==password) {
        if (pwdFlag) {
            if ([[password text] length]<=30) {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
            return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    pwdFlag=NO;
    [password setHidden:YES];
    [photosInstruction setHidden:NO];
}

@end
