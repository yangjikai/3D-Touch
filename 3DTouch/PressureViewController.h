//
//  PressureViewController.h
//  3DTouch
//
//  Created by vcube on 16/12/1.
//  Copyright © 2016年 vcube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PressureViewController : UIViewController

//title
@property (nonatomic, strong) NSString *peekStr;
@property (nonatomic, strong) UILabel *peekLable;
//用来按压的label
@property (nonatomic, strong) UILabel *pressureLable;
//浮动的label
@property (nonatomic, strong) UILabel *ForceLable;

@end
