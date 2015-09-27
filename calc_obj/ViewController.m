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
@synthesize bufString;
@synthesize currentString;
@synthesize isEqallPut;
@synthesize saveCodeOp;

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
    
    if ([self.currentString  isEqual: @"0"])
    {
      self.currentString=@"";
    }
    self.isEqallPut = 0;
    self.bufString = [NSString stringWithFormat: @"%ld", (long)[sender tag]] ;
    self.currentString = [self.currentString stringByAppendingString: self.bufString];
    self.display.text = self.currentString;
   
    [digitOp putOperator1:self.currentString];
}

- (IBAction)putDot:(id)sender
{
    Calc_brain *digitOp = [Calc_brain SharedInstance];
    NSRange mayBeDot;
    NSString *dt = @".";
    
    mayBeDot = [self.currentString rangeOfString: dt];
    if (self.currentString.length == 0)
    {
        self.currentString = @"0";
    }
    
    if (mayBeDot.length == 0 )
    {
        self.currentString = [self.currentString stringByAppendingString: @"."];
        self.display.text = self.currentString;
        [digitOp putOperator1: self.currentString];
    }
}

- (IBAction)operate:(UIButton *)sender
{
    static NSString *operation =@"";
    NSInteger operInt;
    NSInteger nullo = 0;
    Calc_brain *digitOp = [Calc_brain SharedInstance];
    
    operation = [NSString stringWithFormat: @"%ld", (long)[sender tag]];
    operInt = [operation integerValue];
    if (digitOp.codeOperation != nullo)
    {
        [self equal:digitOp];
        digitOp.codeOperation = operInt;
    }
    else
    {
        digitOp.codeOperation = operInt;
    }
    
    self.bufString = @"";
    self.currentString = @"";
}

- (IBAction)equal:(id)sender
{
    double tt;
    NSString *operation = @" ", *elem;
    Calc_brain *digitOp = [Calc_brain SharedInstance];
    NSUInteger res, uno = 1;
    
    if ([self.currentString  isEqual: @""] && self.isEqallPut != 0)
    {
        self.currentString = display.text;
        [digitOp putOperator1:self.currentString];
    }
    
    switch (self.isEqallPut) {
        case 0:
            tt=[digitOp binaryOperation:digitOp.codeOperation];
            operation = [NSString stringWithFormat: @"%f",  tt];
            res = operation.length;
            while (res>uno)
            {
                elem = [operation substringWithRange:NSMakeRange(res-1,1)];
                NSRange mayBeDot;
                NSString *dt = @".";
                mayBeDot = [operation rangeOfString: dt];
                if (mayBeDot.length != 0)
                {
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
                else
                {
                    break;
                }
                
            }
            self.display.text = [NSString stringWithFormat: @"%@",operation];
            self.saveCodeOp = digitOp.codeOperation;
            self.isEqallPut = 1;
            break;
        case 1:
            if (digitOp.codeOperation != 0)
            {
                self.saveCodeOp = digitOp.codeOperation;
            }
            tt=[digitOp binaryOperation:self.saveCodeOp];
            operation = [NSString stringWithFormat: @"%f",  tt];
            res = operation.length;
            while (res>uno)
            {
                elem = [operation substringWithRange:NSMakeRange(res-1,1)];
                NSRange mayBeDot;
                NSString *dt = @".";
                mayBeDot = [operation rangeOfString: dt];
                if (mayBeDot.length != 0)
                {
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
                else
                {
                    break;
                }
            }
            display.text = [NSString stringWithFormat: @"%@",operation];
            break;
    }

    digitOp.codeOperation = 0;
    self.bufString = @"";
    self.currentString = @"";
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
    operation = [NSString stringWithFormat:@"%f", codeOp];

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
    
    self.display.text = [NSString stringWithFormat: @"%@",operation];
    self.bufString = @"";
    self.currentString = @"";

}

- (IBAction)backSpace:(id)sender
{
    Calc_brain *digitOp = [Calc_brain SharedInstance];
    
    if (self.currentString.length == 1)
    {
        self.currentString = @"0";
        self.display.text = self.currentString;
        [digitOp putOperator1: self.currentString];
    }
    
    if (self.currentString.length > 1 || [self.currentString isEqual:@""])
    {
        if ([self.currentString isEqual:@""])
        {
            self.currentString = self.display.text;
        }
        
        NSString * backSpaceString = [self.currentString substringToIndex: self.currentString.length-1];
        self.currentString = backSpaceString;
        self.display.text = self.currentString;
        [digitOp putOperator1: self.currentString];
        
    }
    
    
    
}

- (IBAction)cleanAll:(id)sender
{
    Calc_brain *digitOp = [Calc_brain SharedInstance];
    
    self.bufString = @"";
    self.currentString = @"";
    self.display.text = @"0";
    digitOp.codeOperation = 0;
    self.isEqallPut = 0;
}

@end
