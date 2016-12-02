//
//  ViewController.m
//  3DTouch
//
//  Created by vcube on 16/11/29.
//  Copyright © 2016年 vcube. All rights reserved.
//

#import "ViewController.h"
#import "PressureViewController.h"

#define STATUSBAR 20
#define NAV 64

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"主页";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataSource = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < 20; i++) {
        [_dataSource addObject:[NSString stringWithFormat:@"3DTouch %d",i]];
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV, kWidth, kHeight - NAV) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"3Dcell"];
    [self.view addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    static NSString *cellID = @"3Dcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"3Dcell" forIndexPath:indexPath];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"3Dcell" forIndexPath:indexPath];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        NSLog(@"可用3D Touch");
        //给cell注册3DTouch的peek(预览)和pop功能
        
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    } else {
        NSLog(@"3D Touch无效");
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld",indexPath.row);
    PressureViewController *pressure = [[PressureViewController alloc]init];
    pressure.peekStr = [NSString stringWithFormat:@"%@ 用力按压进入",_dataSource[indexPath.row]];
    [self.navigationController pushViewController:pressure animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

#pragma mark - UIViewControllerPreviewingDelegate
//peek（预览)
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{

    //获取按压的cell位置，[previewingContext sourceView]就是按压的那个视图
    NSIndexPath *indexPath = [_tableView indexPathForCell:(UITableViewCell *)[previewingContext     sourceView]];
    //预览界面
    PressureViewController *pressure = [[PressureViewController alloc]init];
    pressure.preferredContentSize = CGSizeMake(0.0f, 500.0f);
    pressure.peekStr = [NSString stringWithFormat:@"%@ 用力按压进入",_dataSource[indexPath.row]];
    
    //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 40);
    previewingContext.sourceRect = rect;
    
    return pressure;
}

//pop (用力按压进入)
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    [self showViewController:viewControllerToCommit sender:self];
}

 #pragma mark - Navigation


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
