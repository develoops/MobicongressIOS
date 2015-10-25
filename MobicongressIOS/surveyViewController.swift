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
        self.view.backgroundColor = UIColor(red: 253.0, green: 253.0, blue: 253.0, alpha: 0.99)
        var formatoLabel = UIFont.boldSystemFontOfSize(14.5)
        self.statementLabel = UILabel(frame: CGRectMake(5, 0, self.view.frame.width - 10, 100))
        self.statementLabel.textAlignment = NSTextAlignment.Center
        self.statementLabel.font = formatoLabel
        self.statementLabel.numberOfLines = 5
        self.view.addSubview(self.statementLabel)

        
        if(userDefolto.boolForKey("survey") == false) {
      
            if(Reachability.reachabilityForInternetConnection().currentReachabilityString == "No Connection")
            {
                let alertView = UIAlertView(title: "Sorry", message: "To access the function assessment must be connected to a network of Internet", delegate: self, cancelButtonTitle: "OK")
                alertView.alertViewStyle = .Default
                alertView.show()
            }
            else{

            self.queryStatements().continueWithExecutor(BFExecutor.mainThreadExecutor(), withBlock: { (task:BFTask!) -> AnyObject! in
            
            let sort = NSSortDescriptor(key:"question", ascending: true, selector: "localizedStandardCompare:")
            let statementPredicate = NSPredicate(format: "type ==%@", "statement")
            let optionPredicate = NSPredicate(format: "type ==%@", "option")
        
            self.questionsArray = task.result as! NSArray
            
            let object = self.questionsArray.objectAtIndex(self.questionIndex) as! NSArray
    
            let statement = object.filteredArrayUsingPredicate(statementPredicate).first as! PFObject
            let statementText = statement.objectForKey("item") as! PFObject
            
            let optionsFiltered = object.filteredArrayUsingPredicate(optionPredicate)
            
            self.setQuestionOptions()
            self.statementLabel.text = statementText.objectForKey("text") as? String

            return task
        })
            }
        }
        else{
            
            self.statementLabel.text = "You are already answer the survey, Thanks"
        }
    }
    
    func setQuestionOptions() {
    
        let statementPredicate = NSPredicate(format: "type ==%@", "statement")
        let optionPredicate = NSPredicate(format: "type ==%@", "option")
        let sort = NSSortDescriptor(key: "sequencePosition", ascending: true)

        let object = self.questionsArray.objectAtIndex(self.questionIndex) as! NSArray
        
        let statement = object.filteredArrayUsingPredicate(statementPredicate).first as! PFObject
        let statementText = statement.objectForKey("item") as! PFObject
        
        let optionsFiltered = object.filteredArrayUsingPredicate(optionPredicate) as NSArray
        let optionsFilteredSorted = optionsFiltered.sortedArrayUsingDescriptors([sort])
        
        self.statementLabel.text = statementText.objectForKey("text") as? String
        
        for var i = 0; i < optionsFiltered.count; ++i {
            let flo = CGFloat((45 * i) + 100)
            var formatoLabel = UIFont(name: "ArialMT", size: 13.5) as UIFont!
            let option = optionsFilteredSorted[i] as! PFObject
            let answer = option.objectForKey("item") as! PFObject
            let answerText = answer.objectForKey("text") as? String
           
            let answerButton = UIButton(frame: CGRectMake(10,flo, self.view.frame.width - 20, 30))
            
            answerButton.titleLabel!.textAlignment = NSTextAlignment.Center
            answerButton.titleLabel?.font = formatoLabel
            answerButton.setBackgroundImage(UIImage(named: "fondoPregunta"), forState: .Normal)
            answerButton.setTitle(answerText, forState: .Normal)
            answerButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
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
