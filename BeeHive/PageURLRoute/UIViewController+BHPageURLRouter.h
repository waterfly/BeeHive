//
//  UIViewController+PageURLRouter.h
//  BeeHive
//
//  Created by Water on 2020/11/14.
//

#import <UIKit/UIKit.h>
#import "BHPageURLRouterDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BHPageURLRouter)

- (void)routeWithURL:(NSURL *)URL;

- (void)routeWithURL:(NSURL *)URL
             options:(NSDictionary *)options;

- (void)routeWithURL:(NSURL *)URL
             options:(NSDictionary *)options
            callback:(BHPageURLRouteCallback)callback
       completeblock:(BHPageURLRouteCompleteBlock)completeBlock;

@property (nonatomic, copy) BHPageURLRouteCallback pageURLRouteCallback;

@end

NS_ASSUME_NONNULL_END
