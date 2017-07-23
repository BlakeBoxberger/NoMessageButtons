static NSUserDefaults *settings;
static int donationCount = 0;

static void nz9_prefChanged() {
  if (settings) {
    [settings release];
  }
  settings = [[NSUserDefaults  alloc] initWithSuiteName:@"com.neinzedd9.NoMessageButtons"];
  [settings registerDefaults:@{
      @"enableSwitch": @YES,
      @"arrowButtonSwitch": @YES,
			@"audioButtonSwitch": @YES,
			@"browserButtonSwitch": @YES,
			@"digitalTouchButtonSwitch": @YES,
			@"photoButtonSwitch": @YES,
  }];
}

static BOOL nz9_isTweakEnabled() {
  return [settings boolForKey:@"enableSwitch"];
}

static BOOL nz9_isArrowButtonEnabled() {
  return [settings boolForKey:@"arrowButtonSwitch"];
}

static BOOL nz9_isAudioButtonEnabled() {
  return [settings boolForKey:@"audioButtonSwitch"];
}

static BOOL nz9_isBrowserButtonEnabled() {
  return [settings boolForKey:@"browserButtonSwitch"];
}

static BOOL nz9_isDigitalTouchButtonEnabled() {
  return [settings boolForKey:@"digitalTouchButtonSwitch"];
}

static BOOL nz9_isPhotoButtonEnabled() {
  return [settings boolForKey:@"photoButtonSwitch"];
}

@interface CKEntryViewButton : UIButton
@end

@interface CKMessageEntryView : UIView <UIAlertViewDelegate>

@property (copy) CKEntryViewButton *arrowButton;
@property (copy) CKEntryViewButton *audioButton;
@property (copy) CKEntryViewButton *browserButton;
@property (copy) CKEntryViewButton *digitalTouchButton;
@property (copy) CKEntryViewButton *photoButton;
@property (copy) CKEntryViewButton *sendButton;

@end


%hook CKMessageEntryView

- (void)updateEntryView {
	%orig;
	if(![settings boolForKey: @"thankYouDisplayed"]) {
		if(donationCount >= 50) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enjoying my tweak, NoMessageButtons?" message:@"Please consider donating so I can continue to develop tweaks like this! \nAlso, be sure to check out my other tweaks in Cydia!\n-NeinZedd9 <3" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Donate", nil];
	    [alert show];
	    [alert release];
	    [settings setBool:YES forKey:@"thankYouDisplayed"];
		}
		else {
			donationCount++;
		}
  }

	if(nz9_isTweakEnabled()) {
		if(nz9_isArrowButtonEnabled()) {
			self.arrowButton.hidden = NO;
		}
		else {
			self.arrowButton.hidden = YES;
		}
		if(!nz9_isAudioButtonEnabled()) {
			self.audioButton.hidden = YES;
		}
		if(nz9_isBrowserButtonEnabled()) {
			self.browserButton.hidden = NO;
		}
		else {
			self.browserButton.hidden = YES;
		}
		if(nz9_isDigitalTouchButtonEnabled()) {
			self.digitalTouchButton.hidden = NO;
		}
		else {
			self.digitalTouchButton.hidden = YES;
		}
		if(nz9_isPhotoButtonEnabled()) {
			self.photoButton.hidden = NO;
		}
		else {
			self.photoButton.hidden = YES;
		}
	}
}

%new - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if (buttonIndex != [alertView cancelButtonIndex]) {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/neinzedd"]];
    }
}

%end


%ctor {
	settings = [[NSUserDefaults alloc] initWithSuiteName: @"com.neinzedd9.NoMessageButtons"];
  [settings registerDefaults:@{
    @"thankYouDisplayed": @NO
  }];
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)nz9_prefChanged, CFSTR("NZ9NoMessageButtonsPreferencesChangedNotification"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	%init;
	nz9_prefChanged();
}
