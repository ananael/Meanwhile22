//
//  TimeVortexGameViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/30/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "TimeVortexGameViewController.h"
#import "VortexComicQuestions.h"
#import "VortexMovieQuestions.h"
#import "VortexTvQuestions.h"
#import "VortexGameQuestions.h"

@interface TimeVortexGameViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIView *overlayContainer;
@property (weak, nonatomic) IBOutlet UIImageView *overlayFinalImage;
@property (weak, nonatomic) IBOutlet UIImageView *overlayImage;
@property (weak, nonatomic) IBOutlet UIView *resultContainer;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *correctLabel;
@property (weak, nonatomic) IBOutlet UILabel *wrongLabel;
@property (weak, nonatomic) IBOutlet UIView *startContainer;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UIView *overlayButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *playAgainButton;
@property (weak, nonatomic) IBOutlet UIButton *nextCategoryButton;

@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *quitButton;

@property (weak, nonatomic) IBOutlet UIView *middleContainer;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomContainer;
@property (weak, nonatomic) IBOutlet UIButton *answer1Button;
@property (weak, nonatomic) IBOutlet UIButton *answer2Button;
@property (weak, nonatomic) IBOutlet UIButton *answer3Button;
@property (weak, nonatomic) IBOutlet UIButton *answer4Button;

@property NSTimer *openingTimer;
@property NSInteger openingSeconds;

@property NSTimer *gameTimer;
@property NSInteger gameSeconds;

@property NSInteger scoreNumber;
@property NSInteger wrongNumber;

//The "Answer" BOOLs work by setting the correct anser to "Yes"
//And the others will default to "No", once enabled as "No" in ViewDidLoad
@property BOOL Answer1Correct;
@property BOOL Answer2Correct;
@property BOOL Answer3Correct;
@property BOOL Answer4Correct;

//@property NSMutableArray *questionArray;
//@property NSMutableArray *usedQuestionArray;
@property NSMutableArray *comicsArray;
@property NSMutableArray *usedComicsArray;
@property NSMutableArray *moviesArray;
@property NSMutableArray *usedMoviesArray;
@property NSMutableArray *tvArray;
@property NSMutableArray *usedTVArray;
@property NSMutableArray *gamesArray;
@property NSMutableArray *usedGamesArray;

@property NSInteger randomIndex;
@property NSInteger categoryLoaded;

- (IBAction)quitTapped:(id)sender;
- (IBAction)answer1Tapped:(id)sender;
- (IBAction)answer2Tapped:(id)sender;
- (IBAction)answer3Tapped:(id)sender;
- (IBAction)answer4Tapped:(id)sender;
- (IBAction)playAgainTapped:(id)sender;
- (IBAction)nextCategoryTapped:(id)sender;


@end

