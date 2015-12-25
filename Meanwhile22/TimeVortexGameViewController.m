//
//  TimeVortexGameViewController.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/30/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "TimeVortexGameViewController.h"

@interface TimeVortexGameViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIView *overlayContainer;
@property (weak, nonatomic) IBOutlet UIImageView *overlayImage;
@property (weak, nonatomic) IBOutlet UIView *resultContainer;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *correctLabel;
@property (weak, nonatomic) IBOutlet UIView *startContainer;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UIView *overlayButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *playAgainButton;
@property (weak, nonatomic) IBOutlet UIButton *nextCategoryButton;

@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

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
    
    
    self.topContainer.backgroundColor = [UIColor clearColor];
    
    self.middleContainer.backgroundColor = [UIColor clearColor];
    
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
    
    [self buttonBackgroundColor:[self buttonArray]];
    [self createButtonBorderWidth:1.0 forArray:[self buttonArray]];
    [self buttonCornerRadius:8.0 forArray:[self buttonArray]];
    [self centerButtonText:[self buttonArray]];
    
    self.scoreLabel.hidden = YES;
    self.correctLabel.hidden = YES;
    self.playAgainButton.hidden = YES;
    self.nextCategoryButton.hidden = YES;
    
    
    //Set these BOOLs to "NO" so that you only have to change the correct answer BOOL in the Category methods.
    self.Answer1Correct = NO;
    self.Answer2Correct = NO;
    self.Answer3Correct = NO;
    self.Answer4Correct = NO;
    
    self.scoreNumber = 0;
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
    
    self.comicsArray = [NSMutableArray arrayWithArray:[self convertedComicArray]];
    self.moviesArray = [NSMutableArray arrayWithArray:[self convertedMovieArray]];
    self.tvArray = [NSMutableArray arrayWithArray:[self convertedTVArray]];
    self.gamesArray = [NSMutableArray arrayWithArray:[self convertedGameArray]];
    
    //CategorySaved represents the category button pressed in the TimeVortexVC
    self.categoryLoaded = [[NSUserDefaults standardUserDefaults]integerForKey:@"CategorySaved"];
    
    NSLog(@"CATEGORY SELECTED: %li", (long)self.categoryLoaded);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)buttonBackgroundColor:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.backgroundColor = [UIColor clearColor];
        
    }
    
}

-(void)createButtonBorderWidth:(NSInteger)width forArray:(NSArray *)array
{
    for (UIButton *button in array)
    {
        button.layer.borderWidth = 2.0;
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

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.answer1Button, self.answer2Button, self.answer3Button, self.answer4Button, self.playAgainButton, self.nextCategoryButton];
    return buttons;
    
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
        self.timerLabel.textColor = [UIColor yellowColor];
    }
    
    if (self.gameSeconds == 15)
    {
        self.timerLabel.textColor = [UIColor redColor];
    }
    
    if (self.gameSeconds == 0)
    {
        self.timerLabel.adjustsFontSizeToFitWidth = YES;
        self.timerLabel.text = @"TIME'S UP!";
    }
    
    if (self.gameSeconds == -1)
    {
        [self.gameTimer invalidate];
        self.timerLabel.adjustsFontSizeToFitWidth = YES;
        
        //Intentionally restated the text to prevent "-1" from showing in the label.
        self.timerLabel.text = @"TIME'S UP!";
        NSLog(@"DONE!!");
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
    
    self.gameSeconds = 30;
    
}

-(void)gameOver
{
    self.scoreLabel.text = [NSString stringWithFormat:@"%li", (long)self.scoreNumber];
    self.startLabel.adjustsFontSizeToFitWidth = YES;
    self.startLabel.text = @"GAME OVER!";
    self.startLabel.alpha = 1.0;
    self.overlayContainer.hidden = NO;
    self.timerLabel.text = @"60"; //Make sure this matches the self.gameSeconds
    self.scoreLabel.hidden = NO;
    self.correctLabel.hidden = NO;
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
    //The BOOLs need to be reset after each question.
    //If not, when a correct answer is pressed, that button stays as "YES".
    self.Answer1Correct = NO;
    self.Answer2Correct = NO;
    self.Answer3Correct = NO;
    self.Answer4Correct = NO;
    
}

