//
//  JournalViewController.swift
//  finalProject
//
//  Created by Andrew Jenson on 3/9/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import UIKit
import Firebase
import GrowingTextView
import SVProgressHUD
import SafariServices // to display webview

class JournalViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var journalTableView: UITableView!

    // Quote
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    // Nature Pic
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var moodButtonViewHeight: NSLayoutConstraint!

    @IBOutlet weak var hideButton: UIButton!

    @IBOutlet weak var selectedMoodLabel: UILabel!




    // Created individual buttons because Outlet Collection did not work
    @IBOutlet weak var mood0Button: UIButton!
    @IBOutlet weak var mood1Button: UIButton!
    @IBOutlet weak var mood2Button: UIButton!
    @IBOutlet weak var mood3Button: UIButton!
    @IBOutlet weak var mood4Button: UIButton!
    @IBOutlet weak var mood5Button: UIButton!
    @IBOutlet weak var mood6Button: UIButton!
    @IBOutlet weak var mood7Button: UIButton!
    @IBOutlet weak var mood8Button: UIButton!
    @IBOutlet weak var mood9Button: UIButton!
    @IBOutlet weak var mood10Button: UIButton!
    @IBOutlet weak var mood11Button: UIButton!
    @IBOutlet weak var mood12Button: UIButton!
    @IBOutlet weak var mood13Button: UIButton!
    @IBOutlet weak var mood14Button: UIButton!


    // MARK: - Properties

    // pull to refresh tableView
    let refreshControl = UIRefreshControl()

    var advice = JournalQuote(quote: "", source: "")
    var selectedImage: String?
    var tipItems: [JournalTip] = []


    // initial setup
    var messageSentToday = false

    var ref: DatabaseReference!

    // Time and Date
    let formatter = DateFormatter()
    let date = Date()
    let calendar = Calendar.current

    var displayMoodButtonView = true
    var selectedMood = ""

    var expandingCellHeight: CGFloat = 200
    let expandingIndexRow = 0

    // Card Color UI
    var topicColor: UIColor?
    var cellHeaderColor: [UIColor] = []

    // MARK: - Lifecycle Methods

    override func viewDidLayoutSubviews() {
        // Code to adjust size of tableviewHeader
        // Source: https://useyourloaf.com/blog/variable-height-table-view-header/
        super.viewDidLayoutSubviews()
        guard let headerView = journalTableView.tableHeaderView else {
            return
        }
        let size = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            journalTableView.tableHeaderView = headerView
            journalTableView.layoutIfNeeded()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        print("Journal View Controller Will Appear")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if internetConnected() {
//            retrieveMessages()
        } else {
            performUIUpdatesOnMain {
                self.createAlert(title: "No Internet Connection", message: "Not able to retrieve data from database. Please connect to the Internet and try again.")
            }
        }
        setupUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print("Journal View Controller Will Disappear")
    }

    // MARK: - Methods

    func setupUI() {

        dayOfWeekAndHour()

        configureDatabase()

        setupButtonsLabelsTextViews()

        journalTableViewSetup()

    }



    // REMVOED because no longer using textView