@implementation TimeVortexGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImage.image = [UIImage imageNamed:@"vortex background"];
    self.topContainer.backgroundColor = [UIColor clearColor];
    
    self.middleContainer.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    
    [self questionBorders];
    
    [self buttonBackgroundColor:[self buttonArray]];
    [self createButtonBorderWidth:1.0 forArray:[self buttonArray]];
    [self buttonCornerRadius:8.0 forArray:[self buttonArray]];
    [self centerButtonText:[self buttonArray]];
    
    self.quitButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    self.quitButton.layer.borderColor = [UIColor redColor].CGColor;
    self.quitButton.layer.borderWidth = 1.0;
    self.quitButton.layer.cornerRadius = 2.0;
    
    self.scoreLabel.hidden = YES;
    self.correctLabel.hidden = YES;
    self.wrongLabel.hidden = YES;
    self.playAgainButton.hidden = YES;
    self.nextCategoryButton.hidden = YES;
    [self.playAgainButton setTitle:@"PLAY\nAGAIN" forState:UIControlStateNormal];
    [self.nextCategoryButton setTitle:@"NEW\nCATEGORY" forState:UIControlStateNormal];
    
    self.overlayImage.animationImages = [self animationArray];
    self.overlayImage.animationDuration = 1.5;
    self.overlayImage.animationRepeatCount = 0;
    [self.overlayImage startAnimating];
    
    
    //Set these BOOLs to "NO" so that you only have to change the correct answer BOOL in the Category methods.
    self.Answer1Correct = NO;
    self.Answer2Correct = NO;
    self.Answer3Correct = NO;
    self.Answer4Correct = NO;
    
    self.scoreNumber = 0;
    self.wrongNumber = 0;
    self.startLabel.adjustsFontSizeToFitWidth = YES;
    self.startLabel.text = @"START!";
    
    [self launchScreenTimer];
    
    self.comicsArray = [NSMutableArray new];
    self.usedComicsArray = [NSMutableArray new];
    self.moviesArray = [NSMutableArray new];
    self.usedMoviesArray = [NSMutableArray new];
    self.tvArray = [NSMutableArray new];
    self.usedTVArray = [NSMutableArray new];
    self.gamesArray = [NSMutableArray new];
    self.usedGamesArray = [NSMutableArray new];
    
    self.comicsArray = [NSMutableArray arrayWithArray:[self comicStringArray]];
    self.moviesArray = [NSMutableArray arrayWithArray:[self movieStringArray]];
    self.tvArray = [NSMutableArray arrayWithArray:[self tvStringArray]];
    self.gamesArray = [NSMutableArray arrayWithArray:[self gameStringArray]];
    
    //CategorySaved represents the category button pressed in the TimeVortexVC
    self.categoryLoaded = [[NSUserDefaults standardUserDefaults]integerForKey:@"CategorySaved"];
    
    //NSLog(@"CATEGORY SELECTED: %li", (long)self.categoryLoaded);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buttonBackgroundColor:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    }
}

-(void)createButtonBorderWidth:(NSInteger)width forArray:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.layer.borderWidth = width;
        button.layer.borderColor = [UIColor yellowColor].CGColor;
    }
}

-(void)buttonCornerRadius:(NSInteger)number forArray:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.layer.cornerRadius = number;
    }
}

-(void)centerButtonText:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}

-(void)questionBorders
{
    //Creates top border for self.middleContainer
    CGFloat borderWidth = 2;
    UIView *topBorder = [UIView new];
    topBorder.backgroundColor = [UIColor yellowColor];
    [topBorder setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin];
    topBorder.frame = CGRectMake(0, 0, self.middleContainer.frame.size.width, borderWidth);
    [self.middleContainer addSubview:topBorder];
    
    //Creates bottom border for self.middleContainer
    UIView *bottomBorder = [UIView new];
    bottomBorder.backgroundColor = [UIColor yellowColor];
    [bottomBorder setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    bottomBorder.frame = CGRectMake(0, self.middleContainer.frame.size.height, self.middleContainer.frame.size.width, borderWidth);
    [self.middleContainer addSubview:bottomBorder];
}

-(NSArray *)animationArray
{
    NSArray *images = @[[UIImage imageNamed:@"swirl 1"], [UIImage imageNamed:@"swirl 2"], [UIImage imageNamed:@"swirl 3"], [UIImage imageNamed:@"swirl 4"], [UIImage imageNamed:@"swirl 5"], [UIImage imageNamed:@"swirl 6"], [UIImage imageNamed:@"swirl 7"], [UIImage imageNamed:@"swirl 8"], [UIImage imageNamed:@"swirl 9"], [UIImage imageNamed:@"swirl 10"], [UIImage imageNamed:@"swirl 11"], [UIImage imageNamed:@"swirl 12"], [UIImage imageNamed:@"swirl 13"], [UIImage imageNamed:@"swirl 14"], [UIImage imageNamed:@"swirl 15"], [UIImage imageNamed:@"swirl 16"], [UIImage imageNamed:@"swirl 17"], [UIImage imageNamed:@"swirl 18"], [UIImage imageNamed:@"swirl 19"], [UIImage imageNamed:@"swirl 20"], [UIImage imageNamed:@"swirl 21"], [UIImage imageNamed:@"swirl 22"], [UIImage imageNamed:@"swirl 23"]];
    return  images;
    
}

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.answer1Button, self.answer2Button, self.answer3Button, self.answer4Button, self.playAgainButton, self.nextCategoryButton];
    return buttons;
    
}

