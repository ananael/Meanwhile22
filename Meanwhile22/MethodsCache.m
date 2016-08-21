//
//  MethodsCache.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 8/21/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import "MethodsCache.h"

@implementation MethodsCache

-(void)createButtonBorderWidth:(NSInteger)width color:(UIColor *)color forArray:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.layer.borderWidth = width;
        button.layer.borderColor = color.CGColor;
    }
}

-(void)createImageBorderWidth:(NSInteger)width color:(UIColor *)color forArray:(NSArray *)array
{
    for (UIImageView *image in array)
    {
        image.layer.borderWidth = width;
        image.layer.borderColor = color.CGColor;
    }
}

-(void)createViewBorderWidth:(NSInteger)width color:(UIColor *)color forArray:(NSArray *)array
{
    for (UIView *view in array)
    {
        view.layer.borderWidth = width;
        view.layer.borderColor = color.CGColor;
    }
}

-(UIColor*)colorWithHexString:(NSString*)hex alpha:(CGFloat)alpha
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}






@end
