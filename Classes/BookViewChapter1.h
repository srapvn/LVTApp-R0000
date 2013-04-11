

#import <UIKit/UIKit.h>


@interface BookViewChapter1 : UIViewController {

	NSMutableArray *ListChapter;
	IBOutlet UISwitch *SwitchFullBar;
	IBOutlet UIToolbar *BottomBar;
	IBOutlet UITextView *TextView;

	
}

- (void) setListChapter:(NSMutableArray*) list;
- (void) changeTitle:(int) chapterid;
- (IBAction)SwitchFullscreen;

@end
