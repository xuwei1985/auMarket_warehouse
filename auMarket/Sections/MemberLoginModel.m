
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
        self.parseDataClassType = [MemberLoginEntity class];
    }
    return self;
}

//普通登录
-(void)loginWithUsername:(NSString *)uname andPassword:(NSString *)upass{
    self.shortRequestAddress=[NSString stringWithFormat:@"v1/auth/login?uname=%@&upass=%@",uname,upass];
    self.params = @{};
    self.requestTag=1001;
    [self loadInner];
}


-(void)handleParsedData:(SPBaseEntity*)parsedData{
    if ([parsedData isKindOfClass:[MemberLoginEntity class]]) {
        self.entity = (MemberLoginEntity*)parsedData;
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

