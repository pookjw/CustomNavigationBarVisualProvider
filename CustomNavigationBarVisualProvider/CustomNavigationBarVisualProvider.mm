//
//  CustomNavigationBarVisualProvider.mm
//  CustomNavigationBarVisualProvider
//
//  Created by Jinwoo Kim on 4/27/23.
//

#import "CustomNavigationBarVisualProvider.hpp"
#import <objc/message.h>

id CustomNavigationBarVisualProvider::objectFromNavigationBar(CustomNavigationBar *navigationBar) {
    if (this->_object != std::nullopt) {
        return this->_object.value();
    }
    
    this->_object = reinterpret_cast<id (*)(id, SEL, id)>(objc_msgSend)([CustomNavigationBarVisualProvider::objectClass() alloc], NSSelectorFromString(@"initWithNavigationBar:"), navigationBar);
    
    return [this->_object.value() autorelease];
}

CustomNavigationBarVisualProvider::~CustomNavigationBarVisualProvider() {
    [this->backButton release];
}

Class CustomNavigationBarVisualProvider::objectClass() {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (_objectClass != std::nullopt) return;
        
        _objectClass = objc_allocateClassPair(NSClassFromString(@"_UINavigationBarVisualProvider"), "CustomNavigationBarVisualProvider", 0);
        
        class_addIvar(
                      _objectClass.value(),
                      "_backButton", 
                      sizeof(UIButton *),
                      std::rint(std::log2(sizeof(UIButton *))),
                      @encode(UIButton *)
        );
        
        class_addMethod(
                        _objectClass.value(), 
                        NSSelectorFromString(@"initWithNavigationBar:"),
                        reinterpret_cast<IMP>(CustomNavigationBarVisualProvider::imp_initWithNavigationBar),
                        nil
                        );
        
        class_addMethod(
                        _objectClass.value(), 
                        NSSelectorFromString(@"prepare"),
                        reinterpret_cast<IMP>(CustomNavigationBarVisualProvider::imp_prepare),
                        nil
                        );
        
        class_addMethod(
                        _objectClass.value(), 
                        NSSelectorFromString(@"teardown"),
                        reinterpret_cast<IMP>(CustomNavigationBarVisualProvider::imp_teardown),
                        nil
                        );
        
        class_addMethod(
                        _objectClass.value(), 
                        NSSelectorFromString(@"shouldUseHeightRangeFittingWidth"),
                        reinterpret_cast<IMP>(CustomNavigationBarVisualProvider::imp_shouldUseHeightRangeFittingWidth),
                        nil
                        );
        
        class_addMethod(
                        _objectClass.value(), 
                        NSSelectorFromString(@"sizeThatFits:"),
                        reinterpret_cast<IMP>(CustomNavigationBarVisualProvider::imp_sizeThatFits),
                        nil
                        );
        
        class_addMethod(
                        _objectClass.value(), 
                        NSSelectorFromString(@"setBackButtonVisible:animated:"),
                        reinterpret_cast<IMP>(CustomNavigationBarVisualProvider::imp_setBackButtonVisible_animated),
                        nil
                        );
    });
    
    return _objectClass.value();
}

id CustomNavigationBarVisualProvider::imp_initWithNavigationBar(id self, SEL _cmd, id x2) {
    struct objc_super superInfo = { self, [self superclass] };
    self = reinterpret_cast<id (*)(struct objc_super *, SEL, id)>(objc_msgSendSuper)(&superInfo, _cmd, x2);
    
    return self;
}

void CustomNavigationBarVisualProvider::imp_prepare(id self, SEL _cmd) {
    struct objc_super superInfo = { self, [self superclass] };
    reinterpret_cast<void (*)(struct objc_super *, SEL)>(objc_msgSendSuper)(&superInfo, _cmd);
    
    CustomNavigationBar *navigationBar = reinterpret_cast<CustomNavigationBar * (*)(id, SEL)>(objc_msgSend)(self, NSSelectorFromString(@"navigationBar"));
    
    UIButtonConfiguration *configuration = [UIButtonConfiguration tintedButtonConfiguration];
    configuration.cornerStyle = UIButtonConfigurationCornerStyleCapsule;
    configuration.title = @"Back";
    configuration.image = [UIImage systemImageNamed:@"arrow.left"];
    
    __weak CustomNavigationBar *weakBar = navigationBar;
    UIAction *action = [UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
                        reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(weakBar, NSSelectorFromString(@"_sendNavigationPopForBackBarButtonItem:"), nil);
                        }];
    
    UIButton *backButton = [UIButton buttonWithConfiguration:configuration primaryAction:action];
    backButton.tintColor = UIColor.whiteColor;
    backButton.configuration = configuration;
    backButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [navigationBar addSubview:backButton];
    [NSLayoutConstraint activateConstraints:@[
                                              [backButton.topAnchor constraintEqualToAnchor:navigationBar.topAnchor],
                                              [backButton.leadingAnchor constraintEqualToAnchor:navigationBar.leadingAnchor],
                                              [backButton.trailingAnchor constraintEqualToAnchor:navigationBar.trailingAnchor],
                                              [backButton.bottomAnchor constraintEqualToAnchor:navigationBar.bottomAnchor]
                                              ]];
    
    object_setInstanceVariable(self, "_backButton", [backButton retain]);
}

void CustomNavigationBarVisualProvider::imp_teardown(id self, SEL _cmd) {
    struct objc_super superInfo = { self, [self superclass] };
    reinterpret_cast<void (*)(struct objc_super *, SEL)>(objc_msgSendSuper)(&superInfo, _cmd);
    
}

BOOL CustomNavigationBarVisualProvider::imp_shouldUseHeightRangeFittingWidth(id self, SEL _cmd) {
    return NO;
}

CGSize CustomNavigationBarVisualProvider::imp_sizeThatFits(id self, SEL _cmd, CGSize x2) {
    UIButton * _Nullable backButton = nil;
    object_getInstanceVariable(self, "_backButton", reinterpret_cast<void * _Nullable * _Nullable>(&backButton));
    return [backButton sizeThatFits:x2];
}


void CustomNavigationBarVisualProvider::imp_setBackButtonVisible_animated(id self, SEL _cmd, BOOL x2, BOOL x3) {
    struct objc_super superInfo = { self, [self superclass] };
    reinterpret_cast<void (*)(struct objc_super *, SEL, BOOL, BOOL)>(objc_msgSendSuper)(&superInfo, _cmd, x2, x3);
    
    UIButton * _Nullable backButton = nil;
    object_getInstanceVariable(self, "_backButton", reinterpret_cast<void * _Nullable * _Nullable>(&backButton));
    [backButton setHidden:!x2];
}

std::optional<Class> CustomNavigationBarVisualProvider::_objectClass = std::nullopt;
