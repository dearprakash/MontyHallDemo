import UIKit

/*
 - Randomize
 - Ask user to Select one option
 - Mark the selected option
 - Open one incorrect option
 - Ask user to Switch / Stay
 - Show the correct answer
 */


class ViewController: UIViewController {
    @IBOutlet weak var OptionButtonA: UIButton!
    @IBOutlet weak var OptionButtonB: UIButton!
    @IBOutlet weak var OptionButtonC: UIButton!
    @IBOutlet weak var imagesStackView: UIStackView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var askToSwitchOrStay: UILabel!
    
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var stayButton: UIButton!
    var options: [MontyBox] = []
    var show = Show()
    var choice: Int? = nil

    @IBAction func reset(_ sender: Any) {
        OptionButtonA.layer.borderColor = UIColor.clear.cgColor
        OptionButtonB.layer.borderColor = UIColor.clear.cgColor
        OptionButtonC.layer.borderColor = UIColor.clear.cgColor
        resultLabel.text = ""

        show = Show()
        choice = nil
        setup()
    }

    @IBAction func handleSwitch(_ sender: Any) {
        showAnswer()
        if choice == show.winningIndex {
            resultLabel.text = "❌"
        } else {
            resultLabel.text = "🎊"
        }
    }

    @IBAction func handleStay(_ sender: Any) {
        showAnswer()
        if choice == show.winningIndex {
            resultLabel.text = "🎊"
        } else {
            resultLabel.text = "❌"
        }
    }
    
    @IBAction func handleInitialAction(_ sender: Any) {
        if let button = sender as? UIButton {
            guard choice == nil else { return }
            
            choice = button.tag
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.blue.cgColor

            let itemToOpen = show.otherWrongBox(for: button.tag)
            showImage(at: itemToOpen)
            switchButton.isHidden = false
            stayButton.isHidden = false

            askToSwitchOrStay.text = "You have selected Box \(choice!). But we have opened Box \(itemToOpen) and it looks wrong!! Do you like to change your mind or stick with your choice?"
        }
    }

    func showImage(at index: Int) {
        for view in imagesStackView.arrangedSubviews {
            guard let iv = view as? UIImageView else { return }
            if iv.tag == index {
                iv.image = UIImage(systemName: "xmark.circle.fill")
            }
        }
    }

    func showAnswer() {
        for view in imagesStackView.arrangedSubviews {
            guard let iv = view as? UIImageView else { return }
            if iv.tag == show.winningIndex {
                iv.image = UIImage(systemName: "checkmark.circle.fill")
            } else {
                iv.image = UIImage(systemName: "xmark.circle.fill")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        options = show.boxesForCurrentShow()
        for view in imagesStackView.arrangedSubviews {
            if let iv = view as? UIImageView {
                iv.image = UIImage(systemName: "questionmark.circle.fill")
            }
        }
        switchButton.isHidden = true
        stayButton.isHidden = true
        
    }
}

