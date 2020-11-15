//
//  BHPageURLRouterDefine.h
//  Pods
//
//  Created by Water on 2020/11/14.
//

#ifndef BHPageURLRouterDefine_h
#define BHPageURLRouterDefine_h

typedef void (^BHPageURLRouteCompleteBlock)(BOOL success, NSDictionary *options);   // BHPageURLRouteUserParam、BHPageURLRouteSystemParam 合并成的一个dic
typedef void (^BHPageURLRouteCallback)(NSDictionary *options);

extern NSString * const BHPageURLRouteMainNav;   //main nav
extern NSString * const BHPageURLRouteCurrentVC;          //非VC跳转的则为 BHPageURLRouteMainNav.lastobject
extern NSString * const BHPageURLRouteUserParam;                //URL query部分参数
extern NSString * const BHPageURLRouteSystemParam;              //参数, _class, _mode, _login, _hold

extern NSString * const BHPageURLRouteSystemParamClass;        //_class
extern NSString * const BHPageURLRouteSystemParamMode;         //_mode
extern NSString * const BHPageURLRouteSystemParamLogin;        //_login
extern NSString * const BHPageURLRouteSystemParamHold;         //_hold

extern NSString * const BHPageURLRouteSystemParamModePush;         //_mode,push
extern NSString * const BHPageURLRouteSystemParamModeModal;         //_mode,modal

#endif /* BHPageURLRouterDefine_h */
