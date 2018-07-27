import UIKit

class Table: NSObject {
    var number: Int?
    var guests: [Guest]?
    var assetImage: UIImage
    var maxLimit: Int
    var tableType: TableType

    init(number: Int? = nil, assetImage: UIImage, maxLimit: Int, guests: [Guest]?, tableType: TableType) {
        self.number = number
        self.guests = guests
        self.assetImage = assetImage
        self.maxLimit = maxLimit
        self.tableType = tableType
        super.init()
    }

    func addGuest(guest: Guest) {
        var currentGuests = guests ?? [Guest]()
        currentGuests.append(guest)
        self.guests = currentGuests
    }

    func set(tableNumber number: Int) {
        self.number = number
    }

    var remainingCapacity: Int {
        if let guests = guests {
            return maxLimit - guests.count
        }
        return maxLimit
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
        case circle = 8
        case square = 10
        case rectangle = 12

        static var allCases: [TableType] {
            return [.circle, .square, .rectangle]
        }
    }
}


