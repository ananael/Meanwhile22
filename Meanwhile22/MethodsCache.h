//
//  MethodsCache.h
//  Meanwhile22
//
//  Created by Michael Hoffman on 8/21/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MethodsCache : NSObject

-(void)createButtonBorderWidth:(NSInteger)width color:(UIColor *)color forArray:(NSArray *)array;
-(void)createImageBorderWidth:(NSInteger)width color:(UIColor *)color forArray:(NSArray *)array;
-(void)createViewBorderWidth:(NSInteger)width color:(UIColor *)color forArray:(NSArray *)array;
-(UIColor*)colorWithHexString:(NSString*)hex alpha:(CGFloat)alpha;

@end