//    func setupGestureRecognizers() {
//
//        // Enable Gesture Recognizers
//        let tapGestureTableView = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
//
//        let tapGestureHeaderView = UITapGestureRecognizer(target: self, action: #selector(headerViewTapped))
//        // TODO: could add this for the quote view too
//        journalTableView.addGestureRecognizer(tapGestureTableView)
//        quoteView.addGestureRecognizer(tapGestureHeaderView)
//    }

    func journalTableViewSetup() {
        journalTableView.dataSource = self
        journalTableView.delegate = self
        journalTableView.rowHeight = UITableViewAutomaticDimension
        journalTableView.estimatedRowHeight = 44
        journalTableView.separatorStyle = .none
        self.setupRefreshControl()
    }

    func configureCardViews() {
        // TODO: Add boarder colors
    }


    func setupButtonsLabelsTextViews() {

        if let imageToLoad = selectedImage {
            imageView.image  = UIImage(named: imageToLoad)
        }

        // Set initial quote
        quoteLabel.text = advice.quote
        authorLabel.text = advice.source

        selectedMoodLabel.text = "Increase Self-Awareness, \nSelect Your Mood:"

        hideButton.setTitle("Hide", for: .normal)
        // Shadow and Radius
        hideButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        hideButton.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        hideButton.layer.shadowOpacity = 0.9
        hideButton.layer.shadowRadius = 0.0
        hideButton.layer.masksToBounds = false
        hideButton.layer.cornerRadius = 5.0


        // Quote
//        quoteLabel.text = advice.quote
//        authorLabel.text = advice.source

        // Text Messages
//        messageTextView.layer.borderColor = UIColor.gray.cgColor
//        messageTextView.layer.borderWidth = 1.0
//        // Set messageTextView delegate for UITextFieldDelegate
//        messageTextView.delegate = self
//        messageTextView.trimWhiteSpaceWhenEndEditing = false
//        messageTextView.placeholder = "Text something..."
//        messageTextView.placeholderColor = UIColor(white: 0.8, alpha: 1.0)
//        messageTextView.backgroundColor = UIColor.white
//        messageTextView.layer.cornerRadius = 4.0

        // Buttons
        // Row 1
        mood0Button.setTitle(Constants.SelectedMood.Button0,for: .normal)
        mood1Button.setTitle(Constants.SelectedMood.Button1,for: .normal)
        mood2Button.setTitle(Constants.SelectedMood.Button2,for: .normal)
        mood3Button.setTitle(Constants.SelectedMood.Button3,for: .normal)
        mood4Button.setTitle(Constants.SelectedMood.Button4,for: .normal)
        // Row 2
        mood5Button.setTitle(Constants.SelectedMood.Button5,for: .normal)
        mood6Button.setTitle(Constants.SelectedMood.Button6,for: .normal)
        mood7Button.setTitle(Constants.SelectedMood.Button7,for: .normal)
        mood8Button.setTitle(Constants.SelectedMood.Button8,for: .normal)
        mood9Button.setTitle(Constants.SelectedMood.Button9,for: .normal)
        // Row 3
        mood10Button.setTitle(Constants.SelectedMood.Button10,for: .normal)
        mood11Button.setTitle(Constants.SelectedMood.Button11,for: .normal)
        mood12Button.setTitle(Constants.SelectedMood.Button12,for: .normal)
        mood13Button.setTitle(Constants.SelectedMood.Button13,for: .normal)
        mood14Button.setTitle(Constants.SelectedMood.Button14,for: .normal)
    }

    // MARK: - Refresh Control Methods

    func setupRefreshControl() {
        // add pull to refresh
        refreshControl.addTarget(self, action: #selector(reloadQuote), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        journalTableView.addSubview(refreshControl)
    }

    @objc func reloadQuote() {

        // the method also checks if the refreshControl is refreshing. This will stop and hide the acitivity indicator of the refresh control if it is currently being displayed to the user.
        if self.refreshControl.isRefreshing {
            self.setupUI()
            self.updateAdvice([])
            self.increaseHideButton()
            self.refreshControl.endRefreshing()
        }
    }

    // MARK: - Database Methods

//    func loadMessagesAll() {
//
//        MessageItemService.readMessagesAll(for: User.current) { (retrieveAllMessages) in
//
//            if retrieveAllMessages.isEmpty {
//                print("retrievedMessages count: \(retrieveAllMessages.count)")
//                return
//            }
//            self.messageItems = retrieveAllMessages
//
//            var number = 0
//            print("THREAD: \(Thread.current) + \(number)")
//            number += 1
//            self.configureTableView()
//            self.scrollToBottom()
//            self.journalTableView.reloadData()
//        }
//    }

//    func setupKeyboardObservers() {
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//    }
//
//    @objc func handleKeyboardWillShow(notification: NSNotification) {
//        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
//        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
//    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Important: Need this when working with Observers to avoid memory leak!
        NotificationCenter.default.removeObserver(self)
    }

    // NEW



    func dayOfWeekAndHour() {
        print("Refresh JOURNAL table view")
        let dayOfWeek = calendar.component(.weekday, from: date)
        let hour = calendar.component(.hour, from: date)

        colorOfUI(hour)

        switch dayOfWeek {
        case 1: // Sun
            sunday(hour)
        case 2:
            monday(hour)
        case 3:
            tuesday(hour)
        case 4:
            wednesday(hour)
        case 5:
            thursday(hour)
        case 6:
            friday(hour)
        case 7:
            saturday(hour)
        default:
            print("ERROR: error with dayAndHour")
            print(dayOfWeek)
        }
    }

    func sunday(_ hour: Int) {
        
        switch hour {
        case 0...4:
            // night
            advice = AdviceData.am1a
            selectedImage = Constants.JournalImages.night1
        case 5...9:
            // morning
            advice = AdviceData.am1b
            selectedImage = Constants.JournalImages.morning1
        case 10...13:
            // day
            advice = AdviceData.am1c
            selectedImage = Constants.JournalImages.day1
        case 14...17:
            // afternoon
            advice = AdviceData.pm1a
            selectedImage = Constants.JournalImages.afternoon1
        case 18...21:
            // sunset
            advice = AdviceData.pm1b
            selectedImage = Constants.JournalImages.sunset1
        case 22...24:
            // night
            advice = AdviceData.pm1c
            selectedImage = Constants.JournalImages.night1
        default:
            print("ERROR: INVALID HOUR!")
        }
    }

    func monday(_ hour: Int) {
        switch hour {
        case 0...4:
            // night
            advice = AdviceData.am2a
            selectedImage = Constants.JournalImages.night2
        case 5...9:
            // morning
            advice = AdviceData.am2b
            selectedImage = Constants.JournalImages.morning2
        case 10...13:
            // day
            advice = AdviceData.am2c
            selectedImage = Constants.JournalImages.day2
        case 14...17:
            // afternoon
            advice = AdviceData.pm2a
            selectedImage = Constants.JournalImages.afternoon2
        case 18...21:
            // sunset
            advice = AdviceData.pm2b
            selectedImage = Constants.JournalImages.sunset2
        case 22...24:
            // night
            advice = AdviceData.pm2c
            selectedImage = Constants.JournalImages.night2
        default:
            print("ERROR: INVALID HOUR!")
        }
    }

    func tuesday(_ hour: Int) {
        switch hour {
        case 0...4:
            // night
            advice = AdviceData.am3a
            selectedImage = Constants.JournalImages.night3
        case 5...9:
            // morning
            advice = AdviceData.am3b
            selectedImage = Constants.JournalImages.morning3
        case 10...13:
            // day
            advice = AdviceData.am3c
            selectedImage = Constants.JournalImages.day3
        case 14...17:
            // afternoon
            advice = AdviceData.pm3a
            selectedImage = Constants.JournalImages.afternoon3
        case 18...21:
            // sunset
            advice = AdviceData.pm3b
            selectedImage = Constants.JournalImages.sunset3
        case 22...24:
            // night
            advice = AdviceData.pm3c
            selectedImage = Constants.JournalImages.night3
        default:
            print("ERROR: INVALID HOUR!")
        }
    }

    func wednesday(_ hour: Int) {
        switch hour {
        case 0...4:
            // night
            advice = AdviceData.am4a
            selectedImage = Constants.JournalImages.night4
        case 5...9:
            // morning
            advice = AdviceData.am4b
            selectedImage = Constants.JournalImages.morning4
        case 10...13:
            // day
            advice = AdviceData.am4c
            selectedImage = Constants.JournalImages.day4
        case 14...17:
            // afternoon
            advice = AdviceData.pm4a
            selectedImage = Constants.JournalImages.afternoon4
        case 18...21:
            // sunset
            advice = AdviceData.pm4b
            selectedImage = Constants.JournalImages.sunset4
        case 22...24:
            // night
            advice = AdviceData.pm4c
            selectedImage = Constants.JournalImages.night4
        default:
            print("ERROR: INVALID HOUR!")
        }
    }

    func thursday(_ hour: Int) {
        switch hour {
        case 0...4:
            // night
            advice = AdviceData.am5a
            selectedImage = Constants.JournalImages.night5
        case 5...9:
            // morning
            advice = AdviceData.am5b
            selectedImage = Constants.JournalImages.morning5
        case 10...13:
            // day
            advice = AdviceData.am5c
            selectedImage = Constants.JournalImages.day5
        case 14...17:
            // afternoon
            advice = AdviceData.pm5a
            selectedImage = Constants.JournalImages.afternoon5
        case 18...21:
            // sunset
            advice = AdviceData.pm5b
            selectedImage = Constants.JournalImages.sunset5
        case 22...24:
            // night
            advice = AdviceData.pm5c
            selectedImage = Constants.JournalImages.night5
        default:
            print("ERROR: INVALID HOUR!")
        }
    }

    func friday(_ hour: Int) {
        switch hour {
        case 0...4:
            // night
            advice = AdviceData.am6a
            selectedImage = Constants.JournalImages.night6
        case 5...9:
            // morning
            advice = AdviceData.am6b
            selectedImage = Constants.JournalImages.morning6
        case 10...13:
            // day
            advice = AdviceData.am6c
            selectedImage = Constants.JournalImages.day6
        case 14...17:
            // afternoon
            advice = AdviceData.pm6a
            selectedImage = Constants.JournalImages.afternoon6
        case 18...21:
            // sunset
            advice = AdviceData.pm6b
            selectedImage = Constants.JournalImages.sunset6
        case 22...24:
            // night
            advice = AdviceData.pm6c
            selectedImage = Constants.JournalImages.night6
        default:
            print("ERROR: INVALID HOUR!")
        }
    }

    func saturday(_ hour: Int) {
        switch hour {
        case 0...4:
            // night
            advice = AdviceData.am7a
            selectedImage = Constants.JournalImages.night7
        case 5...9:
            // morning
            advice = AdviceData.am7b
            selectedImage = Constants.JournalImages.morning7
        case 10...13:
            // day
            advice = AdviceData.am7c
            selectedImage = Constants.JournalImages.day7
        case 14...17:
            // afternoon
            advice = AdviceData.pm7a
            selectedImage = Constants.JournalImages.afternoon7
        case 18...21:
            // sunset
            advice = AdviceData.pm7b
            selectedImage = Constants.JournalImages.sunset7
        case 22...24:
            // night
            advice = AdviceData.pm7c
            selectedImage = Constants.JournalImages.night7
        default:
            print("ERROR: INVALID HOUR!")
        }
    }


    func colorOfUI(_ hour: Int) {

        switch hour {
        case 0...4:
            topicColor = NowConstants.HeaderIndigo.color900

        case 5...8:
            topicColor = NowConstants.HeaderAmber.color900

        case 9..<11:
            topicColor = NowConstants.HeaderGreen.color900

        case 11..<14:
            topicColor = NowConstants.HeaderCyan.color900

        case 14...16:
            topicColor = NowConstants.HeaderTeal.color900

        case 17...20:
            topicColor = NowConstants.HeaderRed.color900

        case 21..<24:
            topicColor = NowConstants.HeaderBlue.color900

        default:
            print("ERROR with TopicColor and cellHeaderColor")
        }
    }









    // REMOVED