// ***** UPDATE THESE ARRAYS whenever new questions are added to their respective classes *****
-(NSArray *)comicStringArray
{
    NSArray *comics = @[@"comic001", @"comic002", @"comic003", @"comic004", @"comic005", @"comic006", @"comic007", @"comic008", @"comic009", @"comic010", @"comic011", @"comic012", @"comic013", @"comic014", @"comic015",  @"comic016",  @"comic017",  @"comic018",  @"comic019",  @"comic020",  @"comic021",  @"comic022",  @"comic023",  @"comic024",  @"comic025",  @"comic026",  @"comic027",  @"comic028",  @"comic029",  @"comic030", @"comic031", @"comic032", @"comic033", @"comic034", @"comic035", @"comic036", @"comic037", @"comic038", @"comic039", @"comic040", @"comic041", @"comic042", @"comic043", @"comic044", @"comic045", @"comic046", @"comic047", @"comic048", @"comic049", @"comic050", @"comic051", @"comic052", @"comic053", @"comic054", @"comic055", @"comic056", @"comic057", @"comic058", @"comic059", @"comic060"];
    return comics;
}

-(NSArray *)movieStringArray
{
    NSArray *movies = @[@"movie001", @"movie002", @"movie003", @"movie004", @"movie005", @"movie006", @"movie007", @"movie008", @"movie009", @"movie010", @"movie011", @"movie012", @"movie013", @"movie014", @"movie015",  @"movie016",  @"movie017",  @"movie018",  @"movie019",  @"movie020",  @"movie021",  @"movie022",  @"movie023",  @"movie024",  @"movie025",  @"movie026",  @"movie027",  @"movie028",  @"movie029",  @"movie030", @"movie031", @"movie032", @"movie033", @"movie034", @"movie035", @"movie036", @"movie037", @"movie038", @"movie039", @"movie040", @"movie041", @"movie042", @"movie043", @"movie044", @"movie045", @"movie046", @"movie047", @"movie048", @"movie049", @"movie050", @"movie051", @"movie052", @"movie053", @"movie054", @"movie055", @"movie056", @"movie057", @"movie058", @"movie059", @"movie060"];
    return movies;
}

-(NSArray *)tvStringArray
{
    NSArray *tvShows = @[@"tv001", @"tv002", @"tv003", @"tv004", @"tv005", @"tv006", @"tv007", @"tv008", @"tv009", @"tv010", @"tv011", @"tv012", @"tv013", @"tv014", @"tv015",  @"tv016",  @"tv017",  @"tv018",  @"tv019",  @"tv020",  @"tv021",  @"tv022",  @"tv023",  @"tv024",  @"tv025",  @"tv026",  @"tv027",  @"tv028",  @"tv029",  @"tv030", @"tv031", @"tv032", @"tv033", @"tv034", @"tv035", @"tv036", @"tv037", @"tv038", @"tv039", @"tv040", @"tv041", @"tv042", @"tv043", @"tv044", @"tv045", @"tv046", @"tv047", @"tv048", @"tv049", @"tv050", @"tv051", @"tv052", @"tv053", @"tv054", @"tv055", @"tv056", @"tv057", @"tv058", @"tv059", @"tv060"];
    return tvShows;
}

