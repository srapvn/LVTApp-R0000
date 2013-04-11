#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol ViewChapter1Delegate;

@interface ViewChapter1 : UIView /* Specify a superclass (eg: NSObject or NSView) */ {
    IBOutlet UITextView *TextChapter;
	IBOutlet UINavigationController *Bar;
	
	
	CGPoint position;
	UIFont *bookfont;
	int chapterid;
	CGFloat fontsize;
	int noChapter;
	BOOL flagRestoreMark;
	BOOL flagRestoreLastReading;
	
	id <ViewChapter1Delegate> delegate;

}

@property (nonatomic, assign) id <ViewChapter1Delegate> delegate;

- (IBAction)FontPlus;
- (IBAction)FontMinus;
- (IBAction)BookMark;
- (IBAction)RestoreMark;
- (IBAction)NextChapter;
- (IBAction)PreviousChapter;
- (IBAction)DelMark;


- (void) setText:(NSString*) Text;
- (void) setFile:(NSString*) Text;
- (void) setChapterid:(int) cid;
- (void) setNoChapter:(int) cid;
- (void) Gotothefirstline;
- (void) willRestoreMark;
- (void) checkRestoreMark;
- (void) restoreLastReading;
- (void) willRestoreLastReading;


//- (BOOL)writeApplicationPlist:(id)plist toFile:(NSString *)fileName;
//- (id)applicationPlistFromFile:(NSString *)fileName;

@end

@protocol ViewChapter1Delegate
- (void) changeTitle:(int) chapterid;
@end
