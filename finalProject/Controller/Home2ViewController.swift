//
//  Home2ViewController.swift
//  finalProject
//
//  Created by Andrew Jenson on 3/9/18.
//  Copyright © 2018 Andrew Jenson. All rights reserved.
//

import UIKit
import SafariServices // to display webview

class Home2ViewController: UIViewController {



    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var profileButton: UIButton!

    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var topicView: UIView!

    // Array of UIB
    @IBOutlet var topicButtons: [UIButton]!

    @IBOutlet var topicLabels: [UILabel]!


    // MARK: - Properties

    let formatter = DateFormatter()
    let date = Date()
    let calendar = Calendar.current
    

    // Tips and Topics

    var topics: [Topic] = [] // array of topics
    var tips: [Tip] = []

    var tipArray0 = [Tip]()
    var tipArray1 = [Tip]()
    var tipArray2 = [Tip]()
    var tipArray3 = [Tip]()
    var tipArray4 = [Tip]()
    var tipArray5 = [Tip]()
    var tipArray6 = [Tip]()
    var tipArray7 = [Tip]()
    var tipArray8 = [Tip]() // Now tip array


    override func viewDidLoad() {
        super.viewDidLoad()

        signedInStatus(isSignedIn: true)

        let year = calendar.component(.year, from: date)
        let weekOfYear = calendar.component(.weekOfYear, from: date)
        let weekOfMonth = calendar.component(.weekOfMonth, from: date)
        let weekdayOrdinal = calendar.component(.weekdayOrdinal, from: date)
        let weekday = calendar.component(.weekday, from: date) // Sunday is represented by 1
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)