//    @objc func tableViewTapped() {
//        messageTextView.endEditing(true)
//    }
//
//    @objc func headerViewTapped() {
//        messageTextView.endEditing(true)
//    }

    func configureDatabase() {
        ref = Database.database().reference().child(FirebaseConstants.DbChild.Messages).child(User.current.uid)
    }

    func configureTableView() {
        journalTableView.rowHeight = UITableViewAutomaticDimension
        journalTableView.estimatedRowHeight = 100.0
    }

    // Create the retrieveMessages method
//    func retrieveMessages() {
//
//        SVProgressHUD.show()
//
//        // listen for new messages in the firebase database with 'observe'
//        // Configure database to sync messages
//        // .reference() gets a DatabaseReference for the root of the app's Firebase Database
//        // ask Firebase to 'observe' for any new child's events ('childAdded')
//
//        MessageItemService.readMessagesLastTen(for: User.current) { (retrievedMessages) in
//
//            if retrievedMessages.isEmpty {
//                print("retrievedMessages count: \(retrievedMessages.count)")
//                self.configureTableView()
//                self.journalTableView.reloadData()
//                SVProgressHUD.dismiss()
//                return
//            }
//
//            self.messageItems = retrievedMessages
//
//            var number = 0
//            print("THREAD: \(Thread.current) + \(number)")
//            number += 1
//            self.configureTableView()
//            self.journalTableView.reloadData()
//            self.scrollToBottom()
//            SVProgressHUD.dismiss()
//        }
//    }