/*
//For some reason, when using this method, the info does not refresh after array1 is repopulated by array2
-(void)randomQuestion:(NSMutableArray *)array1 disposedTo:(NSMutableArray *)array2
{
    //If array1 has more than "zero" items, a random index number is selected
    //The random object is placed in array2 and REMOVED from array1
    
    if ([array1 count] > 0)
    {
        self.randomIndex = arc4random() %[array1 count];
        
        NSLog(@"Random Index: %li", (long)self.randomIndex);
        NSLog(@"Initial Count: %li", [array1 count]);
        
        SEL selector = [[array1 objectAtIndex:self.randomIndex] pointerValue];
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self, selector);
        
        [array2 addObject:[array1 objectAtIndex:self.randomIndex]];
        [array1 removeObjectAtIndex:self.randomIndex];
        
        //NSLog(@"Array Now Contains: %@", array1);
        
        //If array1 has "zero" items, it is repopulated by the itmes in array2
        if ([array1 count] == 0)
        {
            //The array1 is populated with the items in array2
            array1 = [NSMutableArray arrayWithArray:array2];
            
            //Then array2 is cleaned out and ready to be repopulated by array1
            [array2 removeAllObjects];
        }
        NSLog(@"New Count: %li", [array1 count]);
    }
    
}
*/

-(void)randomComicQuestion
{
    //If self.questionArray has more than "zero" items, a random item is selected
    //The random item is placed in self.usedQuestionArray and REMOVED from self.questionArray
    if ([self.comicsArray count] > 0)
    {
        self.randomIndex = arc4random() %[self.comicsArray count];
        
        NSLog(@"Random Index: %li", (long)self.randomIndex);
        NSLog(@"Initial Count: %li", (unsigned long)[self.comicsArray count]);
        
        SEL selector = [[self.comicsArray objectAtIndex:self.randomIndex] pointerValue];
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self, selector);
        
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
        NSLog(@"New Count: %li", (unsigned long)[self.comicsArray count]);
    }
    
    //[self randomQuestion:self.comicsArray disposedTo:self.usedComicsArray];
    
}

-(void)randomMovieQuestion
{
    //If self.questionArray has more than "zero" items, a random item is selected
    //The random item is placed in self.usedQuestionArray and REMOVED from self.questionArray
    if ([self.moviesArray count] > 0)
    {
        self.randomIndex = arc4random() %[self.moviesArray count];
        
        NSLog(@"Random Index: %li", (long)self.randomIndex);
        NSLog(@"Initial Count: %li", (unsigned long)[self.moviesArray count]);
        
        SEL selector = [[self.moviesArray objectAtIndex:self.randomIndex] pointerValue];
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self, selector);
        
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
        NSLog(@"New Count: %li", (unsigned long)[self.moviesArray count]);
    }
    
    //[self randomQuestion:self.moviesArray disposedTo:self.usedMoviesArray];
    
}


-(void)randomTVQuestion
{

    if ([self.tvArray count] > 0)
    {
        self.randomIndex = arc4random() %[self.tvArray count];
        
        NSLog(@"Random Index: %li", (long)self.randomIndex);
        NSLog(@"Initial Count: %li", (unsigned long)[self.tvArray count]);
        
        SEL selector = [[self.tvArray objectAtIndex:self.randomIndex] pointerValue];
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self, selector);
        
        [self.usedTVArray addObject:[self.tvArray objectAtIndex:self.randomIndex]];
        [self.tvArray removeObjectAtIndex:self.randomIndex];

        if ([self.tvArray count] == 0)
        {
            self.tvArray = [NSMutableArray arrayWithArray:self.usedTVArray];

            [self.usedTVArray removeAllObjects];
        }
        NSLog(@"New Count: %li", (unsigned long)[self.tvArray count]);
    }
    
    //[self randomQuestion:self.tvArray disposedTo:self.usedTVArray];
    
}

