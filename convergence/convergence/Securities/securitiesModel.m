//
//  securitiesModel.m
//  convergence
//
//  Created by admin on 2017/9/4.
//  Copyright © 2017年 adminadmineducation. All rights reserved.
//

#import "securitiesModel.h"

@implementation securitiesModel
-(id)initWithDictionary:(NSDictionary *)dict{
 
    self = [super init];
    if (self) {
        _experienceId = [[Utilities nullAndNilCheck:dict[@"eId"] replaceBy:@"0"] integerValue];
        _beginDate = [Utilities nullAndNilCheck:dict[@"beginDate"] replaceBy:@"0"];
        _endDate = [Utilities nullAndNilCheck:dict[@"endDate"] replaceBy:@"0"];
        _useDate = [Utilities nullAndNilCheck:dict[@"useDate"] replaceBy:@"0"];
        _userules = [Utilities nullAndNilCheck:dict[@"rules"] replaceBy:@"0"];
        _imageURl =[Utilities nullAndNilCheck:dict [@"eLogo"] replaceBy:@"eLogo"];
        //_imageURl = [Utilities nullAndNilCheck:@"eLogo" replaceBy:@"eLogo"];
        _sale = [Utilities nullAndNilCheck:dict[@"saleCount"] replaceBy:@"0"];
        _phone = [Utilities nullAndNilCheck:dict[@"clubTel"] replaceBy:@""];
        _unitprice = [Utilities nullAndNilCheck:dict[@"currentPrice"] replaceBy:@"0"];
        _orginPrice = [Utilities nullAndNilCheck:dict[@"orginPrice"] replaceBy:@"0"];
        _yoganame =[Utilities nullAndNilCheck:dict [@"eClubName"] replaceBy:@"暂无名称"];
        _name =[Utilities nullAndNilCheck:dict [@"eName"] replaceBy:@"暂无名称"];
        _eFeature =[Utilities nullAndNilCheck:dict [@"eFeature"] replaceBy:@"有无来电预约"];
        _eAddress =[Utilities nullAndNilCheck:dict [@"eAddress"] replaceBy:@"地址"];
        _ePromot =[Utilities nullAndNilCheck:dict [@"ePromot"] replaceBy:@"暂无"];
        _latitude =[Utilities nullAndNilCheck:dict [@"latitude"] replaceBy:@"0"];
        _longitude =[Utilities nullAndNilCheck:dict [@"longitude"] replaceBy:@"0"];
        _Presentprice = [Utilities nullAndNilCheck:dict[@"currentPrice"] replaceBy:@"0"];
    }
    return self;
}

@end
