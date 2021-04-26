//
//  DSDeviceInfo.h
//  DBSonyControl
//
//  Created by 占益民 on 2020/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSDeviceInfo : NSObject
//app 名称
+ (NSString *)getAppName;
//app 版本号
+ (NSString *)getAppVersion;
//app 版本号code  根据当前app_version 去掉点
+ (NSString *)getAppVersionCode;
//app Bulid
+ (NSString *)getAppBuild;
//获取bundleId
+ (NSString *)getBundleIdentifier;
// 手机别名：用户定义的名称
+ (NSString *)getUserPhoneName;
//手机系统版本
+ (NSString *)getSystemVersion;
//获取去设备型号
+ (NSString *)getDeviceName;
@end

NS_ASSUME_NONNULL_END
