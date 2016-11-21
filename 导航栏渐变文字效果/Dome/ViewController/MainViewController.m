//
//  MainViewController.m
//  导航栏渐变文字效果
//
//  Created by chaofan on 2016/10/14.
//  Copyright © 2016年 chaofan. All rights reserved.
//

#import "MainViewController.h"
#import "UIView+Extension.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@interface MainViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UIImageView *headImv;
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UILabel *titLab;

@property (nonatomic,assign) CGFloat lastOffsetY;

@end

@implementation MainViewController

//lazy
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStylePlain];
        CGFloat headImvH = kScreenW / 320 * 300;
        //这句很重要
        _tableview.contentInset = UIEdgeInsetsMake(headImvH-20, 0, 0, 0);
        
        _tableview.dataSource = self;
        _tableview.delegate = self;
    }
    return _tableview;
}

-(UIImageView *)headImv
{
    if (!_headImv) {
        _headImv = [[UIImageView alloc]init];
        CGFloat headImvH = kScreenW / 320 * 300;
        _headImv.frame = CGRectMake(0, 0, kScreenW, headImvH);
        _headImv.image = [UIImage imageNamed:@"head"];
        //一定记住模式
        _headImv.contentMode = UIViewContentModeScaleAspectFill;
        _headImv.clipsToBounds = YES;
    }
    return _headImv;
}

-(UIView *)navView
{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 64)];
        _navView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
        _navView.clipsToBounds = YES;
        
        _titLab = [[UILabel alloc]init];
        _titLab.centerX = kScreenW * 0.5;
        _titLab.bounds = CGRectMake(0, 0, 150, 44);
        _titLab.textAlignment = NSTextAlignmentCenter;
        _titLab.font = [UIFont systemFontOfSize:12];
        _titLab.textColor = [UIColor blueColor];
        _titLab.numberOfLines = 0;
        _titLab.text = @"CF\n明天休息了";
        [_navView addSubview:_titLab];
        
        /**  毛玻璃特效类型
         *   UIBlurEffectStyleExtraLight,
         *   UIBlurEffectStyleLight,
         *   UIBlurEffectStyleDark
         */
//        //添加毛玻璃效果
//        UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//        //  毛玻璃视图
//        UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//        //添加到要有毛玻璃特效的控件中
//        effectView.frame = _navView.bounds;
//        [_navView addSubview:effectView];
//        //设置模糊透明度
//        effectView.alpha = 0.5f;
    }
    return _navView;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加顺序不能改变
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.headImv];
    [self.view addSubview:self.navView];
    [self setupNavView];
}

#pragma mark - 设置导航栏
-(void)setupNavView
{
    UIButton *leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNavBtn.frame = CGRectMake(0, 20, 64, 44);
    [leftNavBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftNavBtn addTarget:self action:@selector(leftNavClike) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftNavBtn];
    
    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavBtn.frame = CGRectMake(kScreenW-64, 20, 64, 44);
    [rightNavBtn setTitle:@"更多" forState:UIControlStateNormal];
    [rightNavBtn addTarget:self action:@selector(rightNavClike) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightNavBtn];
}

-(void)leftNavClike
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightNavClike
{
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据——%td",indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"测试数据——%td",indexPath.row];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //拿到偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    NSInteger headImvH = kScreenW / 320 * 300 ;
    CGFloat offset = headImvH + offsetY;//计算偏移量
    
    //设置导航栏
    self.navView.alpha = (offset / 250);
    if (self.navView.alpha >=1) {
        self.navView.alpha = 1;
    }
    //设置标题文字 设置距离
    //alpha 0-->1 y 64-->20
    self.titLab.y = 64 - 44 * self.navView.alpha;
    
    //设置头部图片大小
    self.headImv.frame = CGRectMake(0, 0, kScreenW, headImvH-offset);
}


@end
