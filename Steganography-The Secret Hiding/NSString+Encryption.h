//
//  NSString+Encryption.h
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 11/01/14.
//  Copyright (c) 2014 Rohan Tondulkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encryption)
- (NSString *)AES256EncryptWithKey:(NSString *)key;
- (NSString *)AES256DecryptWithKey:(NSString *)key;
@end
