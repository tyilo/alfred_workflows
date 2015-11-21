#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

NSString *shellEscape(NSString *str) {
	str = [str stringByReplacingOccurrencesOfString:@"'" withString:@"'\\''"];
	str = [NSString stringWithFormat:@"'%@'", str];
	return str;
}

int main(int argc, char **argv) {
	
	@autoreleasepool {
		NSMutableArray *paths = [NSMutableArray new];

		NSPasteboard *pb = [NSPasteboard generalPasteboard];
		for(NSPasteboardItem *item in [pb pasteboardItems]) {
			NSString *url = [item stringForType:@"public.file-url"];
			NSString *path = [[NSURL URLWithString:url] path];
			if(path) {
				[paths addObject:path];
			}
		}

		if([paths count] == 0) {
			return 1;
		}
		
		for(int i = 0; i < [paths count]; i++) {
			if(i > 0) {
				printf(" ");
			}
			printf("%s", [shellEscape(paths[i]) UTF8String]);
		}
	}

	return 0;
}
