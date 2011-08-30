//
//  LionTableViewTestingAppDelegate.h
//  LionTableViewTesting
//
//  Created by Tomaž Kragelj on 8/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@interface LionTableViewTestingAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDelegate>

- (IBAction)itemsSizeClicked:(id)sender;

@property (nonatomic, assign) IBOutlet NSTableView *tableView;
@property (nonatomic, assign) IBOutlet NSWindow *window;

@end