//    func scrollToBottom(){
//        DispatchQueue.main.async {
//            let indexPath = IndexPath(row: self.messageItems.count-1, section: 0)
//            self.journalTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//        }
//    }


    // MARK: - IBActions

//    @IBAction func sendButtonPressed(_ sender: UIButton) {
//
//        messageTextView.endEditing(true)
//        messageTextView.isEditable = false
//        sendButton.isEnabled = false
//
//        let now = Date()
//        let formatter = DateFormatter()
//        // initially set the format based on your datepicker date
//        formatter.dateFormat = "MMMM d, yyyy h:mm a"
//        let currentDate = formatter.string(from: now)
//
//        // data we want to save in our database
//        if !messageTextView.text!.isEmpty {
//
//            let messageItem = MessageItem(message: messageTextView.text, timestamp: currentDate)
//
//            MessageItemService.writeMessage(for: User.current, message: messageItem, success: { (success) in
//                if success == true {
//                    print("SUCCESS WRITING MESSAGE: \(success)")
//                    self.messageTextView.text = ""
//                    self.messageTextView.isEditable = true
//                    self.sendButton.isEnabled = true
//                    return
//                } else if success == false {
//                    print("ERROR: NOT ABLE TO SEND MESSAGE")
//                    self.createAlert(title: "ERROR", message: "Unable to write to database. Check your Internet connection and try again.")
//                    self.sendButton.isEnabled = true
//                    return
//                }
//            })
//        }
//    }

    // User Notes:
    // Replace anxious over Stressed
    // Optimistic
    // Loving
    // Good or OK

    // MARK: TODO
    func updateAdvice(_ newTips: [JournalTip]) {

        // update model object

        UIView.animate(withDuration: 0.5) {

            self.selectedMoodLabel.text = "Selected: \(self.selectedMood)"
            // update tableview
            self.tipItems = newTips
            self.configureTableView()
            self.journalTableView.reloadData()
            // Scroll to top
            self.journalTableView.layoutIfNeeded()
            self.journalTableView.contentOffset = CGPoint(x: 0, y: -self.journalTableView.contentInset.top)
        }
    }


    func decreaseHideButton() {
        displayMoodButtonView = !displayMoodButtonView
        moodButtonViewHeight.constant = 0
        hideButton.setTitle("Unhide", for: .normal)
    }

    func increaseHideButton() {
        displayMoodButtonView = !displayMoodButtonView
        moodButtonViewHeight.constant = 130
        hideButton.setTitle("Hide", for: .normal)
    }




    @IBAction func hideButtonTapped(_ sender: Any) {
        displayMoodButtonView = !displayMoodButtonView

        if displayMoodButtonView == false {
            moodButtonViewHeight.constant = 0
            hideButton.setTitle("Unhide", for: .normal)

        } else {
            moodButtonViewHeight.constant = 130
            hideButton.setTitle("Hide", for: .normal)

        }
    }

    func updateQuote(_ item:JournalQuote) {
        quoteLabel.text = item.quote
        authorLabel.text = item.source
    }


    @IBAction func moodButtonTapped(_ sender: UIButton) {

        // Plan to add response in next version of app
        decreaseHideButton()

        switch sender {
        case mood0Button:
            selectedMood = Constants.SelectedMood.Button0
            updateQuote(MoodData.greatQuote0)
            updateAdvice(MoodData.great0Tips1) //*
        case mood1Button:
            selectedMood = Constants.SelectedMood.Button1
            updateQuote(MoodData.goodQuote0)
            updateAdvice(MoodData.good0Tips1) //*
        case mood2Button:
            selectedMood = Constants.SelectedMood.Button2
            updateQuote(MoodData.boredQuote0)
            updateAdvice(MoodData.bored0Tips1) //
        case mood3Button:
            selectedMood = Constants.SelectedMood.Button3
            updateQuote(MoodData.depressedQuote0)
            updateAdvice(MoodData.depressed0Tips1) //*
        case mood4Button:
            selectedMood = Constants.SelectedMood.Button4
            updateQuote(MoodData.sadQuote0)
            updateAdvice(MoodData.sad0Tips1) //*
        case mood5Button:
            selectedMood = Constants.SelectedMood.Button5
            updateQuote(MoodData.proudQuote0)
            updateAdvice(MoodData.proud0Tips1) //*
        case mood6Button:
            selectedMood = Constants.SelectedMood.Button6
            updateQuote(MoodData.hopefulQuote0)
            updateAdvice(MoodData.hopeful0Tips1) //*
        case mood7Button:
            selectedMood = Constants.SelectedMood.Button7
            updateQuote(MoodData.anxietyQuote0)
            updateAdvice(MoodData.anxiety0Tips1) //
        case mood8Button:
            selectedMood = Constants.SelectedMood.Button8
            updateQuote(MoodData.stressedQuote0)
            updateAdvice(MoodData.stressed0Tips1) //*
        case mood9Button:
            selectedMood = Constants.SelectedMood.Button9
            updateQuote(MoodData.madQuote0)
            updateAdvice(MoodData.mad0Tips1) //*
        case mood10Button:
            selectedMood = Constants.SelectedMood.Button10
            updateQuote(MoodData.calmQuote0)
            updateAdvice(MoodData.calm0Tips1) //*
        case mood11Button:
            selectedMood = Constants.SelectedMood.Button11
            updateQuote(MoodData.restlessQuote0)
            updateAdvice(MoodData.restless0Tips1) //*
        case mood12Button:
            selectedMood = Constants.SelectedMood.Button12
            updateQuote(MoodData.insecureQuote0)
            updateAdvice(MoodData.insecure0Tips1) //
        case mood13Button:
            selectedMood = Constants.SelectedMood.Button13
            updateQuote(MoodData.envyQuote0)
            updateAdvice(MoodData.envy0Tips1) //*
        case mood14Button:
            selectedMood = Constants.SelectedMood.Button14
            updateQuote(MoodData.lonelyQuote0)
            updateAdvice(MoodData.lonely0Tips1) //*
        default:
            print("ERROR: No button exists")
            break
        }

        // MARK: No longer sending mood to DB
//        sendMoodToFirebase(selectedMood: selectedMood)

    }

    func sendMoodToFirebase(selectedMood: String) {
        let now = Date()
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "MMMM d, yyyy h:mm a"
        let currentDate = formatter.string(from: now)

        // ****
        let selectedButtonText = "Mood: \(selectedMood)"


        let messageItem = MessageItem(message: selectedButtonText, timestamp: currentDate)

        MessageItemService.writeMessage(for: User.current, message: messageItem, success: { (success) in
            if success == true {
                print("SUCCESS WRITING BUTTON MOOD: \(success)")
            }
        })


    }

    func sendMood(_ moodDictionary: [String:String?]) {

        let currentUID = User.current.uid
        print("CurrentUID: \(currentUID)")

        let messagesDB = ref.child(FirebaseConstants.DbChild.Messages).child(currentUID)
        // like specifying "/Messages/[some_auto_id]"
        // Then, .setValue, sets a value to the key (key value pair)
        messagesDB.childByAutoId().setValue(moodDictionary) {
            (error, reference) in
            // save our messageDictionary inside our messageDB under a random unique identifier. Add a trailing closure
            if error != nil {
                print(error!)
            } else {
                print("Mood saved successfully")
            }
        }
    }


    @IBAction func mediaButtonTapped(_ sender: UIButton) {

//        print("Learn more button tapped")
//
//        let app = UIApplication.shared
//
//        if let url = advice.url {
//
//            // print: true or false
//            print("verifyURL: \(verifyUrl(urlString: url))")
//
//            if verifyUrl(urlString: url) == true {
//                performUIUpdatesOnMain {
//                    app.open(URL(string:url)!)
//                }
//            } else {
//                performUIUpdatesOnMain {
//                    self.createAlert(title: "Could not open URL", message: "Check Internet connection and try again.")
//                }
//            }
//        }
    }




}


