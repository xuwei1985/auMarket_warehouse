//
//  PassValueDelegate.h
//  auMarket
//
//  Created by 吴绪伟 on 19/10/2017.
//  Copyright © 2017 daao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PassValueDelegate <NSObject>

@optional
-(void)passStringValue:(NSString *)str;
-(void)passNumberValue:(NSNumber *)num;
-(void)passObject:(id)obj;
@end