        print("XXXXXX")
        print(year)
        print("WeekOfYear: \(weekOfYear)")
        print(weekOfMonth)
        print("Weekday: \(weekday)") // Sunday is represented by 1
        print("Month: \(month)")
        print("Day: \(day)")
        print("Hour: \(hour)")
        print("XXXXXX")

    } // End of ViewDidLoad

    func signedInStatus(isSignedIn: Bool) {
        if (isSignedIn) {
            // set estimated row height (needed for auto row height size)
            homeTableView.rowHeight = UITableViewAutomaticDimension
            homeTableView.estimatedRowHeight = 44
            homeTableView.dataSource = self
            homeTableView.delegate = self
            dayOfWeekAndHour()

        }
    }

    func appendNineTopics(_ topic0: Topic, _ topic1: Topic, _ topic2: Topic, _ topic3: Topic,_ topic4: Topic,_ topic5: Topic, _ topic6Now: Topic) {

        // Append selected topics to main array of Topics
        // = [button0, button1, button2, button3, presentDayAndHour]
        topics = [topic0, topic1, topic2, topic3, topic4, topic5, topic6Now]

        // Set-up buttons and labels with current topics
        topicButtons[0].setTitle("\(topics[0].icon)", for: .normal)
        topicLabels[0].text = topics[0].title

        topicButtons[1].setTitle("\(topics[1].icon)", for: .normal)
        topicLabels[1].text = topics[1].title

        topicButtons[2].setTitle("\(topics[2].icon)", for: .normal)
        topicLabels[2].text = topics[2].title

        topicButtons[3].setTitle("\(topics[3].icon)", for: .normal)
        topicLabels[3].text = topics[3].title

        //// Added topic4, topic5, topic6, topic7 (8 buttons total)
        topicButtons[4].setTitle("\(topics[4].icon)", for: .normal)
        topicLabels[4].text = topics[4].title

        topicButtons[5].setTitle("\(topics[5].icon)", for: .normal)
        topicLabels[5].text = topics[5].title


        // set 4 'Now' tips to be displayed in initial table view
        tips = [topics[6].tip[0],
                topics[6].tip[1],
                topics[6].tip[2],
                topics[6].tip[3]
        ]

    }

    func dayOfWeekAndHour() {
        let dayOfWeek = calendar.component(.weekday, from: date)
        let hour = calendar.component(.hour, from: date)

        switch dayOfWeek {
        case 1,7: // S,S
            print("today is a weekend")
            weekend(hour)
        case 2,3,4: // M,T,W
            print("today is a Mon/Tues/Wed")
            weekdayMTW(hour)
        case 5,6:
            print("today is Thur/Fri")
            weekdayTF(hour)
        default:
            print("error with dayAndHour")
            print(dayOfWeek)
            print("^")
        }
    }

    func weekend(_ hour: Int) {
                switch hour {
                case 0...4:
                    print("Weekend, Very Early Morning")
                    // call function to display 9 time-based topics
                    appendNineTopics(lateNightSnackTopic0, meditationTopic0, barTopic0, homeAMTopic0, bedtimeTopic0, journalTopic0, weekendNow0to4Topic0)

                case 5...8:
                    print("Weekend, Early Morning")
                    // call function to display 9 time-based topics
                    appendNineTopics(meditationTopic0, gymTopic0, runningTopic0, yogaTopic0, breakfastTopic0, homeAMTopic0, weekendNow5to8Topic0)

                case 9..<11:
                    print("Weekend, Late Morning")
                    // call function to display 9 time-based topics
                    appendNineTopics(gymTopic0, yogaTopic0, runningTopic0, cafeTopic0, breakfastTopic0, brunchTopic0, weekendNow9to11Topic0)

                case 11..<14:
                    print("Weekend, Midday")
                    appendNineTopics(lunchTopic0, cafeTopic0, shoppingClothesTopic0, groceryStoreTopic0, gymTopic0, yogaTopic0, weekendNow11to14Topic0)

                case 14...16:
                    print("Weekend, Afternoon")
                    // call function to display 9 time-based topics
                    appendNineTopics(cafeTopic0, runningTopic0, yogaTopic0, gymTopic0, mindfulnessTopic0, groceryStoreTopic0, weekendNow14to16Topic0)
                case 17...20:
                    print("Weekend, Evening")
                    // call function to display 9 time-based topics
                    appendNineTopics(dinnerTopic0, homePMTopic0, bathroomTopic0, kitchenTopic0, groceryStoreTopic0, shoppingClothesTopic0, weekendNow17to20Topic0)
                case 21..<24:
                    print("Weekend, Late evening")
                    // call function to display 9 time-based topics
                    appendNineTopics(barTopic0, dateTopic0, homePMTopic0, meditationTopic0, bedtimeTopic0, lateNightSnackTopic0, weekendNow21to24Topic0)
                default:
                    print("Weekend,INVALID HOUR!")
                }
    }

    func weekdayMTW(_ hour: Int) {
        switch hour {
        case 0...4:
            print("weekdayMTW, Very Early Morning")
            // call function to display 9 time-based topics
            appendNineTopics(bedtimeTopic0, lateNightSnackTopic0, homePMTopic0, journalTopic0, meditationTopic0, mindfulnessTopic0, weekdayNow0to4Topic0)
        case 5...8:
            print("weekdayMTW, Early Morning")
            // call function to display 9 time-based topics
            appendNineTopics(meditationTopic0, gymTopic0, journalTopic0, breakfastTopic0, cafeTopic0, commuteAMTopic0, weekdayNow5to8Topic0)

        case 9..<11:
            print("weekdayMTW, Late Morning")
            // call function to display 9 time-based topics
            appendNineTopics(commuteAMTopic0, workAMTopic0, leadershipAMTopic0, courageTopic0, cafeTopic0, mindfulnessTopic0, weekdayNow9to11Topic0)

        case 11..<14:
            print("weekdayMTW, Midday")
            appendNineTopics(workAMTopic0, lunchTopic0, afternoonSnackTopic0, leadershipPMTopic0, courageTopic0, mindfulnessTopic0, weekdayNow11to14Topic0)

        case 14...16:
            print("weekdayMTW, Afternoon")
            // call function to display 9 time-based topics
            appendNineTopics(workPMTopic0, afternoonSnackTopic0, leadershipPMTopic0, courageTopic0, mindfulnessTopic0, commutePMTopic0, weekdayNow11to14Topic0)

        case 17...20:
            print("Weekday, Evening")
            // call function to display 9 time-based topics
            appendNineTopics(workLateTopic0, commutePMTopic0, gymTopic0, groceryStoreTopic0, dinnerTopic0, dateTopic0, weekdayNow17to20Topic0)
        case 21..<24:
            print("Weekday, Late evening")
            // call function to display 9 time-based topics
            appendNineTopics(barTopic0, dateTopic0, lateNightSnackTopic0, homePMTopic0, bedtimeTopic0, meditationTopic0, weekdayNow21to24Topic0)
        default:
            print("Weekday,INVALID HOUR!")
        }
    }

    func weekdayTF(_ hour: Int) {
        switch hour {
        case 0...4:
            print("weekdayTF, Very Early Morning")
            // call function to display 9 time-based topics
            appendNineTopics(bedtimeTopic0, lateNightSnackTopic0, homePMTopic0, meditationTopic0, barTopic0, dateTopic0, weekdayNow0to4Topic0)
        case 5...8:
            print("weekdayTF, Early Morning")
            // call function to display 9 time-based topics
            appendNineTopics(homeAMTopic0, meditationTopic0, gymTopic0, journalTopic0, breakfastTopic0, commuteAMTopic0, weekdayNow5to8Topic0)
        case 9..<11:
            print("weekdayTF, Late Morning")
            // call function to display 9 time-based topics
            appendNineTopics(commuteAMTopic0, workAMTopic0, lunchTopic0, leadershipAMTopic0, courageTopic0, mindfulnessTopic0,  weekdayNow9to11Topic0)

        case 11..<14:
            print("weekdayTF, Midday")
            appendNineTopics(workAMTopic0, lunchTopic0, afternoonSnackTopic0, leadershipPMTopic0, courageTopic0, mindfulnessTopic0, weekdayNow11to14Topic0)

        case 14...16:
            print("weekdayTF, Afternoon")
            // call function to display 9 time-based topics
            appendNineTopics(workPMTopic0, afternoonSnackTopic0, leadershipPMTopic0, courageTopic0, mindfulnessTopic0, commutePMTopic0, weekdayNow11to14Topic0)

        case 17...20:
            print("weekdayTF, Evening")
            // call function to display 9 time-based topics
            appendNineTopics(workLateTopic0, commutePMTopic0, gymTopic0, dinnerTopic0, barTopic0, dateTopic0, weekdayNow17to20Topic0)
        case 21..<24:
            print("weekdayTF, Late evening")
            // call function to display 9 time-based topics
            appendNineTopics(dinnerTopic0, barTopic0, dateTopic0, homePMTopic0, bedtimeTopic0, lateNightSnackTopic0, weekdayNow21to24Topic0)
        default:
            print("weekdayTF,INVALID HOUR!")
        }
    }

    // Table View Methods

