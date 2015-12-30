//
//  DeadlyQuestions.m
//  Meanwhile22
//
//  Created by Michael Hoffman on 12/24/15.
//  Copyright © 2015 Here We Go. All rights reserved.
//

#import "DeadlyQuestions.h"

@interface DeadlyQuestions ()

@property (weak, nonatomic) IBOutlet UIButton *answer1Button;
@property (weak, nonatomic) IBOutlet UIButton *answer2Button;
@property (weak, nonatomic) IBOutlet UIButton *answer3Button;
@property (weak, nonatomic) IBOutlet UIButton *answer4Button;

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property NSMutableArray *questionArray;
@property NSMutableArray *usedQuestionArray;
@property NSInteger randomIndex;

@property BOOL Answer1Correct;
@property BOOL Answer2Correct;
@property BOOL Answer3Correct;
@property BOOL Answer4Correct;

@end

@implementation DeadlyQuestions

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)randomQuestion
{
    //If self.questionArray has more than "zero" items, a random item is selected
    //The random item is placed in self.usedQuestionArray and REMOVED from self.questionArray
    
    self.questionArray = [NSMutableArray new];
    self.questionArray = [self convertedQuestionArray];
    
    if ([self.questionArray count] > 0)
    {
        self.randomIndex = arc4random() %[self.questionArray count];
        
        NSLog(@"Random Index: %li", (long)self.randomIndex);
        NSLog(@"Initial Count: %li", (unsigned long)[self.questionArray count]);
        
        SEL selector = [[self.questionArray objectAtIndex:self.randomIndex] pointerValue];
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self, selector);
        
        [self.usedQuestionArray addObject:[self.questionArray objectAtIndex:self.randomIndex]];
        [self.questionArray removeObjectAtIndex:self.randomIndex];
        
        //If self.questionArray has "zero" items, it is repopulated by the itmes in self.usedQuestionArray
        if ([self.questionArray count] == 0)
        {
            //The self.questionArray is populated with the items in self.usedQuestionArray
            self.questionArray = [NSMutableArray arrayWithArray:self.usedQuestionArray];
            
            //Then self.usedQuestionArray is cleaned out and ready to be repopulated by self.questionArray
            [self.usedQuestionArray removeAllObjects];
        }
        NSLog(@"New Count: %li", (unsigned long)[self.questionArray count]);
    }
    
}

-(NSMutableArray *)convertedQuestionArray
{
    NSValue *question1 = [NSValue valueWithPointer:@selector(question_1)];
    NSValue *question2 = [NSValue valueWithPointer:@selector(question_2)];
    NSValue *question3 = [NSValue valueWithPointer:@selector(question_3)];
    NSValue *question4 = [NSValue valueWithPointer:@selector(question_4)];
    NSValue *question5 = [NSValue valueWithPointer:@selector(question_5)];
    NSValue *question6 = [NSValue valueWithPointer:@selector(question_6)];
    NSValue *question7 = [NSValue valueWithPointer:@selector(question_7)];
    NSValue *question8 = [NSValue valueWithPointer:@selector(question_8)];
    NSValue *question9 = [NSValue valueWithPointer:@selector(question_9)];
    NSValue *question10 = [NSValue valueWithPointer:@selector(question_10)];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:question1, question2, question3, question4, question5, question6, question7, question8, question9, question10, nil];
    return array;
}

#pragma mark - Questions

// **** New questions must be added to its "converted array method" AND the mutable array within ****

//Comics ***********

-(void)question_1
{
    self.questionLabel.text = @"What is comic has the first appearance of Superman?";
    [self.answer1Button setTitle:@"Detective Comics #32" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Amazing Stories #15" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Action Comics #1" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Superman #1" forState:UIControlStateNormal];
    self.Answer3Correct = YES;
    
}

-(void)question_2
{
    self.questionLabel.text = @"In what year did Dick Grayson take up the code name Nightwing?";
    [self.answer1Button setTitle:@"1984" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"1977" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"1980" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"1988" forState:UIControlStateNormal];
    self.Answer1Correct = YES;
    
}

-(void)question_3
{
    self.questionLabel.text = @"In Post-Crisis storytelling, who inspired Dick Grayson to take the code name Nightwing?";
    [self.answer1Button setTitle:@"Batman" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Starfire" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Speedy" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Superman" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

-(void)question_4
{
    self.questionLabel.text = @"Aquaman’s civilian name is … ?";
    [self.answer1Button setTitle:@"Adam Strange" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Arthur Curry" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"George Finn" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Glenn King" forState:UIControlStateNormal];
    self.Answer2Correct = YES;
    
}

-(void)question_5
{
    self.questionLabel.text = @"Hunter Rose was the first person to assume which code name?";
    [self.answer1Button setTitle:@"Grendel" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Kraven the Hunter" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Deadshot" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Lone Ranger" forState:UIControlStateNormal];
    self.Answer1Correct = YES;
    
}

-(void)question_6
{
    self.questionLabel.text = @"Detective Comics #140 was the first appearance of which character?";
    [self.answer1Button setTitle:@"Joker" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Catwoman" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Penguin" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Riddler" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

-(void)question_7
{
    self.questionLabel.text = @"Which X-Men villain is not a mutant?";
    [self.answer1Button setTitle:@"Magneto" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Stryfe" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Juggernaut" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Sebastian Shaw" forState:UIControlStateNormal];
    self.Answer3Correct = YES;
    
}

-(void)question_8
{
    self.questionLabel.text = @"The first incarnation of Firestorm consisted of … ?";
    [self.answer1Button setTitle:@"Hank Hall and Don Hall" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Roniie Raymand and Martin Stein" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Johnny Storm and Angelica Jones" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Bruce Wayne and Clark Kent" forState:UIControlStateNormal];
    self.Answer2Correct = YES;
    
}

-(void)question_9
{
    self.questionLabel.text = @"Mirror Master is an arch-enemy of which DC superhero?";
    [self.answer1Button setTitle:@"Flash" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Batman" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"Doctor Fate" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Booster Gold" forState:UIControlStateNormal];
    self.Answer1Correct = YES;
    
}

-(void)question_10
{
    self.questionLabel.text = @"Marvel Comics’ Captain Marvel died from … ?";
    [self.answer1Button setTitle:@"Vampire bite" forState:UIControlStateNormal];
    [self.answer2Button setTitle:@"Head trauma" forState:UIControlStateNormal];
    [self.answer3Button setTitle:@"AIDS complications" forState:UIControlStateNormal];
    [self.answer4Button setTitle:@"Cancer" forState:UIControlStateNormal];
    self.Answer4Correct = YES;
    
}

























@end
