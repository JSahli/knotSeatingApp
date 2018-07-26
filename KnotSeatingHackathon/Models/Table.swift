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
    }

    func addGuest(guest: Guest) {
        var currentGuests = guests ?? [Guest]()
        currentGuests.append(guest)
        self.guests = currentGuests
    }
}
