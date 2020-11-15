//
//  BHURLPageRouter.m
//  BeeHive
//
//  Created by Water on 2020/11/14.
//

#import "BHPageURLRouter.h"
#import "BHPageURLRouteHoldProtocol.h"
#import "BHPageURLRoutePushProtocol.h"

NSString * const BHPageURLRouteMainNav = @"BHPageURLRouteMainNav";   //main nav
NSString * const BHPageURLRouteCurrentVC = @"BHPageURLRouteCurrentVC";;          //非VC跳转的则为无
NSString * const BHPageURLRouteUserParam = @"BHPageURLRouteUserParam";;               //参数
NSString * const BHPageURLRouteSystemParam = @"BHPageURLRouteSystemParam";;               //参数


NSString * const BHPageURLRouteSystemParamClass = @"_class";;        //_class
NSString * const BHPageURLRouteSystemParamMode = @"_mode";;         //_mode
NSString * const BHPageURLRouteSystemParamLogin = @"_login";;        //_login
NSString * const BHPageURLRouteSystemParamHold = @"_hold";;         //_hold

NSString * const BHPageURLRouteSystemParamModePush = @"push";;         //_mode,push
NSString * const BHPageURLRouteSystemParamModeModal = @"modal";;         //_mode,modal


static NSString *const kPlistName = @"BeeHive.bundle/BHURLRoute";


@interface NSURL (BHPageURLRoute)
- (NSDictionary *)queryDic;
@end


@interface BHPageURLRouter ()

@property (nonatomic, strong) NSString *scheme;
@property (nonatomic, strong) NSString *prefix;
@property (nonatomic, strong) NSString *suffix;
@property (nonatomic, weak, nullable) UINavigationController *mainNav;

@property (nonatomic, strong) NSDictionary *dicRoute;

@end

@implementation BHPageURLRouter

+ (instancetype)shareInstance{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [BHPageURLRouter new];
        [instance loadDefaultData];
        
    });
    return  instance;
}

- (void)loadDefaultData{
    [self loadPlist];
}

#pragma mark - Public
+ (void)registerScheme:(NSString *)scheme
                prefix:(NSString *)prefix
                suffix:(NSString *)suffix{
    [BHPageURLRouter shareInstance].scheme = scheme;
    [BHPageURLRouter shareInstance].prefix = prefix;
    [BHPageURLRouter shareInstance].suffix = suffix;
}

+ (void)registerMainNav:( UINavigationController * _Nullable )mainNav{
    [BHPageURLRouter shareInstance].mainNav = mainNav;
}


+ (void)routeWithURL:(NSURL *)URL{
    [BHPageURLRouter routeWithURL:URL
                          options:nil
                        currentVC:nil
                         callback:nil
                    completeblock:nil];
}


+ (void)routeWithURL:(NSURL *)URL
             options:(NSDictionary * _Nullable)options{
    [BHPageURLRouter routeWithURL:URL
                          options:options
                        currentVC:nil
                         callback:nil
                    completeblock:nil];
}

+ (void)routeWithURL:(NSURL *)URL
             options:(NSDictionary * _Nullable)options
           currentVC:(UIViewController * _Nullable)currentVC
            callback:(BHPageURLRouteCallback _Nullable)callback
       completeblock:(BHPageURLRouteCompleteBlock _Nullable)completeBlock{
    BHPageURLRouter *router = [BHPageURLRouter shareInstance];
//    if (![URL.scheme isEqual:router.scheme]) {
//        return;
//    }
    
    UINavigationController *nav = currentVC.navigationController ?: router.mainNav;
    currentVC = currentVC?: router.mainNav.viewControllers.lastObject;
    
    NSDictionary *configDic = router.dicRoute[URL.host][[URL.path substringWithRange:NSMakeRange(1, URL.path.length - 1)]];
    NSDictionary *queryDic = URL.queryDic;
    
    NSString *_class = configDic[BHPageURLRouteSystemParamClass];
    NSString *_hold = configDic[BHPageURLRouteSystemParamHold];
    NSMutableDictionary *resultDic = [NSMutableDictionary new];
    [resultDic addEntriesFromDictionary:configDic];
    [resultDic addEntriesFromDictionary:queryDic];
    
    if (_class.length > 0) {
        UIViewController *nextVC = [(UIViewController *)[NSClassFromString(_class) alloc] initWithNibName:_class bundle:[NSBundle mainBundle]];
        NSString *_mode = configDic[BHPageURLRouteSystemParamMode];
        if ([_mode isEqualToString:BHPageURLRouteSystemParamModeModal]) {
            [currentVC presentViewController:nextVC animated:YES completion:^{
                if (completeBlock) {
                    completeBlock(YES,resultDic);
                }
            }];
        }else{
            [nav pushViewController:nextVC animated:YES];
            if (completeBlock) {
                completeBlock(YES,resultDic);
            }
        }
    }else if(_hold.length > 0){
        Class holdClass = NSClassFromString(_hold);
        if (holdClass) {
            NSMutableDictionary *object = [NSMutableDictionary new];
            [object setValue:nav forKey:BHPageURLRouteMainNav];
            [object setValue:currentVC forKey:BHPageURLRouteCurrentVC];
            [object setValue:queryDic forKey:BHPageURLRouteUserParam];
            [object setValue:configDic forKey:BHPageURLRouteSystemParam];
            [[holdClass new] performSelector:@selector(holdWithParameters:) withObject:object];
            if (completeBlock) {
                completeBlock(YES,resultDic);
            }
        }
    }
}

#pragma mark - Private

- (void)loadPlist{
    NSString *plistPath = [[NSBundle bundleForClass:[self class]] pathForResource:kPlistName ofType:@"plist"];
    if (!plistPath) {
        return;
    }
    self.dicRoute = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
}



@end


@implementation NSURL (BHPageURLRoute)

- (NSDictionary *)queryDic{
    NSDictionary *result = nil;
    if (self.query.length > 0) {
        NSArray *querys = [self.query componentsSeparatedByString:@"&"];
        NSMutableDictionary *tmp = [NSMutableDictionary new];
        [querys enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *keyValue = [obj componentsSeparatedByString:@"="];
            if (keyValue.count == 2) {
                [tmp setValue:keyValue.lastObject forKey:keyValue.firstObject];
            }
        }];
        
        if (tmp.allKeys.count > 0) {
            result = [NSDictionary dictionaryWithDictionary:tmp];
        }
    }
    
    return  result;
}

@end
