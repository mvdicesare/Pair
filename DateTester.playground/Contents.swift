import UIKit

//var str = "Hello, playground"
//
//func stringToDate(string: String) -> Date? {
//    let formatter = DateFormatter()
//    return formatter.date(from: string)
//}
//
//print(stringToDate(string: "2019-10-29"))
//


func dayOfWeek(_ date: String) -> String {
    let formater = DateFormatter()
    formater.dateFormat = "yyyy-MM-dd"
    guard let todayDate = formater.date(from: date) else {return "unknown"}
    let myCalander = Calendar(identifier: .gregorian)
    let weekDay = myCalander.component(.weekday, from: todayDate)
        switch weekDay {
    case 1 :
        return "Monday"
    case 2 :
        return "Tuesday"
    case 3 :
        return "Wednesday"
    case 4 :
        return "Thursday"
    case 5 :
        return "Friday"
    case 6 :
        return "Saterday"
    case 7 :
        return "Sunday"
    default:
        return "Unknown"
    }
}

dayOfWeek("2019-10-29")
