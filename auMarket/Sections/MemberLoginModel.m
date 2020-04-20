
//
//  MemberLoginModel.m
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/25.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "MemberLoginModel.h"

@implementation MemberLoginModel

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//普通登录
-(void)loginWithUsername:(NSString *)uname andPassword:(NSString *)upass andMobile:(NSString *)mobile andCode:(NSString *)code{
    self.shortRequestAddress=[NSString stringWithFormat:@"v1/auth/login?uname=%@&upass=%@&mobile=%@&code=%@",uname,upass,mobile,code];
    self.parseDataClassType = [MemberLoginEntity class];
    self.params = @{};
    self.requestTag=1001;
    [self loadInner];
}


-(void)getVerifyMobiles{
    self.shortRequestAddress=[NSString stringWithFormat:@"v1/auth/login_verify_account"];
    self.parseDataClassType = [VerifyMobileListEntity class];
    self.params = @{
    };
    self.requestTag=1004;
    [self loadInner];
}

//校验短信验证码
-(void)getSmsCode:(NSString *)mobile{
    self.parseDataClassType = [OrderVerifyEntity class];
    self.shortRequestAddress=[NSString stringWithFormat:@"v1/auth/getSmsCodeForClient&mobile=%@",mobile];
    self.requestTag=1005;
    [self loadInner];
}


-(void)handleParsedData:(SPBaseEntity*)parsedData{
    if ([parsedData isKindOfClass:[MemberLoginEntity class]]) {
        self.entity = (MemberLoginEntity*)parsedData;
    }else if ([parsedData isKindOfClass:[VerifyMobileListEntity class]]) {
        self.verify_entity = (VerifyMobileListEntity*)parsedData;
    }
    else if ([parsedData isKindOfClass:[OrderVerifyEntity class]]) {
        self.sEntity = (OrderVerifyEntity*)parsedData;
    }
}

-(SPAccount *)convertToSpAccount:(MemberEntity*)mEntity{
    SPAccount *_account=[[SPAccount alloc] init];
    _account.user_id=mEntity.id;
    _account.user_account=mEntity.username;
    _account.user_nickname=mEntity.username;
    _account.user_mobile=mEntity.mobile;
    _account.user_token=mEntity.token;
    _account.user_pwd=mEntity.password;
    _account.role_name=mEntity.role_name;
    _account.menu=mEntity.menu;
    return _account;
}

-(MemberLoginEntity *)entity{
    if(!_entity){
        _entity=[[MemberLoginEntity alloc] init];
    }
    
    return _entity;
}

-(MemberChargeEntity *)charge_entity{
    if(!_charge_entity){
        _charge_entity=[[MemberChargeEntity alloc] init];
    }
    
    return _charge_entity;
}

@end

