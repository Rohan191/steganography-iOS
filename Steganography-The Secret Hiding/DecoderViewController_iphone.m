//
//  DecoderViewController_iphone.m
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 30/12/13.
//  Copyright (c) 2013 Rohan Tondulkar. All rights reserved.
//

#import "DecoderViewController_iphone.h"
#import "Text_Binary_Converter.h"
#import "NSString+Encryption.h"

@interface DecoderViewController_iphone ()

@end

@implementation DecoderViewController_iphone

@synthesize image,imgdict,hiddenMessage,stegoImage, textLimit, password, pwdFlag,photosInstruction;

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
    [[self navigationController] setNavigationBarHidden:NO];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background1.png"]]];
    [[self navigationController] setNavigationBarHidden:YES];
    [photosInstruction setHidden:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[self navigationItem] setTitle:@"Retrieve Message"];
    pwdFlag=NO;
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imgdict=info;
    //UIImage *image1=[info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *image1=[info objectForKey:UIImagePickerControllerOriginalImage];
    //UIImage *originalImage=[info objectForKey:UIImagePickerControllerOriginalImage];
    [image setImage:image1];
    [self dismissViewControllerAnimated:YES completion:nil];
    stegoImage=image1;
    password.text=@"";
    hiddenMessage.text=@"";
    [photosInstruction setHidden:YES];
}
- (IBAction)selectImage:(id)sender
{
    UIImagePickerController *imagpicker=[[UIImagePickerController alloc] init];
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        [imagpicker setSourceType:UIImagePickerControllerSourceTypeCamera];
//    }
//    else{
//        
//        [imagpicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//    }
    //[imagpicker setAllowsEditing:YES];
    [imagpicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagpicker setAllowsEditing:NO];
    [imagpicker setDelegate:self];
    [self presentViewController:imagpicker animated:YES completion:nil];
    
}

- (IBAction)clearImage:(id)sender
{
    [image setImage:nil];
    [photosInstruction setHidden:NO];
    password.text=@"";
    hiddenMessage.text=@"";
}

