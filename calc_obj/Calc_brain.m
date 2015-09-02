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

@synthesize operator1 = _operator1;
@synthesize operator2 = _operator2;
@synthesize codeOperation = _codeOperation;

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
    
    if (_codeOperation == 0)
    {
        _operator1 = [[tmp stringByAppendingString: op1] doubleValue];
    }
    else
    {
        _operator2 = [[tmp2 stringByAppendingString: op1] doubleValue];
    }
}

- (double)binaryOperation:(NSInteger)codeOpBin
{
   
    switch (codeOpBin)
    {
        case 10:
            _operator1 += _operator2;
            break;
        case 20:
            _operator1 -= _operator2;
            break;
        case 30:
            _operator1 *= _operator2;
            break;
        case 40:
            _operator1 /= _operator2;
            break;
    }
    return _operator1;
}

- (double)unaryOperation:(NSInteger)codeOpUn
{
    double resultOp = 0.0;
    
    switch (codeOpUn)
    {
        case 50:
            if(_codeOperation == 0)
            {
                _operator1 *= -1;
                resultOp = _operator1;
            }
            else
            {
                _operator2 *= -1;
                resultOp = _operator2;
            }
            break;
        case 60:
            if(_codeOperation == 0)
            {
                _operator1 = sqrt(_operator1);
                resultOp = _operator1;
            }
            else
            {
                _operator2 = sqrt(_operator2);
                resultOp = _operator2;
            }
            break;
    }
    return resultOp;
}

@end

