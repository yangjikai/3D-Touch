//
//  PressureViewController.m
//  3DTouch
//
//  Created by vcube on 16/12/1.
//  Copyright © 2016年 vcube. All rights reserved.
//

#import "PressureViewController.h"

#define STATUSBAR 20
#define NAV 64

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface PressureViewController ()

@end

@implementation PressureViewController

-(UILabel *)peekLable {
    if (!_peekLable) {
        _peekLable = [[UILabel alloc]initWithFrame:CGRectMake(0, (kHeight - 40) / 2, kWidth, 40)];
        _peekLable.backgroundColor = [UIColor clearColor];
        _peekLable.textAlignment = NSTextAlignmentCenter;
        
    }
    return _peekLable;
}

-(UILabel *)pressureLable{
    if (!_pressureLable) {
        _pressureLable = [[UILabel alloc]initWithFrame:CGRectMake(10, kHeight - 100, 100, 60)];
        _pressureLable.backgroundColor = [UIColor redColor];
        //将label的userInteractionEnabled属性设置为YES
        _pressureLable.userInteractionEnabled = YES;
        _pressureLable.text = @"按压我试试";
        _pressureLable.tag = 1001;
        _pressureLable.textAlignment = NSTextAlignmentCenter;
        
        
    }
    return _pressureLable;
}

-(UILabel *)ForceLable{
    if (!_ForceLable) {
        _ForceLable = [[UILabel alloc]initWithFrame:CGRectMake((kWidth - 40) /2, kHeight - 100, 200, 40)];
        _ForceLable.backgroundColor = [UIColor blueColor];
        _ForceLable.textColor = [UIColor whiteColor];
        _ForceLable.tag = 1002;
        _ForceLable.textAlignment = NSTextAlignmentCenter;
    }
    return _ForceLable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.peekLable];
    [self.view addSubview:self.pressureLable];
    [self.view addSubview:self.ForceLable];
    _peekLable.text = self.peekStr;
}

//预览时候上滑的action
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"Action1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action1,UIPreviewActionStyleDefault");
    }];
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"Action1" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action2,UIPreviewActionStyleSelected");
    }];
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"Action1" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action3,UIPreviewActionStyleDestructive");
    }];
    
    NSArray *actionArray = @[action1,action2,action3];
    return actionArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSArray *touchArray = [touches allObjects];
    UITouch *touch = (UITouch *)[touchArray lastObject];
    
    if (touch.view.tag == 1001) {
        NSLog(@"Began压力 ＝ %f",touch.force);
        self.ForceLable.text = [NSString stringWithFormat:@"压力%f",touch.force];
        CGRect rect = self.ForceLable.frame;
        CGFloat height = (kHeight - 40) - touch.force * 100;
        rect.origin.y = height;
        self.ForceLable.frame = rect;
    }
    
}
//按住移动or压力值改变时的回调
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSArray *touchArray = [touches allObjects];
    UITouch *touch = (UITouch *)[touchArray lastObject];
    if (touch.view.tag == 1001) {
        NSLog(@"move 压力%f",touch.force);
        //压力值改变
        self.ForceLable.text = [NSString stringWithFormat:@"压力%f",touch.force];
        //frame的改变
        CGRect rect = self.ForceLable.frame;
        CGFloat height = (kHeight - 40) - touch.force * 100;
        rect.origin.y = height;
        self.ForceLable.frame = rect;
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSArray *arrayTouch = [touches allObjects];
    UITouch *touch = (UITouch *)[arrayTouch lastObject];
    if (touch.view.tag == 1001) {
        NSLog(@"end压力%f",touch.force);
        //压力值改变
        self.ForceLable.text = [NSString stringWithFormat:@"压力%f",touch.force];
        //frame的改变
        CGRect rect = self.ForceLable.frame;
        CGFloat height = (kHeight - 40) - touch.force * 100;
        rect.origin.y = height;
        self.ForceLable.frame = rect;
    }

}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSArray *arrayTouch = [touches allObjects];
    UITouch *touch = (UITouch *)[arrayTouch lastObject];
    if (touch.view.tag == 1001) {
        NSLog(@"end压力%f",touch.force);
        NSLog(@"压力所在的view的tag = %li",touch.view.tag);
        //压力值改变
        self.ForceLable.text = [NSString stringWithFormat:@"压力%f",touch.force];
        //frame的改变
        CGRect rect = self.ForceLable.frame;
        CGFloat height = (kHeight - 40) - touch.force * 100;
        rect.origin.y = height;
        self.ForceLable.frame = rect;
    }
}

@end
