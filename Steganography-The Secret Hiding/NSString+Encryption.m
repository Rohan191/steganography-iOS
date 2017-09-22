//
//  NSString+Encryption.m
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 11/01/14.
//  Copyright (c) 2014 Rohan Tondulkar. All rights reserved.
//

#import "NSString+Encryption.h"
#import "NSData+Encryption.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (Encryption)
- (NSString *)AES256EncryptWithKey:(NSString *)key
{
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [plainData AES256EncryptWithKey:key];
    
    NSString *encryptedString = [encryptedData base64Encoding];
    
    return encryptedString;
}

- (NSString *)AES256DecryptWithKey:(NSString *)key
{
    NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
    NSData *plainData = [encryptedData AES256DecryptWithKey:key];
    
    NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    
    return plainString;
}

@end
