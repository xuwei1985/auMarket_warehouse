//
//  MemberLoginEntity.h
//  auMarket
//
//  Created by 吴绪伟 on 2016/12/25.
//  Copyright © 2016年 daao. All rights reserved.
//

#import "SPBaseEntity.h"
@class MemberEntity;

@interface MemberLoginEntity : SPBaseEntity

@property(nonatomic,retain)MemberEntity *user;
@end


@interface MemberEntity : SPBaseEntity

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userheader;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *role_name;
@property (nonatomic, retain) NSArray *menu;
@end


