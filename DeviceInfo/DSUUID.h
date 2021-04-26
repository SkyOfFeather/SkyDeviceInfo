//
//  DSUUID.h
//  DBSonyControl
//
//  Created by 占益民 on 2020/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSUUID : NSObject
//UUID 保存在keyChain中 作为设备y唯一标识
+(NSString *)getUUID;
//已经被禁，现采用IDFV
+(NSString *)getUDID;
//广告标识符
+(NSString *)getIDFA;
@end

NS_ASSUME_NONNULL_END