-(void)randomGameQuestion
{
    
    if ([self.gamesArray count] > 0)
    {
        self.randomIndex = arc4random() %[self.gamesArray count];
        
        NSLog(@"Random Index: %li", (long)self.randomIndex);
        NSLog(@"Initial Count: %li", (unsigned long)[self.gamesArray count]);
        
        SEL selector = [[self.gamesArray objectAtIndex:self.randomIndex] pointerValue];
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self, selector);
        
        [self.usedGamesArray addObject:[self.gamesArray objectAtIndex:self.randomIndex]];
        [self.gamesArray removeObjectAtIndex:self.randomIndex];
        
        if ([self.gamesArray count] == 0)
        {
            self.gamesArray = [NSMutableArray arrayWithArray:self.usedGamesArray];
            
            [self.usedGamesArray removeAllObjects];
        }
        NSLog(@"New Count: %li", (unsigned long)[self.gamesArray count]);
    }
    
    //[self randomQuestion:self.gamesArray disposedTo:self.usedGamesArray];
    
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
    [self launchScreenTimer];
    self.scoreNumber = 0;
    self.scoreLabel.hidden = YES;
    self.correctLabel.hidden = YES;
    self.startLabel.text = @"START!";
    self.playAgainButton.hidden = YES;
    self.nextCategoryButton.hidden = YES;
    
}

- (IBAction)nextCategoryTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Question Arrays

-(NSMutableArray *)convertedComicArray
{
    NSValue *comic1 = [NSValue valueWithPointer:@selector(comic_1)];
    NSValue *comic2 = [NSValue valueWithPointer:@selector(comic_2)];
    NSValue *comic3 = [NSValue valueWithPointer:@selector(comic_3)];
    NSValue *comic4 = [NSValue valueWithPointer:@selector(comic_4)];
    NSValue *comic5 = [NSValue valueWithPointer:@selector(comic_5)];
    NSValue *comic6 = [NSValue valueWithPointer:@selector(comic_6)];
    NSValue *comic7 = [NSValue valueWithPointer:@selector(comic_7)];
    NSValue *comic8 = [NSValue valueWithPointer:@selector(comic_8)];
    NSValue *comic9 = [NSValue valueWithPointer:@selector(comic_9)];
    NSValue *comic10 = [NSValue valueWithPointer:@selector(comic_10)];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:comic1, comic2, comic3, comic4, comic5, comic6, comic7, comic8, comic9, comic10, nil];
    return array;
}

-(NSMutableArray *)convertedMovieArray
{
    NSValue *movie1 = [NSValue valueWithPointer:@selector(movie_1)];
    NSValue *movie2 = [NSValue valueWithPointer:@selector(movie_2)];
    NSValue *movie3 = [NSValue valueWithPointer:@selector(movie_3)];
    NSValue *movie4 = [NSValue valueWithPointer:@selector(movie_4)];
    NSValue *movie5 = [NSValue valueWithPointer:@selector(movie_5)];
    NSValue *movie6 = [NSValue valueWithPointer:@selector(movie_6)];
    NSValue *movie7 = [NSValue valueWithPointer:@selector(movie_7)];
    NSValue *movie8 = [NSValue valueWithPointer:@selector(movie_8)];
    NSValue *movie9 = [NSValue valueWithPointer:@selector(movie_9)];
    NSValue *movie10 = [NSValue valueWithPointer:@selector(movie_10)];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:movie1, movie2, movie3, movie4, movie5, movie6, movie7, movie8, movie9, movie10, nil];
    return array;
}

-(NSMutableArray *)convertedTVArray
{
    NSValue *tv1 = [NSValue valueWithPointer:@selector(tv_1)];
    NSValue *tv2 = [NSValue valueWithPointer:@selector(tv_2)];
    NSValue *tv3 = [NSValue valueWithPointer:@selector(tv_3)];
    NSValue *tv4 = [NSValue valueWithPointer:@selector(tv_4)];
    NSValue *tv5 = [NSValue valueWithPointer:@selector(tv_5)];
    NSValue *tv6 = [NSValue valueWithPointer:@selector(tv_6)];
    NSValue *tv7 = [NSValue valueWithPointer:@selector(tv_7)];
    NSValue *tv8 = [NSValue valueWithPointer:@selector(tv_8)];
    NSValue *tv9 = [NSValue valueWithPointer:@selector(tv_9)];
    NSValue *tv10 = [NSValue valueWithPointer:@selector(tv_10)];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:tv1, tv2, tv3, tv4, tv5, tv6, tv7, tv8, tv9, tv10, nil];
    return array;
}

