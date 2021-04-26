//
//  DSUUID.m
//  DBSonyControl
//
//  Created by 占益民 on 2020/12/22.
//

#import "DSUUID.h"
#import <UIKit/UIKit.h>
#import "DSKeyChainStore.h"
#import <AdSupport/AdSupport.h>
@implementation DSUUID

+ (NSString *)getUUID {
    //获取项目的bundle ID
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    //将bundle ID作为唯一key在keychain里面获取保存的uuid
    NSString * strUUID = (NSString *)[DSKeyChainStore load:bundleId];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID){
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        //将该uuid保存到keychain
        [DSKeyChainStore save:bundleId data:strUUID];
    }
    return strUUID;
}

//已经被禁，现采用IDFV
+(NSString *)getUDID{
    return  [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}
//广告标识符
+(NSString *)getIDFA{
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return adId;
}
@end
