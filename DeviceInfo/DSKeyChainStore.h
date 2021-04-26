//
//  DSKeyChainStore.h
//  DBSonyControl
//
//  Created by 占益民 on 2020/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSKeyChainStore : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;
@end

NS_ASSUME_NONNULL_END