//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }





//    func combineDateWithTime(date: Date, time: Date) -> Date? {
//        let calendar = NSCalendar.current
//
//        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
//        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
//
//        var mergedComponments = DateComponents()
//        mergedComponments.year = dateComponents.year!
//        mergedComponments.month = dateComponents.month!
//        mergedComponments.day = dateComponents.day!
//        mergedComponments.hour = timeComponents.hour!
//        mergedComponments.minute = timeComponents.minute!
//        mergedComponments.second = timeComponents.second!
//
//        return calendar.date(from: mergedComponments)
//    }



//    func createHomeCategoryArray(_ hour: Int) -> [HomeCategory] {
//        // create all homeCategory object, put them into a temperory array
//        // then, set homeCategories array equal to temperory array returned in this method
//
//
//
//        if hour < 12 {
//            // AM: create HomeCategory objects
//            let category1 = HomeCategory(icon: "Gy", title: "Gym")
//            let category2 = HomeCategory(icon: "Br", title: "Breakfast")
//            let category3 = HomeCategory(icon: "Me", title: "Meditate")
//            let category4 = HomeCategory(icon: "Jo", title: "Journal")
//
//            tempCategories.append(category1)
//            tempCategories.append(category2)
//            tempCategories.append(category3)
//            tempCategories.append(category4)
//
//        } else if hour >= 12 {
//            // PM: create HomeCategory objects
//            let category1 = HomeCategory(icon: "Di", title: "Dinner")
//            let category2 = HomeCategory(icon: "Gy", title: "Gym")
//            let category3 = HomeCategory(icon: "Sn", title: "Snack")
//            let category4 = HomeCategory(icon: "Jo", title: "Journal")
//
//            tempCategories.append(category1)
//            tempCategories.append(category2)
//            tempCategories.append(category3)
//            tempCategories.append(category4)
//        }
//
//        return tempCategories
//    }


