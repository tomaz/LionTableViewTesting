//
//  LionTableViewTestingAppDelegate.m
//  LionTableViewTesting
//
//  Created by Tomaž Kragelj on 8/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Item.h"
#import "ItemCellView.h"
#import "LionTableViewTestingAppDelegate.h"

@interface LionTableViewTestingAppDelegate ()

@property (nonatomic, readonly) NSArray *items;
@property (nonatomic, assign) BOOL isLargeSizeRequested;

@end

#pragma mark -

@implementation LionTableViewTestingAppDelegate

@synthesize tableView = _tableView;
@synthesize window = _window;
@synthesize items = _items;
@synthesize isLargeSizeRequested = _isLargeSizeRequested;

- (id)init {
	self = [super init];
	if (self) {
		_isLargeSizeRequested = YES;
	}
	return self;
}

#pragma mark - NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)note {
	// Nothing to do here for this simple app...
}

#pragma mark - NSTableViewDelegate

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
	return self.isLargeSizeRequested ? 34.0f : 20.0f;
}

#pragma mark - User actions

- (IBAction)itemsSizeClicked:(id)sender {
	// Get the state from the check box. We need to save it in a property, so that we can access it in table view delegate code.
	self.isLargeSizeRequested = ([sender state] == NSOnState);
	
	// Tell each cell view that it should change the size - this will make sure the cell view updates its contents accordingly.
	[self.tableView enumerateAvailableRowViewsUsingBlock:^(NSTableRowView *rowView, NSInteger row) {
		ItemCellView *cellView = [self.tableView viewAtColumn:0 row:row makeIfNecessary:NO];
		[cellView layoutViewsForLargeSize:self.isLargeSizeRequested animated:YES];
	}];
	
	// Notify the table view about the rows which size just changed - all in our case. This will call our delegate method where we will return desired row size.
	NSRange changedRange = NSMakeRange(0, self.tableView.numberOfRows);
	NSIndexSet *changedIndexes = [NSIndexSet indexSetWithIndexesInRange:changedRange];
	[self.tableView noteHeightOfRowsWithIndexesChanged:changedIndexes];
}

#pragma mark - Login items

- (NSArray *)items {
	if (_items) return _items;
	NSFileManager *manager = [NSFileManager defaultManager];
	NSArray *contents = [manager contentsOfDirectoryAtPath:@"/Applications" error:nil];
	NSMutableArray *items = [NSMutableArray arrayWithCapacity:[contents count]];
	[contents enumerateObjectsUsingBlock:^(NSString *filename, NSUInteger idx, BOOL *stop) {
		if ([filename hasPrefix:@"."]) return;
		Item *item = [[[Item alloc] init] autorelease];
		item.itemPath = [@"/Applications" stringByAppendingPathComponent:filename];
		[items addObject:item];
	}];
	_items = [items retain];
	return _items;
}
@end