-(NSArray *)gameStringArray
{
    NSArray *games = @[@"game001", @"game002", @"game003", @"game004", @"game005", @"game006", @"game007", @"game008", @"game009", @"game010", @"game011", @"game012", @"game013", @"game014", @"game015",  @"game016",  @"game017",  @"game018",  @"game019",  @"game020",  @"game021",  @"game022",  @"game023",  @"game024",  @"game025",  @"game026",  @"game027",  @"game028",  @"game029",  @"game030", @"game031", @"game032", @"game033", @"game034", @"game035", @"game036", @"game037", @"game038", @"game039", @"game040", @"game041", @"game042", @"game043", @"game044", @"game045", @"game046", @"game047", @"game048", @"game049", @"game050", @"game051", @"game052", @"game053", @"game054", @"game055", @"game056", @"game057", @"game058", @"game059", @"game060"];
    return games;
}

-(void)labelFade
{
    [UIView animateWithDuration:0.75
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.startLabel.alpha = 0;
                         
                     }
                     completion:nil];
    
}

-(void)launchScreenTimer
{
    self.openingSeconds = 4;
    self.openingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                         target:self
                                                       selector:@selector(labelCountdown)
                                                       userInfo:nil
                                                        repeats:YES];
    
}

-(void)labelCountdown
{
    self.openingSeconds --;
    
    if (self.openingSeconds == 3)
    {
        self.startLabel.alpha = 1;
        [self labelFade];
        
    }
    
    if (self.openingSeconds == 2)
    {
        self.startLabel.adjustsFontSizeToFitWidth = YES;
        self.startLabel.text = @"THE!";
        self.startLabel.alpha = 1;
        [self labelFade];
    }
    
    if (self.openingSeconds == 1)
    {
        self.startLabel.adjustsFontSizeToFitWidth = YES;
        self.startLabel.text = @"VORTEX!";
        self.startLabel.alpha = 1;
        [self labelFade];
    }
    
    if (self.openingSeconds == 0)
    {
        
        [self.openingTimer invalidate];
        [self.overlayImage stopAnimating];
        self.overlayContainer.hidden = YES;
        
        [self gameTime];
        
        switch (self.categoryLoaded)
        {
            case 1:
                [self randomComicQuestion];
                break;
            case 2:
                [self randomMovieQuestion];
                break;
            case 3:
                [self randomTVQuestion];
                break;
            case 4:
                [self randomGameQuestion];
                break;
                
            default:
                break;
        }
    }
    
}


-(void)gameCountdown
{
    self.gameSeconds --;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%li", (long)self.gameSeconds];
    
    if (self.gameSeconds == 30)
    {
        self.timerLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0.0 alpha:1.0];
    }
    
    if (self.gameSeconds == 15)
    {
        self.timerLabel.textColor = [UIColor redColor];
    }
    
    if (self.gameSeconds == 0)
    {
        self.answer1Button.enabled = NO;
        self.answer2Button.enabled = NO;
        self.answer3Button.enabled = NO;
        self.answer4Button.enabled = NO;
        self.quitButton.hidden = YES;
        self.timerLabel.adjustsFontSizeToFitWidth = YES;
        self.timerLabel.text = @"TIME'S UP!";
    }
    
    if (self.gameSeconds == -1)
    {
        [self.gameTimer invalidate];
        self.timerLabel.adjustsFontSizeToFitWidth = YES;
        
        //Intentionally restated the text to prevent "-1" from showing in the label.
        self.timerLabel.text = @"TIME'S UP!";
        
        [self gameOver];
    }
    
}

- (void)gameTime
{
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(gameCountdown)
                                           userInfo:nil
                                            repeats:YES];
    
    self.gameSeconds = 60;
    
}

-(void)gameOver
{
    self.overlayFinalImage.image = [UIImage imageNamed:@"vortex gray background"];
    self.overlayImage.hidden = YES;
    self.scoreLabel.text = [NSString stringWithFormat:@"%li", (long)self.scoreNumber];
    self.wrongLabel.text = [NSString stringWithFormat:@"%li  WRONG", (long)self.wrongNumber];
    self.startLabel.adjustsFontSizeToFitWidth = YES;
    self.startLabel.text = @"GAME OVER!";
    self.startLabel.alpha = 1.0;
    self.overlayContainer.hidden = NO;
    self.timerLabel.text = @"60"; //Make sure this matches the self.gameSeconds
    self.scoreLabel.hidden = NO;
    self.correctLabel.hidden = NO;
    self.wrongLabel.hidden = NO;
    self.startLabel.hidden = NO;
    self.playAgainButton.hidden = NO;
    self.nextCategoryButton.hidden = NO;
    
}

