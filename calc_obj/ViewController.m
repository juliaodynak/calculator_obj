//
//  ViewController.m
//  calc_obj
//
//  Created by adminaccount on 8/26/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import "ViewController.h"
#import "Calc_brain.h"
@interface ViewController ()

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *constraintA;

@end


@implementation ViewController

@synthesize display;
@synthesize bufString = _bufString;
@synthesize currentString = _currentString;
@synthesize isEqallPut = _isEqallPut;
@synthesize saveCodeOp = _saveCodeOp;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bufString = @"";
    self.currentString = @"";
    self.isEqallPut = 0;
    self.saveCodeOp = 0;
}

- (IBAction)test:(id)sender
{
    Calc_brain *digitOp = [Calc_brain SharedInstance];
    
    if ([_currentString  isEqual: @"0"])
    {
      _currentString=@"";  
    }
    _isEqallPut = 0;
    _bufString = [NSString stringWithFormat: @"%ld", (long)[sender tag]] ;
    _currentString = [_currentString stringByAppendingString: _bufString];
    display.text = _currentString;
   
    [digitOp putOperator1:_currentString];
}

- (IBAction)putDot:(id)sender
{
    Calc_brain *digitOp = [Calc_brain SharedInstance];
    NSRange mayBeDot;
    NSString *dt = @".";
    
    mayBeDot = [_currentString rangeOfString: dt];
    if (_currentString.length == 0)
    {
        _currentString = @"0";
    }
    
    if (mayBeDot.length == 0 )
    {
        _currentString = [_currentString stringByAppendingString: @"."];
        display.text = _currentString;
        [digitOp putOperator1: _currentString];
    }
}

- (IBAction)operate:(UIButton *)sender
{
    static NSString *operation =@"";
    NSInteger operInt;
    Calc_brain *digitOp = [Calc_brain SharedInstance];
    
    operation = [NSString stringWithFormat: @"%ld", (long)[sender tag]];
    operInt = [operation integerValue];
    digitOp.codeOperation = operInt;
    
    _bufString = @"";
    _currentString = @"";
}

- (IBAction)equal:(id)sender
{
    double tt;
    NSString *operation = @" ", *elem;
    Calc_brain *digitOp = [Calc_brain SharedInstance];
    NSUInteger res, uno = 1;
    
    if ([_currentString  isEqual: @""] && _isEqallPut != 0)
    {
        _currentString = display.text;
        [digitOp putOperator1:_currentString];
    }
    
    switch (_isEqallPut) {
        case 0:
            tt=[digitOp binaryOperation:digitOp.codeOperation];
            operation = [NSString stringWithFormat: @"%f",  tt];
            res = operation.length;
            while (res>uno) {
                elem = [operation substringWithRange:NSMakeRange(res-1,1)];
                if ([elem isEqualToString:@"0"] || [elem isEqualToString:@"."])
                {
                    operation = [operation substringToIndex:res-1];
                }
                else
                {
                    break;
                }
                res = res - 1;
            }
            display.text = [NSString stringWithFormat: @"%@",operation];
            _saveCodeOp = digitOp.codeOperation;
            _isEqallPut = 1;
            break;
        case 1:
            if (digitOp.codeOperation != 0)
            {
                _saveCodeOp = digitOp.codeOperation;
            }
            tt=[digitOp binaryOperation:_saveCodeOp];
            operation = [NSString stringWithFormat: @"%f",  tt];
            res = operation.length;
            while (res>uno) {
                elem = [operation substringWithRange:NSMakeRange(res-1,1)];
                if ([elem isEqualToString:@"0"] || [elem isEqualToString:@"."])
                {
                    operation = [operation substringToIndex:res-1];
                }
                else
                {
                    break;
                }
                res = res - 1;
            }
            display.text = [NSString stringWithFormat: @"%@",operation];
            break;
    }

    digitOp.codeOperation = 0;
    _bufString = @"";
    _currentString = @"";
    //hpu8ip[ij[
}

- (IBAction)operateUn:(id)sender
{
    static NSString *operation = @"", *elem = @"";
    NSInteger operInt;
    double codeOp;
    NSUInteger res, uno = 1;
    Calc_brain *digitOp = [Calc_brain SharedInstance];
    
    operation = [NSString stringWithFormat: @"%ld", (long)[sender tag]];
    operInt = [operation integerValue];
    codeOp = [digitOp unaryOperation:operInt];

    res = operation.length;
    while (res>uno) {
        elem = [operation substringWithRange:NSMakeRange(res-1,1)];
        if ([elem isEqualToString:@"0"] || [elem isEqualToString:@"."])
        {
            operation = [operation substringToIndex:res-1];
        }
        else
        {
            break;
        }
        res = res - 1;
    }
    
    display.text = [NSString stringWithFormat: @"%@",operation];
    _bufString = @"";
    _currentString = @"";

}

- (IBAction)backSpace:(id)sender
{
    Calc_brain *digitOp = [Calc_brain SharedInstance];
    
    if (_currentString.length == 1)
    {
        _currentString = @"0";
        display.text = _currentString;
        [digitOp putOperator1: _currentString];
    }
    
    if (_currentString.length > 1 || [_currentString isEqual:@""])
    {
        if ([_currentString isEqual:@""])
        {
            _currentString = display.text;
        }
        
        NSString * backSpaceString = [_currentString substringToIndex: _currentString.length-1];
        _currentString = backSpaceString;
        display.text = _currentString;
        [digitOp putOperator1: _currentString];
        
    }
    
    
    
}

- (IBAction)cleanAll:(id)sender
{
    Calc_brain *digitOp = [Calc_brain SharedInstance];
    
    _bufString = @"";
    _currentString = @"";
    display.text = @"0";
    digitOp.codeOperation = 0;
    _isEqallPut = 0;
}

@end
