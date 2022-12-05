#import "UptimeTVModule.h"

@implementation UptimeTVModule {
     NSTimer *_uptimeTimer;
}

+(long long)buttonStyle {
    return 2;
}

-(id)contentViewController {
    
    TVSMButtonViewController *buttonController = (TVSMButtonViewController*)[super contentViewController];
    [buttonController setStyle:2];
    packageFile = [[self bundle] pathForResource:@"Uptime" ofType:@"png"];
    theImage = [[UIImage imageWithContentsOfFile:packageFile] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [buttonController setImage:theImage];
    [buttonController setTitleText:@"System Uptime"];
    return buttonController;
}

-(void)handleAction {
    [self addTimer];
   // call the main view controller of the application so we can push the alert to the main view.
UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;


//then call the alert controller

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"System Uptime"
                               message:uptimeText
                               preferredStyle:UIAlertControllerStyleAlert];

   UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
   handler:^(UIAlertAction * action) {

    [self removeTimer];


    }];

[alert addAction:ok];
[vc presentViewController:alert animated:YES completion:nil];
}

-(BOOL)dismissAfterAction {
    return FALSE;
}

// code from @mtac8's uptime iOS tweak.
 -(void)addTimer {
    _uptimeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setUptimeText) userInfo:nil repeats:YES];
}
-(void)removeTimer {
    [_uptimeTimer invalidate];
    _uptimeTimer = nil;
}


-(time_t)getDeviceUptime {
    struct timeval boottime;
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);
    time_t now;
    time_t uptimeInterval = -1;
    (void)time(&now);
    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1 && boottime.tv_sec != 0) {
        uptimeInterval = now - boottime.tv_sec;
    }
    return uptimeInterval;
}

-(void)setUptimeText {
    time_t uptimeInterval = [self getDeviceUptime];

    long seconds = uptimeInterval % 60;
    long minutes = uptimeInterval / 60 % 60;
    long hours = uptimeInterval / 60 / 60 % 24;
    long days = uptimeInterval / 60 / 60 / 24;

    uptimeText = [NSString stringWithFormat:@"Current Uptime:\n"]; 
    if (days != 0) {
        uptimeText = [uptimeText stringByAppendingString:[NSString stringWithFormat:@"%ldd ", days]];
    }
    if (hours != 0) {
        uptimeText = [uptimeText stringByAppendingString:[NSString stringWithFormat:@"%ldh ", hours]];
    }
    if (minutes != 0) {
        uptimeText = [uptimeText stringByAppendingString:[NSString stringWithFormat:@"%ldm ", minutes]];
    }
    uptimeText = [uptimeText stringByAppendingString:[NSString stringWithFormat:@"%lds", seconds]];
}

@end
