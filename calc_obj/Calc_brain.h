//
//  Calc_brain.h
//  calc_obj
//
//  Created by adminaccount on 8/26/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

#ifndef calc_obj_Calc_brain_h
#define calc_obj_Calc_brain_h
@interface Calc_brain: NSObject

@property (nonatomic, assign) double operator1;
@property (nonatomic) double operator2;
@property (nonatomic) NSInteger codeOperation;

+ (Calc_brain*)SharedInstance;
- (void)putOperator1:(NSString *)op;
- (double)binaryOperation:(NSInteger)codeOpBin;
- (double)unaryOperation:(NSInteger)codeOpUn;

@end
#endif
