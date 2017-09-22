//
//  securitiesModel.h
//  convergence
//
//  Created by admin on 2017/9/4.
//  Copyright © 2017年 adminadmineducation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface securitiesModel : NSObject
@property (strong,nonatomic) NSString *name;//体验劵名称
@property (strong,nonatomic) NSString *yoganame;//瑜伽店名
@property (nonatomic) NSInteger experienceId;
@property (nonatomic) NSString *beginDate;//开始日期
@property (nonatomic) NSString *endDate;//结束日期
@property (nonatomic) NSString *useDate;//使用时间
@property (strong,nonatomic) NSString *userules;
@property (strong,nonatomic) NSString *imageURl;
@property (strong,nonatomic) NSString *eFeature;
@property (strong,nonatomic) NSString *eAddress;
@property (nonatomic) NSString *sale;
@property (strong,nonatomic) NSString *phone;//电话
@property (nonatomic) NSString *unitprice;//现价
@property (nonatomic) NSString *orginPrice;//原价
@property (nonatomic) NSString *ePromot;
@property (nonatomic) NSString *latitude;
@property (nonatomic) NSString *longitude;
@property (nonatomic) NSString *Presentprice;

- (id)initWithDictionary:(NSDictionary *)dict;
@end
