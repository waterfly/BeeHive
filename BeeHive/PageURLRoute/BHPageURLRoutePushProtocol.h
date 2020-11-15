//
//  BHPageURLRoutePushProtocol.h
//  BeeHive
//
//  Created by Water on 2020/11/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BHPageURLRoutePushProtocol <NSObject>

- (void)routeWillPushControllerWithParam:(NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END
