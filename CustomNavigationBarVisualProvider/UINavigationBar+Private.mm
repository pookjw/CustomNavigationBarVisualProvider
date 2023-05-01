//
//  UINavigationBar+Private.mm
//  CustomNavigationBarVisualProvider
//
//  Created by Jinwoo Kim on 4/27/23.
//

#import "UINavigationBar+Private.hpp"
#import "CustomNavigationBarVisualProvider.hpp"
#import <objc/runtime.h>
#import <memory>

namespace UINavigationBar_Private {

static id (*original_visualProviderForNavigationBar)(id, SEL, id);

static id custom_visualProviderForNavigationBar(id self, SEL _cmd, id x2) {
    if ([x2 isKindOfClass:CustomNavigationBar.class]) {
        std::unique_ptr<CustomNavigationBarVisualProvider> provider (new CustomNavigationBarVisualProvider);
        return provider.get()->objectFromNavigationBar(x2);
//        return original_visualProviderForNavigationBar(self, _cmd, x2);
    } else {
        return original_visualProviderForNavigationBar(self, _cmd, x2);
    }
}

};

@implementation UINavigationBar (Private)

+ (void)load {
    Method method = class_getClassMethod(self, NSSelectorFromString(@"_visualProviderForNavigationBar:"));
    UINavigationBar_Private::original_visualProviderForNavigationBar = reinterpret_cast<id (*)(id, SEL, id)>(method_getImplementation(method));
    method_setImplementation(method, reinterpret_cast<IMP>(UINavigationBar_Private::custom_visualProviderForNavigationBar));
}

@end
