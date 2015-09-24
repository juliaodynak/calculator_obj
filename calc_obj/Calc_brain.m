//
//  Calc_brain.m
//  calc_obj
//
//  Created by adminaccount on 8/26/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calc_brain.h"
#import "ViewController.h"


@implementation Calc_brain

@synthesize operator1;
@synthesize operator2;
@synthesize codeOperation;

+ (Calc_brain*)SharedInstance
{
    static Calc_brain *ob;
    static dispatch_once_t predicat;
    
    dispatch_once(&predicat, ^{
        ob = [[Calc_brain alloc]init];
    });
    
    return ob;
}

- (void)putOperator1:(NSString*)op1
{
    NSString *tmp=@"", *tmp2=@"";
    
    if (self.codeOperation == 0)
    {
        self.operator1 = [[tmp stringByAppendingString: op1] doubleValue];
    }
    else
    {
        self.operator2 = [[tmp2 stringByAppendingString: op1] doubleValue];
    }
}

- (double)binaryOperation:(NSInteger)codeOpBin
{
   
    switch (codeOpBin)
    {
        case 10:
            self.operator1 += self.operator2;
            break;
        case 20:
            self.operator1 -= self.operator2;
            break;
        case 30:
            self.operator1 *= self.operator2;
            break;
        case 40:
            self.operator1 /= self.operator2;
            break;
    }
    return self.operator1;
}

- (double)unaryOperation:(NSInteger)codeOpUn
{
    double resultOp = 0.0;
    
    switch (codeOpUn)
    {
        case 50:
            if(self.codeOperation == 0)
            {
                self.operator1 *= -1;
                resultOp = self.operator1;
            }
            else
            {
                self.operator2 *= -1;
                resultOp = self.operator2;
            }
            break;
        case 60:
            if(self.codeOperation == 0)
            {
                self.operator1 = sqrt(self.operator1);
                resultOp = self.operator1;
            }
            else
            {
                self.operator2 = sqrt(self.operator2);
                resultOp = self.operator2;
            }
            break;
    }
    return resultOp;
}

@end

