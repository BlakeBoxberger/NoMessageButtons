#include "NZMRootListController.h"

@implementation NZMRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}


+ (NSString *)hb_shareText {
	return @"I'm using #NoMessagesButtons by @NeinZedd9 to hide unwanted buttons in iMessage!";
}

+ (NSURL *)hb_shareURL {
	return [NSURL URLWithString:@"http://cydia.saurik.com/package/com.neinzedd9.nomessagebuttons/"];
}

@end
