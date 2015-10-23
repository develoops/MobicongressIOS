//
//  surveyViewController.swift
//  MobicongressIOS
//
//  Created by Arturo Sanhueza on 20-10-15.
//  Copyright (c) 2015 mobiCongress. All rights reserved.
//

import UIKit

class surveyViewController: UIViewController {
    
    var questionIndex = Int()
    var statementLabel = UILabel()
    var questionsArray = NSArray()
    var arrayButtons = NSMutableArray()
    var user = PFUser.currentUser()
    var userDefolto = NSUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Survey"
        self.questionIndex = 0
        self.queryStatements().continueWithExecutor(BFExecutor.mainThreadExecutor(), withBlock: { (task:BFTask!) -> AnyObject! in


            let sort = NSSortDescriptor(key:"question", ascending: true, selector: "localizedStandardCompare:")
            let statementPredicate = NSPredicate(format: "type ==%@", "statement")
            let optionPredicate = NSPredicate(format: "type ==%@", "option")
        
            self.questionsArray = task.result as! NSArray
            
            let object = self.questionsArray.objectAtIndex(self.questionIndex) as! NSArray
    
            let statement = object.filteredArrayUsingPredicate(statementPredicate).first as! PFObject
            let statementText = statement.objectForKey("item") as! PFObject
            
            let optionsFiltered = object.filteredArrayUsingPredicate(optionPredicate)
            
            self.statementLabel = UILabel(frame: CGRectMake(35, 0, 300, 100))
            self.statementLabel.textAlignment = NSTextAlignment.Center
            self.statementLabel.numberOfLines = 5
            self.statementLabel.text = statementText.objectForKey("text") as? String
            self.view.addSubview(self.statementLabel)
            self.setQuestionOptions()

            return task
        })
    
    }
    
    
    func setQuestionOptions() {
    
        let statementPredicate = NSPredicate(format: "type ==%@", "statement")
        let optionPredicate = NSPredicate(format: "type ==%@", "option")
        
        let object = self.questionsArray.objectAtIndex(self.questionIndex) as! NSArray
        
        let statement = object.filteredArrayUsingPredicate(statementPredicate).first as! PFObject
        let statementText = statement.objectForKey("item") as! PFObject
        
        let optionsFiltered = object.filteredArrayUsingPredicate(optionPredicate)
        
        self.statementLabel.text = statementText.objectForKey("text") as? String
        
        for var i = 0; i < optionsFiltered.count; ++i {
            let flo = CGFloat((60 * i) + 100)
            
            let option = optionsFiltered[i] as! PFObject
            let answer = option.objectForKey("item") as! PFObject
            let answerText = answer.objectForKey("text") as? String
           
            let answerButton = UIButton(frame: CGRectMake(0,flo, 200, 50))
            answerButton.titleLabel!.textAlignment = NSTextAlignment.Left

            answerButton.setTitle(answerText, forState: .Normal)
            answerButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
            answerButton.addTarget(self, action: "nextQuestion:", forControlEvents: .TouchUpInside)
           
            self.arrayButtons.addObject(answerButton)
            self.view.addSubview(answerButton)
        }
    }

    func queryQuestionnarieQuestions() -> BFTask{
    let questionQuery = PFQuery(className: "Question2Article")
        questionQuery.includeKey("item")
        questionQuery.includeKey("question")
        return questionQuery.findObjectsInBackground()
    }
    
    func postAnswer(question:String,answer:String) ->BFTask{
    
        let answerObject = PFObject(className: "Answer")
        answerObject.setObject(self.user!, forKey: "user")
        answerObject.setObject(answer, forKey: "respuesta")
        answerObject.setObject(question, forKey: "pregunta")
       return answerObject.saveInBackground()
    }
    
    func queryStatements() ->BFTask{

        var taskC = BFTaskCompletionSource()
        let questions = NSMutableArray()
        queryQuestionnarieQuestions().continueWithBlock { (task:BFTask!) -> AnyObject! in
            let sort = NSSortDescriptor(key: "question.name", ascending: true)
            let statementPredicate = NSPredicate(format: "type == %@", "statement")
            let statementsArray = task.result.filteredArrayUsingPredicate(statementPredicate) as NSArray
            let statementsArraySorted = statementsArray.sortedArrayUsingDescriptors([sort]) as NSArray

            for statement in statementsArraySorted {
            let questionStatement = statement["question"] as! PFObject
                let optionPredicate = NSPredicate(format: "question == %@", questionStatement)
                let question = task.result.filteredArrayUsingPredicate(optionPredicate)
                
                questions.addObject(question)
            }

            taskC.setResult(questions)

            return task
       }
        
        return taskC.task
    }
    
    func nextQuestion(sender:UIButton){
        
        if(questionIndex != self.questionsArray.count - 1){
            questionIndex = questionIndex + 1
            let question = self.statementLabel.text
            let answer = sender.titleLabel?.text
            
            self.postAnswer(self.statementLabel.text!, answer:answer!).continueWithBlock({ (task:BFTask!) -> AnyObject! in
                
                return task
            })
            
            for button in self.arrayButtons {
                
                button.removeFromSuperview()
                self.arrayButtons.removeObjectIdenticalTo(button)
            }

            self.setQuestionOptions()
            
        }
        else {
            userDefolto.setBool(true, forKey: "survey")
            userDefolto.synchronize()
            self.statementLabel.text = "Thanks"
            for button in self.arrayButtons {
                
                button.removeFromSuperview()
                self.arrayButtons.removeObjectIdenticalTo(button)
            }
        }
        
    }
    
    func prevQuestion(sender:UIButton){
        
        questionIndex = questionIndex--
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
