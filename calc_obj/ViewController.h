//
//  ViewController.h
//  calc_obj
//
//  Created by adminaccount on 8/26/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (nonatomic, strong) NSString *bufString;
@property (nonatomic, strong) NSString *currentString;
@property (nonatomic, assign) int isEqallPut;
@property (nonatomic, assign) NSInteger saveCodeOp;


- (IBAction)test:(id)sender;
- (IBAction)operate:(UIButton *)sender;
- (IBAction)cleanAll:(id)sender;
- (IBAction)equal:(id)sender;
- (IBAction)operateUn:(id)sender;

@end

