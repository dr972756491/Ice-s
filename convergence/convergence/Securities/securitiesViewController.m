//
//  securitiesViewController.m
//  convergence
//
//  Created by admin on 2017/9/2.
//  Copyright © 2017年 adminadmineducation. All rights reserved.
//

#import "securitiesViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PurchaseTableViewController.h"
#import "securitiesModel.h"
@interface securitiesViewController ()
{
     NSInteger flag;
}
@property (weak, nonatomic) IBOutlet UIImageView *ExperienceImage;//图片
@property (weak, nonatomic) IBOutlet UILabel *securitiesnameLbl;//劵名

@property (weak, nonatomic) IBOutlet UILabel *shopnameLbl;//店名
@property (strong,nonatomic) UIActivityIndicatorView *aiv;//菊花
@property (weak, nonatomic) IBOutlet UILabel *unitpriceLbl;//现价
@property (weak, nonatomic) IBOutlet UILabel *originalpriceLbl;//原价
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;//店名
@property (weak, nonatomic) IBOutlet UIButton *addressButton;//地址
@property (weak, nonatomic) IBOutlet UIButton *cellbutton;//电话
- (IBAction)cellAction:(UIButton *)sender forEvent:(UIEvent *)event;//电话事件
@property (weak, nonatomic) IBOutlet UILabel *soldLbl;//已售
@property (weak, nonatomic) IBOutlet UILabel *appointmentLbl;//来电预约
@property (weak, nonatomic) IBOutlet UILabel *periodofvalidityLbl;//有效期
@property (weak, nonatomic) IBOutlet UILabel *UsetimeLbl;//使用时间
@property (weak, nonatomic) IBOutlet UILabel *UserulesLbl;//使用规则
@property (weak, nonatomic) IBOutlet UILabel *promptLbl;//温馨提示
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;//取消
- (IBAction)cancelAction:(UIButton *)sender forEvent:(UIEvent *)event;//取消事件
@property (weak, nonatomic) IBOutlet UIButton *phonebutton;//电话
- (IBAction)phoneAction:(UIButton *)sender forEvent:(UIEvent *)event;//电话事件
@property (weak, nonatomic) IBOutlet UIView *laview;
@property (weak, nonatomic) IBOutlet UILabel *endLbl;
@property(nonatomic,strong)NSMutableArray *arr;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UIButton *PlaceBtn;
- (IBAction)PlaceAction:(UIButton *)sender forEvent:(UIEvent *)event;


@end

@implementation securitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self readyForEncoding];
    //设置导航条标题的颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //设置导航条是否隐藏
    self.navigationController.navigationBar.hidden = NO;
    //设置导航条上按钮的风格颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置是否需要毛玻璃效果
    self.navigationController.navigationBar.translucent = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)readyForEncoding{
    _aiv = [Utilities getCoverOnView:self.view];
    //开始请求
    NSString *request = @"/clubController/experienceDetail";
    NSDictionary *parmeters = @{@"experienceId":@53};
    
    [RequestAPI requestURL:request withParameters:parmeters andHeader:nil byMethod:kGet andSerializer:kJson success:^(id responseObject) {
        if ([responseObject[@"resultFlag"] integerValue] == 8001) {
            NSLog(@"responseObject = %@", responseObject);
            [_aiv stopAnimating];
            NSDictionary *result = responseObject[@"result"];
            
            _securitis= [[securitiesModel alloc]initWithDictionary:result];
            
            
            [self uilayout];
        }else{
            
        }
        
    } failure:^(NSInteger statusCode, NSError *error) {
        [_aiv stopAnimating];
        [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
    }];
}

-(void)uilayout{
    _periodofvalidityLbl.text = [NSString stringWithFormat:@"%@",_securitis.beginDate];
    _endLbl.text = [NSString stringWithFormat:@"%@",_securitis.endDate];
    _UsetimeLbl.text = [NSString stringWithFormat:@"%@",_securitis.useDate];
    _securitiesnameLbl.text = _securitis.name;
    _shopnameLbl.text = _securitis.yoganame;
    _UserulesLbl.text = _securitis.userules;
    _appointmentLbl.text = _securitis.eFeature;
    _addressLbl.text = _securitis.eAddress;
    _promptLbl.text = _securitis.ePromot;
    _soldLbl.text =[NSString stringWithFormat:@"%@",_securitis.sale];
    [_ExperienceImage sd_setImageWithURL:[NSURL URLWithString:_securitis.imageURl] placeholderImage:[UIImage imageNamed:@"image"]];
    _unitpriceLbl.text = [NSString stringWithFormat:@"%@元",_securitis.unitprice];
    _originalpriceLbl.text = [NSString stringWithFormat:@"%@元",_securitis.orginPrice];
    [_phonebutton  setTitle:[NSString stringWithFormat:@"%@",_securitis.phone] forState:UIControlStateNormal];
    //NSLog(@"22222=%@",_securitis.userules);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cellAction:(UIButton *)sender forEvent:(UIEvent *)event {
    _cancelButton.hidden = NO;
    _phonebutton.hidden = NO;
    _laview.hidden = NO;
}
- (IBAction)cancelAction:(UIButton *)sender forEvent:(UIEvent *)event {
    _cancelButton.hidden = YES;
    _phonebutton.hidden = YES;
    _laview.hidden = YES;
}
- (IBAction)phoneAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //配置“电话”app的路径并将要拨打的号码组合到路径中
    NSString *targetAppStr = [NSString stringWithFormat:@"telprompt://%@",_securitis.phone];
    
    //将字符串转换URl
    NSURL *targetAppUrl = [NSURL URLWithString:targetAppStr];
    
    //从当前app跳转到其他指定的app中
    [[UIApplication sharedApplication] openURL:targetAppUrl];

}
- (IBAction)PlaceAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //if ([Utilities loginCheck])
    PurchaseTableViewController *purchaseVC = [Utilities getStoryboardInstance:@"Securities" byIdentity:@"purchase"];
    purchaseVC.securitis = _securitis;
    [self.navigationController pushViewController:purchaseVC animated:YES];
    
    /*else{
     //获取要跳转过去的那个页面
     UINavigationController *signNavi = [Utilities getStoryboardInstance:@"" byIdentity:@""];
     //执行跳转
     [self presentViewController:signNavi animated:YES completion:nil];
     }*/

}
@end