//    func createTopicsAndTips() {
//
//        let day = calendar.component(.day, from: date)
//        let hour = calendar.component(.hour, from: date)
//
//        if day == 1 || day == 7 {
//            print("It's a weekend")
//
//
//        } else {
//            print("It's a weekday")
//
//        }
//
//
//
//
//        if hour < 12 {
//            print("IN THE AM")
////            let tip1 = Tip(title: "Wake up by saying gratitude", body: "Research suggests that starting your day with gratitude...", sourceName: "NY Times", sourceURL: "www.nytimes.com", sponsorLogo: "GM_logo", sponsorURL: "https://www.gm.com/")
////            let tip2 = Tip(title: "Wake up by meditating for 5 minute", body: "Research suggests that starting your day with meditation...", sourceName: "BBC News", sourceURL: "www.bbcnews.com", sponsorLogo: "Coke_logo", sponsorURL: "https://us.coca-cola.com/")
////            let tip3 = Tip(title: "Wake up by drinking a glass of water", body: "Research suggests that starting your day with a glass of water...", sourceName: "Men's Health", sourceURL: "www.menshealth.com", sponsorLogo: "GM_logo", sponsorURL: "https://www.gm.com/")
////            let tip4 = Tip(title: "Wake up by going to the gym", body: "Research suggests that starting with exercise...", sourceName: "Women's Health", sourceURL: "www.womenshealth.com", sponsorLogo: "GM_logo", sponsorURL: "https://www.gm.com/")
////            let tip5 = Tip(title: "Wake up by going to eating oatmeal", body: "Research suggests that starting with oatmeal...", sourceName: "WebMD", sourceURL: "www.webmd.com", sponsorLogo: "Coke_logo", sponsorURL: "https://us.coca-cola.com/")
//
////            tips.append(tip1)
////            tips.append(tip2)
////            tips.append(tip3)
////            tips.append(tip4)
////            tips.append(tip5)
//
//        } else {
//            print("IN THE PM")
//
//
////            let tip1 = Tip(title: "Go to bed by saying gratitude in order to live healthy. Go to bed by saying gratitude in order to live healthy.", body: "1. Research suggests that ending your day with gratitude. 2. Research suggests that ending your day with gratitude. 3. Research suggests that ending your day with gratitude. 5. Research suggests that ending your day with gratitude. 6. Research suggests that ending your day with gratitude. 7. Research suggests that ending your day with gratitude. 8. Research suggests that ending your day with gratitude. 9. Research suggests that ending your day with gratitude. 10. Research suggests that ending your day with gratitude. 11. Research suggests that ending your day with gratitude.", sourceName: "NY Times", sourceURL: "www.nytimes.com", sponsorLogo: "GM_logo", sponsorURL: "https://www.gm.com/")
////            let tip2 = Tip(title: "Go to bed by meditating for 5 minute in order to live healthy.", body: "Research suggests that ending your day with meditation...", sourceName: "BBC News", sourceURL: "www.bbcnews.com", sponsorLogo: "Coke_logo", sponsorURL: "https://us.coca-cola.com/")
////            let tip3 = Tip(title: "Go to bed by drinking a glass of water", body: "Research suggests that ending your day with a glass of water...", sourceName: "Men's Health", sourceURL: "www.menshealth.com", sponsorLogo: "GM_logo", sponsorURL: "https://www.gm.com/")
////            let tip4 = Tip(title: "Go to bed by going to the gym", body: "Research suggests that ending with exercise...", sourceName: "Women's Health", sourceURL: "www.womenshealth.com", sponsorLogo: "GM_logo", sponsorURL: "https://www.gm.com/")
////            let tip5 = Tip(title: "Go to bed by going to eating oatmeal yada, yada, yada. End title.", body: "Research suggests that ending with oatmeal... Research suggests that ending with oatmeal... Research suggests that ending with oatmeal... Research suggests that ending with oatmeal... End.", sourceName: "WebMD", sourceURL: "www.webmd.com", sponsorLogo: "Coke_logo", sponsorURL: "https://us.coca-cola.com/")
//
////            tips.append(tip1)
////            tips.append(tip2)
////            tips.append(tip3)
////            tips.append(tip4)
////            tips.append(tip5)
//
//
//
//        }
//
//    }




    // MARK: - IBActions

    @IBAction func profileButtonTapped(_ sender: RoundButton) {
    }


    @IBAction func topicButtonTapped(_ sender: RoundButton) {
        if let topicNumber = topicButtons.index(of: sender) {
            flipButton(at: topicNumber, withText: topics[topicNumber].icon, on: sender)
            homeTableView.reloadData()
        } else {
            print("ERROR: button tapped not in topicButtons")
        }
    }



    func refreshTopicButtons() {
        topicButtons[0].setTitle("\(topics[0].icon)", for: .normal)
        topicButtons[1].setTitle("\(topics[1].icon)", for: .normal)
        topicButtons[2].setTitle("\(topics[2].icon)", for: .normal)
        topicButtons[3].setTitle("\(topics[3].icon)", for: .normal)
        topicButtons[4].setTitle("\(topics[4].icon)", for: .normal)
        topicButtons[5].setTitle("\(topics[5].icon)", for: .normal)


//        topicButtons[0].backgroundColor = UIColor.blue
//        topicButtons[1].backgroundColor = UIColor.blue
//        topicButtons[2].backgroundColor = UIColor.blue
//        topicButtons[3].backgroundColor = UIColor.blue
//        topicButtons[4].backgroundColor = UIColor.blue
//        topicButtons[5].backgroundColor = UIColor.blue

    }


    func flipButton(at indexNumber: Int, withText text: String, on button: RoundButton) {

        let selectedButtonIcon = "X"

        if button.currentTitle == text {
            print("Tapped a topic button button")
            refreshTopicButtons()
            button.setTitle("\(selectedButtonIcon)", for: .normal)
//            button.backgroundColor = UIColor.gray
            topicSelected(indexNumber)
        } else {
            print("Tapped 'X' button")
            button.setTitle(text, for: .normal)
//            button.backgroundColor = UIColor.blue
            refreshTopicButtons()
            topicSelected(topicButtons.count)
        }
    }

    func topicSelected(_ index: Int) {
        tips = []

        // Take selected index in topics array and subtract 0 because we start with zero
        var counter = (topics[index].tip.count - 1)

        for item in 0...counter {
            print("counter: \(counter)")
            print("index: \(index)")
            print("item: \(item)")
            tips.append(topics[index].tip[item])
        }

//        print("Index: \(index), Number of tips: \(tips.count)")
//        print("Number of topics: \(topics[index].title)")
//        tips.append(topics[index].tip[0])
//        tips.append(topics[index].tip[1])
//        tips.append(topics[index].tip[2])
//        tips.append(topics[index].tip[3])
//        print("Index: \(index), Number of tips: \(tips.count)")
    }

}

