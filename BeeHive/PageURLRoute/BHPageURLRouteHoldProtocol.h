//
//  BHURLRouteHoldProtocol.h
//  BeeHive_Example
//
//  Created by Water on 2020/11/14.
//  Copyright © 2020 一渡. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@protocol BHPageURLRouteHoldProtocol <NSObject>

/**
 *  拦截URLRoute，自定义Hold
 *
 *  @param {
 *              BHRouteHoldParameter:xx,
 *              BHRouteHoldViewController:xx,
 *              BHRouteHoldNavigationController: xx
 *           }
 *
 *
 */
- (void)holdWithParameters:(NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END
