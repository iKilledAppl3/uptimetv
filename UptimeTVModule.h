#import <UIKit/UIKit.h>
#import <TVSystemMenuUI/TVSMModuleContentViewControllerDelegate.h>
#import <TVSystemMenuUI/TVSMModuleContentViewController.h>
#import <TVSystemMenuUI/TVSMActionModule.h>
#import <TVSystemMenuUI/TVSMButtonViewController.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <sys/utsname.h>
#include <sys/sysctl.h> 

@interface UptimeTVModule : TVSMActionModule {
	 NSString *uptimeText;
	 NSString *packageFile;
     UIImage *theImage;
     TVSMButtonViewController *_buttonController;
}
@property (retain, nonatomic) TVSMButtonViewController *buttonController;
+(long long)buttonStyle;
-(id)contentViewController;
-(void)handleAction;
-(BOOL)dismissAfterAction;
-(void)showAlertToUser;
@end

