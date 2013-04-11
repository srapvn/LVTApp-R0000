
#import "BookViewChapter0.h"


@implementation BookViewChapter0

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationController.navigationBar.hidden = TRUE;
	//self.navigationController.navigationBar.hidden = TRUE;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.navigationController.navigationBar.hidden = TRUE;
	
}

- (IBAction)toList {
	
	[self.navigationController popViewControllerAnimated:YES];
	
}

- (IBAction)toChapter1 {

	NSString *path = [[NSBundle mainBundle] pathForResource:@"list" ofType:@"dat"];
	NSString *file = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	NSMutableArray *ListChapter = [file componentsSeparatedByString:@"\n"];
	[ListChapter retain];
	
		
	NSNumber *chapterid;
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *keychapter = [NSString stringWithFormat:@"LastReadingChapter"];
	chapterid = [prefs objectForKey:keychapter];
	
	int i;
	if (chapterid != nil) i = [chapterid intValue];
	else i = 1;
	
	BookViewChapter1 *chapter;
	chapter = [[BookViewChapter1 alloc] initWithNibName:@"BookViewChapter1" bundle:nil];
	[chapter setTitle:[ListChapter objectAtIndex:i]];
	[[chapter view] setChapterid:i];
	[[chapter view] setNoChapter:[ListChapter count]];
	NSString *name = [NSString stringWithFormat:@"%d",i];
	path = [[NSBundle mainBundle] pathForResource:name ofType:@"dat"];
	//[path retain];
	//NSLog(name);
	[[chapter view] setFile:path];
	[chapter setListChapter:ListChapter];
	
	[[chapter view] willRestoreLastReading];
	
	
	[self.navigationController pushViewController:chapter animated:YES];
	
	//[self.navigationController popViewControllerAnimated:YES];
	
}

- (IBAction) toBookmarks {
	
	BookViewBookmarks *chapter;
	
	chapter = [[BookViewBookmarks alloc] initWithNibName:@"BookViewBookmarks" bundle:nil];
	[chapter setTitle:@"Bookmarks"];

	//[path retain];
	//NSLog(name);	
	[self.navigationController pushViewController:chapter animated:YES];
	
	//[self.navigationController popViewControllerAnimated:YES];
	
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