// MARK: - TableView Data Source Methods

extension JournalViewController: UITableViewDataSource {



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tipItems.count
    }

    /* Configuring the Timestamp with DateFormatter:
    https://www.makeschool.com/online-courses/tutorials/build-a-photo-sharing-app-9f153781-8df0-4909-8162-bb3b3a2f7a81/improving-the-ui
    */

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath) as! JournalTableViewCell

        let tip = tipItems[indexPath.row]

        // To change UI of cell, see JournalTableViewCell.
        cell.configureCell(tip: tip)

        cell.boarderColorView.layer.borderWidth = 0.5
        cell.boarderColorView.layer.cornerRadius = 5
        cell.boarderColorView.layer.borderColor = topicColor?.cgColor
        cell.boarderColorView.layer.shadowColor = topicColor?.cgColor
        cell.boarderColorView.layer.shadowOpacity = 0.7
        cell.boarderColorView.layer.shadowOffset = CGSize(width: -0.4, height: 1.5)
        cell.boarderColorView.layer.shadowRadius = 2.5

        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 48))
        footerView.backgroundColor = UIColor.clear

        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

}

// MARK: - Table View Delegate

extension JournalViewController: UITableViewDelegate {
    // Add table view delagate methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        journalTableView.deselectRow(at: indexPath, animated: true)
        let tip = tipItems[indexPath.row]

