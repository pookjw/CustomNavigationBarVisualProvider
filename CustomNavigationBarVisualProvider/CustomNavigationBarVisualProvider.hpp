//
//  CustomNavigationBarVisualProvider.hpp
//  CustomNavigationBarVisualProvider
//
//  Created by Jinwoo Kim on 4/27/23.
//

#import <UIKit/UIKit.h>
#import <optional>
#import "CustomNavigationBar.hpp"

NS_HEADER_AUDIT_BEGIN(nullability, sendability)

class CustomNavigationBarVisualProvider {
public:
    id objectFromNavigationBar(CustomNavigationBar *navigationBar);
    ~CustomNavigationBarVisualProvider();
private:
    static std::optional<Class> _objectClass;
    static Class objectClass();
    static id imp_initWithNavigationBar(id self, SEL _cmd, id x2);
    static void imp_prepare(id self, SEL _cmd);
    static void imp_teardown(id self, SEL _cmd);
    static CGSize imp_sizeThatFits(id self, SEL _cmd, CGSize x2);
    static BOOL imp_shouldUseHeightRangeFittingWidth(id self, SEL _cmd);
    static void imp_setBackButtonVisible_animated(id self, SEL _cmd, BOOL x2, BOOL x3);
    std::optional<id> _object; // assign
    UIButton *backButton;
};

NS_HEADER_AUDIT_END(nullability, sendability)
