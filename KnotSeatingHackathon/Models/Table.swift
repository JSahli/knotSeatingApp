import UIKit

class Table: NSObject {
    var guests = [Guest] ()
    let number: Int
    var assetImage: UIImage
    var maxLimit: Int
    var tableType: TableType

    init(number: Int, guests: [Guest] = [Guest](), tableType: TableType) {
        self.number = number
        self.guests = guests
        self.assetImage = tableType.assetImage
        self.maxLimit = tableType.capacity
        self.tableType = tableType
        super.init()
    }

    func addGuest(guest: Guest) {
        guests.append(guest)
    }

    func removeGuest(guest: Guest) -> Bool {
        if let index = guests.index(of: guest) {
            guest.seatedAtTable = nil
            guests.remove(at: index)
            return true
        }
        return false
    }

//    func set(tableNumber number: Int) {
//        self.number = number
//    }

    var remainingCapacity: Int {
        return maxLimit - guests.count
    }


    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width:size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

    enum TableType: Int {
        case circle
        case square
        case rectangle

        var capacity: Int {
            switch self {
            case .circle:
                return 8
            case .rectangle:
                return 12
            case .square:
                return 10
            }
        }

        var assetImage: UIImage {
            switch self {
            case .circle:
                return #imageLiteral(resourceName: "table_circle")
            case .rectangle:
                return #imageLiteral(resourceName: "table_rectangle")
            case .square:
                return #imageLiteral(resourceName: "table_square")
            }
        }

        static var allCases: [TableType] {
            return [.circle, .square, .rectangle]
        }
    }
}