extension Home2ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        print("Number of tips in table view: \(tips.count)")
        return tips.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Whatever tip is at each row
        let tip = tips[indexPath.row]
//        let tipCategory = categoryObjectsArray[indexPath.section].sectionObjects[indexPath.row]


        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Home2TableViewCell

        // extend the bottom line
        cell.layoutMargins = UIEdgeInsets.zero

        // configure cell in UITableViewCell file
        cell.configureCell(tip: tip)

        // Tell the UITableViewCell who its delegate is, set it in the table view method. Self is the View Controller because we are in the View Controller file. This is equivalent of giving the boss an intern. The View Controller is the intern of the delegate.
//        cell.delegate = self
//        cell.bodyTextView.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell clicked")
        homeTableView.deselectRow(at: indexPath, animated: true)
        let tip = tips[indexPath.row]

        let app = UIApplication.shared
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Home2TableViewCell
        if let url = tip.sourceURL {

            // print: true or false
            print("verifyURL: \(verifyUrl(urlString: url))")

            if verifyUrl(urlString: url) == true {
                app.open(URL(string:url)!)
            } else {
                performUIUpdatesOnMain {
                    self.createAlert(title: "Invalid URL", message: "Could not open URL")
                }
            }
        }

    }

}

//extension Home2ViewController: UITextViewDelegate {
//    func textViewDidChange(_ textView: UITextView) {
//        let currentOffset = homeTableView.contentOffset
//        UIView.setAnimationsEnabled(false)
//        homeTableView.beginUpdates()
//        homeTableView.endUpdates()
//        UIView.setAnimationsEnabled(true)
//        homeTableView.setContentOffset(currentOffset, animated: false)
//    }
//}

extension Home2ViewController: Home2TableViewCellDelegate {

    func goToSourceURL(url: String) {
        // get the URL from the delegate and presents in Safari VC
        let sponsorURL = URL(string: url)!
        let safariVC = SFSafariViewController(url: sponsorURL)
        present(safariVC, animated: true, completion: nil)

    }


}
