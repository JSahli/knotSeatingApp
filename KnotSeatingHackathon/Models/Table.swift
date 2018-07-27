import UIKit

class Table: NSObject {
    var number: Int
    var guests: [Guest]?
    var assetImage: UIImage
    var maxLimit: Int

    init(number: Int, assetImage: UIImage, maxLimit: Int, guests: [Guest]?) {
        self.number = number
        self.guests = guests
        self.assetImage = assetImage
        self.maxLimit = maxLimit
        super.init()
//        if let image = resizeImage(image: assetImage, targetSize: CGSize(width: 150.0, height: 150.0)) {
//            self.assetImage = image
//        }
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
}
