//
//  UIViewController+PageURLRouter.m
//  BeeHive
//
//  Created by Water on 2020/11/14.
//

#import "UIViewController+BHPageURLRouter.h"
#import <objc/runtime.h>
#import "BHPageURLRouter.h"

@implementation UIViewController (BHPageURLRouter)


- (void)routeWithURL:(NSURL *)URL{
    [BHPageURLRouter routeWithURL:URL
                          options:nil
                        currentVC:self
                         callback:nil
                    completeblock:nil];
}

- (void)routeWithURL:(NSURL *)URL
             options:(NSDictionary *)options{
    [BHPageURLRouter routeWithURL:URL
                          options:options
                        currentVC:self
                         callback:nil
                    completeblock:nil];
}

- (void)routeWithURL:(NSURL *)URL
             options:(NSDictionary *)options
            callback:(BHPageURLRouteCallback)callback
       completeblock:(BHPageURLRouteCompleteBlock)completeBlock{
    [BHPageURLRouter routeWithURL:URL
                          options:options
                        currentVC:self
                         callback:callback
                    completeblock:completeBlock];
}


- (BHPageURLRouteCallback)pageURLRouteCallback{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setPageURLRouteCallback:(BHPageURLRouteCallback)pageURLRouteCallback{
    objc_setAssociatedObject(self, @selector(pageURLRouteCallback), pageURLRouteCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
