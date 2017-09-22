//
//  Text_Binary_Converter.m
//  Steganography-The Secret Hiding
//
//  Created by Rashmi Tondulkar on 03/01/14.
//  Copyright (c) 2014 Rohan Tondulkar. All rights reserved.
//

#import "Text_Binary_Converter.h"
#import <Foundation/Foundation.h>

@implementation Text_Binary_Converter

-(NSString *)BinaryToAsciiString:(NSString *)string
{
    NSMutableString *result = [NSMutableString string];
    const char *b_str = [string cStringUsingEncoding:NSASCIIStringEncoding];
    char c;
    int i = 0; /* index, used for iterating on the string */
    int p = 7; /* power index, iterating over a byte, 2^p */
    int d = 0; /* the result character */
    while ((c = b_str[i])) { /* get a char */
        if (c == ' ') { /* if it's a space, save the char + reset indexes */
            [result appendFormat:@"%c", d];
            p = 7; d = 0;
        } else { /* else add its value to d and decrement
                  * p for the next iteration */
            if (c == '1') d += pow(2, p);
            --p;
        }
        //NSLog(@"%@",result);
        ++i;
    } [result appendFormat:@"%c", d]; /* this saves the last byte */
    
    return [NSString stringWithString:result];
}

-(NSString *)stringFromBinString:(NSString *)binString
{
    NSArray *tokens = [binString componentsSeparatedByString:@" "];
    char *chars = malloc(sizeof(char) * ([tokens count] + 1));
    
    for (int i = 0; i < [tokens count]; i++) {
        const char *token_c = [[tokens objectAtIndex:i] cStringUsingEncoding:NSUTF8StringEncoding];
        char val = (char)strtol(token_c, NULL, 2);
        chars[i] = val;
    }
    chars[[tokens count]] = 0;
    NSString *result = [NSString stringWithCString:chars
                                          encoding:NSUTF8StringEncoding];
    
    free(chars);
    return result;
}

-(NSString *)stringOfBinaryNumbers:(char)c
{
    int val=c;
    NSMutableString* result = [[NSMutableString alloc]init];
    NSMutableString *reverse=[[NSMutableString alloc]init];
    /*size_t i;
     //for (i=0; i < CHAR_BIT * sizeof val; i++) {
     for(i=0;i<8;i++){
     int theBit = (val >> i) & 1;
     [result addObject:[NSNumber numberWithInt:theBit]];
     
     }*/
    int temp,i=9;
    NSUInteger t;
    while (val>0) {
        temp=val%2;
        val=val/2;
        //NSLog(@"%d",temp);
        [result appendString:[NSString stringWithFormat:@"%d",temp]];
        
        i--;
    }
    for (int j=0; j<8-result.length; j++) {
        [result appendString:@"0"];
    }
    for (int j=7; j>=0; j--) {
        t=j;
        [reverse appendString:[NSString stringWithFormat:@"%C",[result characterAtIndex:t]]];
    }
    return [NSString stringWithString:reverse];
}
-(void)integerToBinary:(unsigned long)val andArray:(int[])b andPower:(int)power
{
    int temp;
    int count=0;
    while (val>0) {
        temp=val%2;
        val=val/2;
        b[count]=temp;
        count++;
    }
    int t1=count;
    for (int j=0; j<power-t1; j++)
    {
        b[count]=0;
        count++;
    }
}

-(int)binaryToInteger:(int [])size andPower:(int)power
{
    int result=0;
    for (int i=0; i<power; i++) {
        result=result+size[i]*pow(2, i);
    }
    return result;	
}
-(NSString *)reverseString:(NSString *)org
{
    NSMutableString *rev=[[NSMutableString alloc]init];
    NSUInteger j;
    for (long i=org.length-1; i >=0; i--) {
        j=i;
        [rev appendFormat:@"%C",[org characterAtIndex:j]];
    }
    return [NSString stringWithString:rev];
}

-(unsigned long)setLimitWithWidth:(unsigned long)width andHeight:(unsigned long)height
{
    unsigned long limit=0;
    unsigned long temp=height/2 - 3;
    limit=width*temp*3/8;
    return limit;
}

-(int)getPower:(unsigned long)limit
{
    int power=0;
    for (int i=0; i<70; i++) {
        if (powf(2.0, i)>limit) {
            power=i-1;
            break;
        }
    }
    return power;
}
@end
