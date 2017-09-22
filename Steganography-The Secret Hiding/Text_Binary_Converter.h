//
//  Text_Binary_Converter.h
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 03/01/14.
//  Copyright (c) 2014 Rohan Tondulkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Text_Binary_Converter : NSObject
-(NSString *) BinaryToAsciiString: (NSString *)string;
-(NSString*) stringFromBinString:(NSString*) binString;
-(NSString *)stringOfBinaryNumbers:(char) c;
-(void)integerToBinary:(unsigned long)val andArray:(int[])b andPower:(int)power;
-(int)binaryToInteger:(int[])size andPower:(int)power;
-(NSString *)reverseString:(NSString *)org;
-(unsigned long)setLimitWithWidth:(unsigned long)width andHeight:(unsigned long)height;
-(int)getPower:(unsigned long)limit;
@end
