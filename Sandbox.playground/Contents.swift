//: A UIKit based Playground for presenting user interface
  
import UIKit

struct MontyBox {
    let index: Int
    let content: String
}

class Show {
    let winningIndex = Int(arc4random_uniform(3)) + 1

    func boxesForCurrentShow() -> [MontyBox] {
        var boxes = [MontyBox]()
        for index in 1...3 {
            if index == winningIndex {
                boxes.append(MontyBox(index: index, content: "checkmark.circle.fill"))
            } else {
                boxes.append(MontyBox(index: index, content: "xmark.circle.fill"))
            }
        }
        return boxes
    }

    func otherWrongBox(for selectedBoxIndex: Int) -> Int {
        print("Current Winning Index: \(winningIndex)")
        let boxes = boxesForCurrentShow()

        if selectedBoxIndex == winningIndex {
            let otherWrong = boxes.first { (box) -> Bool in
                box.index != winningIndex
            }
            print("Returning \(otherWrong!.index)")
            return otherWrong!.index
        } else {
            let remaining = boxes.first { (box) -> Bool in
                box.index != selectedBoxIndex && box.index != winningIndex
            }
            print("Returning \(remaining!.index)")
            return remaining!.index
        }

    }
}

let show = Show()
let boxes = show.boxesForCurrentShow()
let other = show.otherWrongBox(for: 3)
