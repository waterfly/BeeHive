//
//  BHURLPageRouter.h
//  BeeHive
//
//  Created by Water on 2020/11/14.
//

#import <Foundation/Foundation.h>
#import "BHPageURLRouterDefine.h"

NS_ASSUME_NONNULL_BEGIN


@interface BHPageURLRouter : NSObject



+ (void)registerScheme:(NSString *)scheme
                prefix:(NSString *)prefix
                suffix:(NSString *)suffix;

+ (void)registerMainNav:(UINavigationController * _Nullable)mainNav;

////动态库注册plist
//+ (void)addRouteWithPlistPath:(NSString *)path;
//+ (void)addRouteWithPlistPaths:(NSArray *)paths;


+ (void)routeWithURL:(NSURL *)URL;


+ (void)routeWithURL:(NSURL *)URL
             options:(NSDictionary * _Nullable)options;


/// 路由跳转
/// @param URL 格式：scheme://项目/页面?key=value&key=value
/// @param options Reserved
/// @param currentVC 当前跳转的vc
/// @param callback 页面A跳转到页面B，页面B在返回前做的自定义处理。具体A与B定义，比如选择城市，选择后将结果塞到callback后返回
/// @param completeBlock 路由跳转完成后回调，一般用不到，Reserved
+ (void)routeWithURL:(NSURL *)URL
             options:(NSDictionary * _Nullable)options
           currentVC:(UIViewController * _Nullable)currentVC
            callback:(BHPageURLRouteCallback _Nullable)callback
       completeblock:(BHPageURLRouteCompleteBlock _Nullable)completeBlock;

@end

NS_ASSUME_NONNULL_END
