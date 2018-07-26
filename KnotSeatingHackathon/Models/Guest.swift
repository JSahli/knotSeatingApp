import Foundation

class Guest: NSObject {
    var firstName: String
    var lastName: String
    var group: String
    var seated: Bool = false

    var fullName: String {
        return "\(firstName) \(lastName)"
    }

    init(firstName: String, lastName: String, group: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.group = group
    }

    static func dummyGuests() -> [Guest] {
        let guests =
        [Guest(firstName: "Hamid", lastName: "Tavakoli", group: "iOS Friends"),
         Guest(firstName: "Ben", lastName: "Mayer", group: "iOS Friends"),
         Guest(firstName: "Jen", lastName: "Sipila", group: "iOS Friends"),
         Guest(firstName: "Jesse", lastName: "Sahli", group: "iOS Friends"),
         Guest(firstName: "Erica", lastName: "Correa", group: "iOS Friends"),
         Guest(firstName: "George", lastName: "Correa", group: "iOS Friends"),
         Guest(firstName: "Daniel", lastName: "Burbank", group: "iOS Friends"),
         Guest(firstName: "Stephen", lastName: "Bradley", group: "iOS Friends"),
         Guest(firstName: "Krishna", lastName: "Ramachandran", group: "iOS Friends"),
         Guest(firstName: "Felix", lastName: "Gregory", group: "Family"),
         Guest(firstName: "Bridget", lastName: "Gregory", group: "Friends"),Guest(firstName: "John", lastName: "Harte", group: "Family"),
         Guest(firstName: "Cara", lastName: "Harte", group: "Family"),
         Guest(firstName: "Diane", lastName: "Gregory", group: "Family"),
         Guest(firstName: "Gaia", lastName: "Claudel", group: "Friends"),
         Guest(firstName: "Karl", lastName: "Sredl", group: "Friends"),
         Guest(firstName: "Mario", lastName: "Johnson", group: "Friends"),
         Guest(firstName: "Roxy", lastName: "Morganella", group: "Friends"),
         Guest(firstName: "Rufus", lastName: "Sabatello", group: "Intramural team"),
         Guest(firstName: "Zeb", lastName: "Harbron", group: "Intramural team"),
         Guest(firstName: "York", lastName: "Berson", group: "Intramural team"),
         Guest(firstName: "Mimi", lastName: "Kotter", group: "Intramural team")
         ]
        return guests
    }
}
