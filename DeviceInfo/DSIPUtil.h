//
//  DSIPUtil.h
//  DBSonyControl
//
//  Created by 占益民 on 2020/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSIPUtil : NSObject
/**
 获取ip 地址
 */
+ (NSString *)getIPAdress;

/**
 判断网络类型
 */
//+ (NSString *)judgeNetType;

/**
 获取mac 地址
 */
+ (NSString *)macaddress;
@end

NS_ASSUME_NONNULL_END
