//
//  PurchaseTableViewController.m
//  hotel
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 adminadmineducation. All rights reserved.
//

#import "PurchaseTableViewController.h"

@interface PurchaseTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (strong, nonatomic) IBOutlet NSArray *arr;
- (IBAction)Stepper:(UIStepper *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UILabel *numberofLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalpriceLbl;
@property (weak, nonatomic) IBOutlet UIStepper *Stepper;


@end

@implementation PurchaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    [self uiLayout];
    [self dataInitialize];
    [self setStepper:_Stepper];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(purchaseResultAction:) name:@"AlipayResult" object:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)naviConfig{
    //设置导航条标题文字
    self.navigationItem.title = @"体验劵支付";
    //设置导航条的颜色（风格颜色）
    //self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    //设置导航条标题的颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //设置导航条是否隐藏
    self.navigationController.navigationBar.hidden = NO;
    //设置导航条上按钮的风格颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置是否需要毛玻璃效果
    self.navigationController.navigationBar.translucent = YES;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"支付" style:UIBarButtonItemStylePlain target:self action:@selector(payAction)];
    self.navigationItem.rightBarButtonItem = right;

}
- (void)uiLayout{
    _nameLbl.text = _securitis.yoganame;
    _contentLbl.text = _securitis.name;
    _priceLbl.text = [NSString stringWithFormat:@"单价：%@元",_securitis.unitprice];
    _totalpriceLbl.text = [NSString stringWithFormat:@"%@元",_securitis.unitprice];
    self.tableView.tableFooterView = [UIView new];
    //将表格试图设置为”编辑中“
    self.tableView.editing = YES;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //有代码来选中表格视图中的某个细胞
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (void)dataInitialize{
    _arr = @[@"支付宝支付",@"微信支付",@"银联支付"];
    
    
    
}



- (void)payAction{
    switch (self.tableView.indexPathForSelectedRow.row) {
        case 0:{
            NSString *tradeNo = [GBAlipayManager generateTradeNO];
        [GBAlipayManager alipayWithProductName:_securitis.yoganame amount:_securitis.unitprice tradeNO:tradeNo notifyURL:nil productDescription:[NSString stringWithFormat:@"%@的活动报名费",_securitis.yoganame] itBPay:@"30"];
        }
            
            break;
            
        case 1:
            
            break;
            
        case 2:
            
            break;
            
            
        default:
            break;
    }
    
    [self Stepper];
    
}
-(void)purchaseResultAction:(NSNotification *)note{
    NSString *result = note.object;
    if ([result isEqualToString:@"9000"]) {
        //成功
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"支付成功" message:@"恭喜您，您成功完成报名" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertView addAction:okAction];
        [self presentViewController:alertView animated:YES completion:nil];
    }else{
        //失败
        [Utilities popUpAlertViewWithMsg:[result isEqualToString:@"4000"] ? @"未能成功支付，请确保账户余额充足":@"您已取消支付" andTitle:@"支付失败" onView:self];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _arr.count;
}

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}


//设置组的标题文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"支付方式";
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayCell" forIndexPath:indexPath];
    cell.textLabel.text = _arr[indexPath.row];
    return cell;
}


//设置每一组中每一行的细胞被点击以后要做的事情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //判断当前tableView是否为_activityTableView（这个条件判断常用在一个页面中有多个taleView的时候）
    //if ([tableView isEqual:_activityTableView]) {
    //取消选中
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //}
    //遍历表格视图中所有选中状态下的细胞
    for (NSIndexPath *eachIP in tableView.indexPathsForSelectedRows) {
        //当选中的细胞不是当前正在按得这个细胞的情况下
        if (eachIP != indexPath) {
            //将细胞从选中状态改为不选中状态
            [tableView deselectRowAtIndexPath:eachIP animated:YES];
        }
    }
    
}

- (void)setStepper:(UIStepper *)stepper {
    // 初始值
    stepper.value = 1;
    // 最大值
    stepper.maximumValue = 100;
    // 最小值
    stepper.minimumValue = 1;
    // 点击增减值
    stepper.stepValue = 1;
}
// 点击事件

- (IBAction)Stepper:(UIStepper *)sender forEvent:(UIEvent *)event {
    int i  = sender.value;
    NSInteger j = [_securitis.unitprice integerValue];
     _numberofLbl.text =[NSString stringWithFormat:@"%d",i];
    NSInteger n = _numberofLbl.text.integerValue;
    _totalpriceLbl.text = [NSString stringWithFormat:@"%ld 元",j*n];
    }

@end