-(NSMutableArray *)convertedGameArray
{
    NSValue *game1 = [NSValue valueWithPointer:@selector(game_1)];
    NSValue *game2 = [NSValue valueWithPointer:@selector(game_2)];
    NSValue *game3 = [NSValue valueWithPointer:@selector(game_3)];
    NSValue *game4 = [NSValue valueWithPointer:@selector(game_4)];
    NSValue *game5 = [NSValue valueWithPointer:@selector(game_5)];
    NSValue *game6 = [NSValue valueWithPointer:@selector(game_6)];
    NSValue *game7 = [NSValue valueWithPointer:@selector(game_7)];
    NSValue *game8 = [NSValue valueWithPointer:@selector(game_8)];
    NSValue *game9 = [NSValue valueWithPointer:@selector(game_9)];
    NSValue *game10 = [NSValue valueWithPointer:@selector(game_10)];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:game1, game2, game3, game4, game5, game6, game7, game8, game9, game10, nil];
    return array;
}

#pragma mark - Questions

// **** New questions must be added to its "converted array method" AND the mutable array within ****

//Comics ***********

-(void)comic_1
{
    self.questionLabel.text = @"What is comic has the first appearance of Superman?";
    [self.answer1Button setTitle:@"Detective Comics #32" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Amazing Stories #15" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Action Comics #1" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Superman #1" forState:UIControlStateNormal];
    self.Answer3Correct = YES;
    
}

-(void)comic_2
{
    self.questionLabel.text = @"In what year did Dick Grayson take up the code name Nightwing?";
    [self.answer1Button setTitle:@"1984" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"1977" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"1980" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"1988" forState:UIControlStateNormal];
    self.Answer1Correct = YES;
    
}

-(void)comic_3
{
    self.questionLabel.text = @"In Post-Crisis storytelling, who inspired Dick Grayson to take the code name Nightwing?";
    [self.answer1Button setTitle:@"Batman" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Starfire" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Speedy" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Superman" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

-(void)comic_4
{
    self.questionLabel.text = @"Aquaman’s civilian name is … ?";
    [self.answer1Button setTitle:@"Adam Strange" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Arthur Curry" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"George Finn" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Glenn King" forState:UIControlStateNormal];
    self.Answer2Correct = YES;
    
}

-(void)comic_5
{
    self.questionLabel.text = @"Hunter Rose was the first person to assume which code name?";
    [self.answer1Button setTitle:@"Grendel" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Kraven the Hunter" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Deadshot" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Lone Ranger" forState:UIControlStateNormal];
    self.Answer1Correct = YES;
    
}

-(void)comic_6
{
    self.questionLabel.text = @"Detective Comics #140 was the first appearance of which character?";
    [self.answer1Button setTitle:@"Joker" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Catwoman" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Penguin" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Riddler" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

-(void)comic_7
{
    self.questionLabel.text = @"Which X-Men villain is not a mutant?";
    [self.answer1Button setTitle:@"Magneto" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Stryfe" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Juggernaut" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Sebastian Shaw" forState:UIControlStateNormal];
    self.Answer3Correct = YES;
    
}

-(void)comic_8
{
    self.questionLabel.text = @"The first incarnation of Firestorm consisted of … ?";
    [self.answer1Button setTitle:@"Hank Hall and Don Hall" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Roniie Raymand and Martin Stein" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Johnny Storm and Angelica Jones" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Bruce Wayne and Clark Kent" forState:UIControlStateNormal];
    self.Answer2Correct = YES;
    
}

-(void)comic_9
{
    self.questionLabel.text = @"Mirror Master is an arch-enemy of which DC superhero?";
    [self.answer1Button setTitle:@"Flash" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Batman" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Doctor Fate" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Booster Gold" forState:UIControlStateNormal];
    self.Answer1Correct = YES;
    
}

-(void)comic_10
{
    self.questionLabel.text = @"Marvel Comics’ Captain Marvel died from … ?";
    [self.answer1Button setTitle:@"Vampire bite" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Head trauma" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"AIDS complications" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Cancer" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

// **** New questions must be added to its "converted array method" AND the mutable array within ****

//Movies ***********

-(void)movie_1
{
    self.questionLabel.text = @"Gone With The - ?";
    [self.answer1Button setTitle:@"Wind" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Dinosaurs" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Night" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Money" forState:UIControlStateNormal];
    self.Answer1Correct = YES;
    
}

-(void)movie_2
{
    self.questionLabel.text = @"What was Rosebud in Citizen Kane?";
    [self.answer1Button setTitle:@"Estate name" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Dog" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Sled" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Vodka Brand" forState:UIControlStateNormal];
    self.Answer3Correct = YES;
    
}

-(void)movie_3
{
    self.questionLabel.text = @"Who played Dorothy in The Wizard of Oz?";
    [self.answer1Button setTitle:@"Shirley Temple" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Marilyn Monroe" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Norma Desmond" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Judy Garland" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

-(void)movie_4
{
    self.questionLabel.text = @"Which movie did NOT star Tom Cuise?";
    [self.answer1Button setTitle:@"Mission Impossible" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Next" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Jack Reacher" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Risky Business" forState:UIControlStateNormal];
    self.Answer2Correct = YES;
    
}

-(void)movie_5
{
    self.questionLabel.text = @"As of 2011, the Final Destination franchise had how many films?";
    [self.answer1Button setTitle:@"5" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"3" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"6" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"4" forState:UIControlStateNormal];
    self.Answer1Correct = YES;
    
}

-(void)movie_6
{
    self.questionLabel.text = @"In Alfred Hitchcock’s Psycho, Norman Bates killed people dressed as … ?";
    [self.answer1Button setTitle:@"His mailman" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"A bird" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"His mother" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"A wolf" forState:UIControlStateNormal];
    self.Answer3Correct = YES;
    
}

-(void)movie_7
{
    self.questionLabel.text = @"The 1991 action-thriller Point Break what was the name of the FBI Agent played by Keanu Reeves?";
    [self.answer1Button setTitle:@"Bunker Weiss" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Ben Harp" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Angelo Pappas" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Johnny Utah" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

-(void)movie_8
{
    self.questionLabel.text = @"Which movie was NOT directed by Ridley Scott?";
    [self.answer1Button setTitle:@"Alien" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Platoon" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Black Rain" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Prometheus" forState:UIControlStateNormal];
    self.Answer2Correct = YES;
    
}

-(void)movie_9
{
    self.questionLabel.text = @"In Duck Soup, Groucho Marx played which character?";
    [self.answer1Button setTitle:@"Roscoe P. Coltrane" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"George R. R. Martin" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Edward E. Nigma" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Rufus T. Firefly" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

-(void)movie_10
{
    self.questionLabel.text = @"Who directed 2002’s Spider-Man?";
    [self.answer1Button setTitle:@"Michael Bay" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Sam Raimi" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Zack Snyder" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Ed Wood" forState:UIControlStateNormal];
    self.Answer2Correct = YES;
    
}

// **** New questions must be added to its "converted array method" AND the mutable array within ****

//TV Shows ***********

-(void)tv_1
{
    self.questionLabel.text = @"In 2010, what comic book went from print to television?";
    [self.answer1Button setTitle:@"The Walking Dead" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Arrow" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Buffy the Vampire Slayer" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Constantine" forState:UIControlStateNormal];
    self.Answer1Correct = YES;
    
}

-(void)tv_2
{
    self.questionLabel.text = @"Ralph Hanley was a school teacher with super powers in what TV show?";
    [self.answer1Button setTitle:@"Automan" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Smallville" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Greatest American Hero" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Manimal" forState:UIControlStateNormal];
    self.Answer3Correct = YES;
    
}

-(void)tv_3
{
    self.questionLabel.text = @"Where does “Everybody know your name”?";
    [self.answer1Button setTitle:@"Bellefleur's Bar and Grill" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Archie Bunker's Place" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"The Bamboo Lounge" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Cheers" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

-(void)tv_4
{
    self.questionLabel.text = @"According to The Fresh Prince of Bel Air opening song, where was Will Smith born and raised?";
    [self.answer1Button setTitle:@"East LA" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"West Philadelphia" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"East Bronx" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"West Hollywood" forState:UIControlStateNormal];
    self.Answer2Correct = YES;
    
}

-(void)tv_5
{
    self.questionLabel.text = @"Before he was James Bond, Pierce Brosnan was a con man turned detective on which series?";
    [self.answer1Button setTitle:@"Remington Steele" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Moonlighting" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"The Mentalist" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Jake and the Fatman" forState:UIControlStateNormal];
    self.Answer1Correct = YES;
    
}

-(void)tv_6
{
    self.questionLabel.text = @"The British sitcom Are You Being Served originally took place in which setting?";
    [self.answer1Button setTitle:@"Pub" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Junk yard" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Department store" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Doctor's office" forState:UIControlStateNormal];
    self.Answer3Correct = YES;
    
}

-(void)tv_7
{
    self.questionLabel.text = @"What is Sheldon Cooper’s catchphrase on The Big Bang Theory?";
    [self.answer1Button setTitle:@"Blammo!" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Bam!" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Boppity-boop!" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Bazinga!" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

-(void)tv_8
{
    self.questionLabel.text = @"Which woman did NOT play Catwoman on the Batman live-action TV series?";
    [self.answer1Button setTitle:@"Eartha Kitt" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Lynda Carter" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Lee Merriwether" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Julie Newmar" forState:UIControlStateNormal];
    self.Answer2Correct = YES;
    
}

-(void)tv_9
{
    self.questionLabel.text = @"What is Captain Kirk’s middle name?";
    [self.answer1Button setTitle:@"Tyrone" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Theodore" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Titan" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Tiberius" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

-(void)tv_10
{
    self.questionLabel.text = @"Fry, Bender, and Leela are the main characters from which animated TV show?";
    [self.answer1Button setTitle:@"Bob's Burgers" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Futurama" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"American Dad" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"The PJ's" forState:UIControlStateNormal];
    self.Answer2Correct = YES;
    
}

// **** New questions must be added to its "converted array method" AND the mutable array within ****

//Games ***********

-(void)game_1
{
    self.questionLabel.text = @"Bartender Desmond Miles is used by Abstergo Industries to find the location of several artifacts in what console game franchise?";
    [self.answer1Button setTitle:@"Assassin's Creed" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Hitman" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Resident Evil" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Portal" forState:UIControlStateNormal];
    self.Answer1Correct = YES;
    
}

-(void)game_2
{
    self.questionLabel.text = @"Which game came out first?";
    [self.answer1Button setTitle:@"Pac-Man" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Centipede" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Pong" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Space Invaders" forState:UIControlStateNormal];
    self.Answer3Correct = YES;
    
}

-(void)game_3
{
    self.questionLabel.text = @"In Halo, Master Chief’s smart AI is known by what name?";
    [self.answer1Button setTitle:@"Red Queen" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Siri" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Cortana" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Hal" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

-(void)game_4
{
    self.questionLabel.text = @"Princess Peach was introduced in which game?";
    [self.answer1Button setTitle:@"Super Mario Bros." forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Donkey Kong" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"The Legend of Zelda" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Gauntlet" forState:UIControlStateNormal];
    self.Answer2Correct = YES;
    
}

-(void)game_5
{
    self.questionLabel.text = @"The King of All Cosmos orders The Prince to do tasks using what object?";
    [self.answer1Button setTitle:@"Katamari" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Skull sword" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Flailgun" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Metal Chocobo" forState:UIControlStateNormal];
    self.Answer1Correct = YES;
    
}

-(void)game_6
{
    self.questionLabel.text = @"How many unlock able characters are there in Super Smash Bros.?";
    [self.answer1Button setTitle:@"5" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"3" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"4" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"6" forState:UIControlStateNormal];
    self.Answer3Correct = YES;
    
}

-(void)game_7
{
    self.questionLabel.text = @"Which is NOT a card in the original Uno card deck?";
    [self.answer1Button setTitle:@"Skip" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Draw Two" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Reverse" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Wild Draw Three" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

-(void)game_8
{
    self.questionLabel.text = @"How many squares are on a chess board?";
    [self.answer1Button setTitle:@"32" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"64" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"48" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"56" forState:UIControlStateNormal];
    self.Answer2Correct = YES;
    
}

-(void)game_9
{
    self.questionLabel.text = @"What was the original name of the Mr. Monopoly character from the board game Monopoly?";
    [self.answer1Button setTitle:@"Max A. Million" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Monte Moneybags" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"The Tax Man" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Rich Uncle Pennybags" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

-(void)game_10
{
    self.questionLabel.text = @"How many tradable properties are on the Monopoly board?";
    [self.answer1Button setTitle:@"50" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"28" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"32" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"44" forState:UIControlStateNormal];
    self.Answer2Correct = YES;
    
}

















@end
