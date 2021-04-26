//
//  DSIPUtil.m
//  DBSonyControl
//
//  Created by 占益民 on 2020/12/22.
//

#import "DSIPUtil.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation DSIPUtil
/**
 获取ip 地址
 */
+ (NSString *)getIPAdress{
    NSString *address = @"";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    if (success == 0) { // 0 表示获取成功
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in  *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

/**
 判断网络类型
 */
//+ (NSString *)judgeNetType{

//    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi) {
//        return @"WIFI";
//    }else if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN) {
//        CTTelephonyNetworkInfo *networkStatus = [[CTTelephonyNetworkInfo alloc]init];  //创建一个CTTelephonyNetworkInfo对象
//        NSString *currentStatus  = networkStatus.currentRadioAccessTechnology; //获取当前网络描述
//        if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"] || [currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"] || [currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]) {
//            return @"2G";
//        }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"] || [currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"] || [currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"] || [currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"] || [currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"] || [currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"] || [currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]) {
//            return @"3G";
//        }else {
//            return @"4G";
//        }
//    }else {
//        return @"";
//    }
//}

/**
 获取mac 地址
 */
+ (NSString *)macaddress{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    //    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    NSLog(@"outString:%@", outstring);
    
    free(buf);
    
    return [outstring uppercaseString];
}
@end