- (IBAction)getMessage:(id)sender
{
    if ([image image]==nil) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Please select a Stego Image" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
   
    else {
        
        //[hiddenMessage setTextColor:[UIColor redColor]];
        //hiddenMessage.text=@"You will get the hidden message";
        //CGContextRef ctx;
        CGImageRef imageRef = [self.stegoImage CGImage];
        NSUInteger width = CGImageGetWidth(imageRef);
        NSUInteger height = CGImageGetHeight(imageRef);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        unsigned char *rawData = malloc(height * width * 4);
        NSUInteger bytesPerPixel = 4;
        NSUInteger bytesPerRow = bytesPerPixel * width;
        NSUInteger bitsPerComponent = 8;
        CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                     bitsPerComponent, bytesPerRow, colorSpace,
                                                     kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
        CGColorSpaceRelease(colorSpace);
        
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
        CGContextRelease(context);
    
        // Now your rawData contains the image data in the RGBA8888 pixel format.
        unsigned long byteIndex = (width)*(height/2)*4+(width/2)*4;
        Text_Binary_Converter *btt=[[Text_Binary_Converter alloc] init];
        textLimit=[btt setLimitWithWidth:width andHeight:height];
        int power=[btt getPower:textLimit];
        textLimit=pow(2.0, power);
        //NSLog(@"%d, %d",textLimit , power);
        //int byteIndex=0;
        int a,b,c;
        NSString *key=@"r1o2h3a4n5";
        BOOL flag=YES;
        //NSLog(@"%d, %d",width ,height);
        //*************************************************************
        //****** to check if the image contains a hidden message ******
        //*************************************************************
        for (int ii = 0 ; ii<30; ii++)
        {
            //NSLog(@"%hhu, %hhu, %hhu",rawData[byteIndex],rawData[byteIndex+1],rawData[byteIndex+2]);
            a=rawData[byteIndex]%2;
            b=rawData[byteIndex+1]%2;
            c=rawData[byteIndex+2]%2;
            //NSLog(@"%d,%d,%d ",a,b,c);
            if (a==1 || b==1 || c==1) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"No hidden message" delegate:self cancelButtonTitle:@"Back" otherButtonTitles:nil, nil];
                [alert show];
                flag=NO;
                break;
            }
            
           
            byteIndex += 4;
        }
        if(flag){
        pwdFlag=YES;
        //*************************************************************
        //****** to check if the image contains password **************
        //*************************************************************
        byteIndex = (width)*(height/2+2)*4;
        for (int ii = 0 ; ii<30; ii++)
        {
            //NSLog(@"%hhu, %hhu, %hhu",rawData[byteIndex],rawData[byteIndex+1],rawData[byteIndex+2]);
            a=rawData[byteIndex]%2;
            b=rawData[byteIndex+1]%2;
            c=rawData[byteIndex+2]%2;
            //NSLog(@"%d,%d,%d ",a,b,c);
            if (a==1 || b==1 || c==1) {
                pwdFlag=NO;
                break;
            }
            
            
            byteIndex += 4;
        }
        if(pwdFlag)
        {
            //*************************************************************
            //****** to get the number of characters in password **********
            //*************************************************************
            byteIndex = (width)*(height/2+3)*4;
            int p[6];
            for (int i=0; i<6; i++) {
                p[i]=rawData[byteIndex]%2;
                byteIndex+=4;
            }
            int pwdLength=[btt binaryToInteger:p andPower:6];
            //NSLog(@"%d",pwdLength);
            
            //*************************************************************
            //****** to get the password **********************************
            //*************************************************************
            byteIndex = (width)*(height/2+4)*4;
            int count=0,dataCount=0;
            NSUInteger letter=0;
            NSMutableString *bin=[[NSMutableString alloc]init];
            NSMutableString *revbin=[[NSMutableString alloc] init];
            NSString *temp;
            for (int ii=0; ii<pwdLength*8; ii++) {
                count++;
                [bin appendFormat:@"%d",(rawData[byteIndex]%2)];
                byteIndex++;
                dataCount++;
                if (count==8) {
                    temp=[btt reverseString:[bin substringWithRange:NSMakeRange(letter*9, 8)]];
                    [bin appendString:@" "];
                    [revbin appendFormat:@"%@ ",temp];
                    count=0;
                    byteIndex+=2;
                    dataCount=0;
                    letter++;
                }
                if (dataCount==3) {
                    byteIndex++;
                    dataCount=0;
                }
            }
            //NSLog(@"%@",revbin);
            NSString *bin1=[NSString stringWithString:revbin];
            
            NSString *result1=[btt BinaryToAsciiString:bin1];
            NSString *result=[result1 AES256DecryptWithKey:key];
            //NSLog(@"%@",result);
            if ([[password text] isEqualToString:@""]) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Please enter the password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                flag=NO;
            }
            else if (![[password text] isEqualToString:result])
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Incorrect password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                flag=NO;
            }
        }
        if (flag)
        {
            //*************************************************************
            //****** to get the number of characters present **************
            //*************************************************************
            //hiddenMessage.text=@"Message present";
            byteIndex=width*2*4;
            int size[power];
            for (int i=0; i<power; i++) {
                size[i]=rawData[byteIndex]%2;
                byteIndex+=4;
            }
            int msgLength=[btt binaryToInteger:size andPower:power];
            //NSLog(@"No of chars: %d",msgLength);
            
            //*************************************************************
            //****** to get the hidden message ****************************
            //*************************************************************
            byteIndex=width*3*4;
            int count=0,dataCount=0;
            NSUInteger letter=0;
            NSMutableString *bin=[[NSMutableString alloc]init];
            NSMutableString *revbin=[[NSMutableString alloc] init];
            NSString *temp;
            for (int ii=0; ii<msgLength*8; ii++) {
                count++;
                [bin appendFormat:@"%d",(rawData[byteIndex]%2)];
                byteIndex++;
                dataCount++;
                if (count==8) {
                    temp=[btt reverseString:[bin substringWithRange:NSMakeRange(letter*9, 8)]];
                    [bin appendString:@" "];
                    [revbin appendFormat:@"%@ ",temp];
                    count=0;
                    byteIndex+=2;
                    dataCount=0;
                    letter++;
                }
                if (dataCount==3) {
                    byteIndex++;
                    dataCount=0;
                }
            }
            //NSLog(@"%@",revbin);
            NSString *bin1=[NSString stringWithString:revbin];
            
            NSString *result1=[btt BinaryToAsciiString:bin1];
            //NSLog(@"%@",result);
            NSString *result=[result1 AES256DecryptWithKey:key];
            hiddenMessage.text=result;
        }
        
    }
        /**/
        
        free(rawData);

    }
}

- (IBAction)goHome:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)copyToClipboard:(id)sender
{
    
    UIPasteboard *pt=[UIPasteboard generalPasteboard];
    [pt setString:hiddenMessage.text];
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Copied to clip board" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
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
@end