        let app = UIApplication.shared
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath) as! JournalTableViewCell
        if let url = tip.sourceURL {

            // print: true or false
            print("verifyURL: \(verifyUrl(urlString: url))")

            if verifyUrl(urlString: url) == true {
                app.open(URL(string:url)!)
            } else {
                performUIUpdatesOnMain {
                    self.createAlert(title: "Could not open URL", message: "Check your Internet connection and try again.")
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let messageItemRow = messageItems[indexPath.row]
//            print("ITEM TO DELETE")
//            print("goalItemRow: \(messageItemRow)")
//
//            // Alternative Firebase Code:
//            //            // Code doesn't seem as efficient as code below to removeValue()
//            //            GoalItemService.deleteGoal(for: User.current, goal: goalItemRow, success: { (success) in
//            //                if success == true {
//            //                    print("SUCCESS WRITING GOAL: \(success)")
//            //                    return
//            //                }
//            //            })
//
//            // Firebase
//            messageItemRow.ref?.removeValue()
//        }
//    }


}

// MARK: - Table View Cell Methods

extension JournalViewController: JournalTableViewCellDelegate {

    func goToSourceURL(url: String) {
        // get the URL from the delegate and presents in Safari VC
        let sponsorURL = URL(string: url)!
        let safariVC = SFSafariViewController(url: sponsorURL)
        present(safariVC, animated: true, completion: nil)
    }
}