-(void)rightAnswer
{
    self.scoreNumber = self.scoreNumber + 1;
    
    //The BOOLs need to be reset after each question.
    //If not, when a correct answer is pressed, that button stays as "YES".
    self.Answer1Correct = NO;
    self.Answer2Correct = NO;
    self.Answer3Correct = NO;
    self.Answer4Correct = NO;
    
}

-(void)wrongAnswer
{
    self.wrongNumber = self.wrongNumber + 1;
    
    //The BOOLs need to be reset after each question.
    //If not, when a correct answer is pressed, that button stays as "YES".
    self.Answer1Correct = NO;
    self.Answer2Correct = NO;
    self.Answer3Correct = NO;
    self.Answer4Correct = NO;
    
}

-(void)randomComicQuestion
{
    //If self.questionArray has more than "zero" items, a random item is selected
    //The random item is placed in self.usedQuestionArray and REMOVED from self.questionArray
    
    VortexComicQuestions *question = [VortexComicQuestions new];
    
    if ([self.comicsArray count] > 0)
    {
        self.randomIndex = arc4random() %[self.comicsArray count];
        
        //NSLog(@"Index Chosen: %li", (long)self.randomIndex);
        //NSLog(@"Available Array Count: %li", (unsigned long)[self.comicsArray count]);
        
        SEL selector = NSSelectorFromString([self.comicsArray objectAtIndex:self.randomIndex]);
        IMP imp = [question methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(question, selector);
        
        self.questionLabel.text = question.question;
        [self.answer1Button setTitle:question.buttonA forState:UIControlStateNormal];
        [self.answer2Button setTitle:question.buttonB forState:UIControlStateNormal];
        [self.answer3Button setTitle:question.buttonC forState:UIControlStateNormal];
        [self.answer4Button setTitle:question.buttonD forState:UIControlStateNormal];
        
        if ([question.correctAnswer isEqualToString:@"A"])
        {
            self.Answer1Correct = YES;
            
        } else if ([question.correctAnswer isEqualToString:@"B"])
        {
            self.Answer2Correct = YES;
            
        } else if ([question.correctAnswer isEqualToString:@"C"])
        {
            self.Answer3Correct = YES;
            
        } else if ([question.correctAnswer isEqualToString:@"D"])
        {
            self.Answer4Correct = YES;
            
        }
        
        [self.usedComicsArray addObject:[self.comicsArray objectAtIndex:self.randomIndex]];
        [self.comicsArray removeObjectAtIndex:self.randomIndex];
        
        //If self.letterArray has "zero" items, it is repopulated by the itmes in self.usedLetterArray
        if ([self.comicsArray count] == 0)
        {
            //The self.letterArray is populated with the items in self.usedLetterArray
            self.comicsArray = [NSMutableArray arrayWithArray:self.usedComicsArray];
            
            //Then self.usedLetterArray is cleaned out and ready to be repopulated by self.letterArray
            [self.usedComicsArray removeAllObjects];
        }
        //NSLog(@"Current Array Count: %li", (unsigned long)[self.comicsArray count]);
    }
    
}

-(void)randomMovieQuestion
{
    //If self.questionArray has more than "zero" items, a random item is selected
    //The random item is placed in self.usedQuestionArray and REMOVED from self.questionArray
    
    VortexMovieQuestions *question = [VortexMovieQuestions new];
    
    if ([self.moviesArray count] > 0)
    {
        self.randomIndex = arc4random() %[self.moviesArray count];
        
        SEL selector = NSSelectorFromString([self.moviesArray objectAtIndex:self.randomIndex]);
        IMP imp = [question methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(question, selector);
        
        self.questionLabel.text = question.question;
        [self.answer1Button setTitle:question.buttonA forState:UIControlStateNormal];
        [self.answer2Button setTitle:question.buttonB forState:UIControlStateNormal];
        [self.answer3Button setTitle:question.buttonC forState:UIControlStateNormal];
        [self.answer4Button setTitle:question.buttonD forState:UIControlStateNormal];
        
        if ([question.correctAnswer isEqualToString:@"A"])
        {
            self.Answer1Correct = YES;
            
        } else if ([question.correctAnswer isEqualToString:@"B"])
        {
            self.Answer2Correct = YES;
            
        } else if ([question.correctAnswer isEqualToString:@"C"])
        {
            self.Answer3Correct = YES;
            
        } else if ([question.correctAnswer isEqualToString:@"D"])
        {
            self.Answer4Correct = YES;
            
        }
        
        [self.usedMoviesArray addObject:[self.moviesArray objectAtIndex:self.randomIndex]];
        [self.moviesArray removeObjectAtIndex:self.randomIndex];
        
        //If self.letterArray has "zero" items, it is repopulated by the itmes in self.usedLetterArray
        if ([self.moviesArray count] == 0)
        {
            //The self.letterArray is populated with the items in self.usedLetterArray
            self.moviesArray = [NSMutableArray arrayWithArray:self.usedMoviesArray];
            
            //Then self.usedLetterArray is cleaned out and ready to be repopulated by self.letterArray
            [self.usedMoviesArray removeAllObjects];
        }
        
    }
    
}


-(void)randomTVQuestion
{
    VortexTvQuestions *question = [VortexTvQuestions new];
    
    if ([self.tvArray count] > 0)
    {
        self.randomIndex = arc4random() %[self.tvArray count];
        
        SEL selector = NSSelectorFromString([self.tvArray objectAtIndex:self.randomIndex]);
        IMP imp = [question methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(question, selector);
        
        self.questionLabel.text = question.question;
        [self.answer1Button setTitle:question.buttonA forState:UIControlStateNormal];
        [self.answer2Button setTitle:question.buttonB forState:UIControlStateNormal];
        [self.answer3Button setTitle:question.buttonC forState:UIControlStateNormal];
        [self.answer4Button setTitle:question.buttonD forState:UIControlStateNormal];
        
        if ([question.correctAnswer isEqualToString:@"A"])
        {
            self.Answer1Correct = YES;
            
        } else if ([question.correctAnswer isEqualToString:@"B"])
        {
            self.Answer2Correct = YES;
            
        } else if ([question.correctAnswer isEqualToString:@"C"])
        {
            self.Answer3Correct = YES;
            
        } else if ([question.correctAnswer isEqualToString:@"D"])
        {
            self.Answer4Correct = YES;
            
        }
        
        [self.usedTVArray addObject:[self.tvArray objectAtIndex:self.randomIndex]];
        [self.tvArray removeObjectAtIndex:self.randomIndex];

        if ([self.tvArray count] == 0)
        {
            self.tvArray = [NSMutableArray arrayWithArray:self.usedTVArray];

            [self.usedTVArray removeAllObjects];
        }
        
    }
    
}

-(void)randomGameQuestion
{
    VortexGameQuestions *question = [VortexGameQuestions new];
    
    if ([self.gamesArray count] > 0)
    {
        self.randomIndex = arc4random() %[self.gamesArray count];
        
        SEL selector = NSSelectorFromString([self.gamesArray objectAtIndex:self.randomIndex]);
        IMP imp = [question methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(question, selector);
        
        self.questionLabel.text = question.question;
        [self.answer1Button setTitle:question.buttonA forState:UIControlStateNormal];
        [self.answer2Button setTitle:question.buttonB forState:UIControlStateNormal];
        [self.answer3Button setTitle:question.buttonC forState:UIControlStateNormal];
        [self.answer4Button setTitle:question.buttonD forState:UIControlStateNormal];
        
        if ([question.correctAnswer isEqualToString:@"A"])
        {
            self.Answer1Correct = YES;
            
        } else if ([question.correctAnswer isEqualToString:@"B"])
        {
            self.Answer2Correct = YES;
            
        } else if ([question.correctAnswer isEqualToString:@"C"])
        {
            self.Answer3Correct = YES;
            
        } else if ([question.correctAnswer isEqualToString:@"D"])
        {
            self.Answer4Correct = YES;
            
        }
        
        [self.usedGamesArray addObject:[self.gamesArray objectAtIndex:self.randomIndex]];
        [self.gamesArray removeObjectAtIndex:self.randomIndex];
        
        if ([self.gamesArray count] == 0)
        {
            self.gamesArray = [NSMutableArray arrayWithArray:self.usedGamesArray];
            
            [self.usedGamesArray removeAllObjects];
        }
        
    }
    
}


- (IBAction)quitTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)answer1Tapped:(id)sender
{
    //Do a "switch" in all buttons using "Category Loaded"
    if (self.Answer1Correct == YES)
    {
        [self rightAnswer];
    } else
    {
        [self wrongAnswer];
    }
    
    switch (self.categoryLoaded)
    {
        case 1:
            [self randomComicQuestion];
            break;
        case 2:
            [self randomMovieQuestion];
            break;
        case 3:
            [self randomTVQuestion];
            break;
        case 4:
            [self randomGameQuestion];
            break;
            
        default:
            break;
    }
    
}

- (IBAction)answer2Tapped:(id)sender
{
    if (self.Answer2Correct == YES)
    {
        [self rightAnswer];
    } else
    {
        [self wrongAnswer];
    }
    
    switch (self.categoryLoaded)
    {
        case 1:
            [self randomComicQuestion];
            break;
        case 2:
            [self randomMovieQuestion];
            break;
        case 3:
            [self randomTVQuestion];
            break;
        case 4:
            [self randomGameQuestion];
            break;
            
        default:
            break;
    }
    
}

- (IBAction)answer3Tapped:(id)sender
{
    if (self.Answer3Correct == YES)
    {
        [self rightAnswer];
    } else
    {
        [self wrongAnswer];
    }
    
    switch (self.categoryLoaded)
    {
        case 1:
            [self randomComicQuestion];
            break;
        case 2:
            [self randomMovieQuestion];
            break;
        case 3:
            [self randomTVQuestion];
            break;
        case 4:
            [self randomGameQuestion];
            break;
            
        default:
            break;
    }
    
}

- (IBAction)answer4Tapped:(id)sender
{
    if (self.Answer4Correct == YES)
    {
        [self rightAnswer];
    } else
    {
        [self wrongAnswer];
    }
    
    switch (self.categoryLoaded)
    {
        case 1:
            [self randomComicQuestion];
            break;
        case 2:
            [self randomMovieQuestion];
            break;
        case 3:
            [self randomTVQuestion];
            break;
        case 4:
            [self randomGameQuestion];
            break;
            
        default:
            break;
    }
    
}

- (IBAction)playAgainTapped:(id)sender
{
    self.overlayImage.hidden = NO;
    [self.overlayImage startAnimating];
    self.timerLabel.textColor = [UIColor colorWithRed:0.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:1.0];
    [self launchScreenTimer];
    self.quitButton.hidden = NO;
    self.scoreNumber = 0;
    self.wrongNumber = 0;
    self.scoreLabel.hidden = YES;
    self.correctLabel.hidden = YES;
    self.wrongLabel.hidden = YES;
    self.startLabel.text = @"START!";
    self.playAgainButton.hidden = YES;
    self.nextCategoryButton.hidden = YES;
    self.answer1Button.enabled = YES;
    self.answer2Button.enabled = YES;
    self.answer3Button.enabled = YES;
    self.answer4Button.enabled = YES;
    
}

- (IBAction)nextCategoryTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}






@end
