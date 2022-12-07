#import "UptimeTVModule.h"

@implementation UptimeTVModule 

+(long long)buttonStyle {
    return 2;
}

-(id)contentViewController {
    
    self.buttonController = (TVSMButtonViewController*)[super contentViewController];
    [self.buttonController setStyle:2];
    packageFile = [[self bundle] pathForResource:@"Uptime" ofType:@"png"];
    theImage = [[UIImage imageWithContentsOfFile:packageFile] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.buttonController setImage:theImage];
    [self.buttonController setTitleText:@"System Uptime"];
    return self.buttonController;
}

-(void)handleAction {
   [self setUptimeText];
   [self showAlertToUser];
}

-(BOOL)dismissAfterAction {
    return FALSE;
}


-(void)showAlertToUser {
    NSString *deviceName = [[UIDevice currentDevice] name];

      UIAlertController *alert = [UIAlertController alertControllerWithTitle:deviceName
                               message:uptimeText
                               preferredStyle:UIAlertControllerStyleAlert];

   UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
   handler:nil];

[alert addAction:ok];
[self.buttonController presentViewController:alert animated:YES completion:nil];
}

// code from @mtac8's uptime iOS tweak

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
