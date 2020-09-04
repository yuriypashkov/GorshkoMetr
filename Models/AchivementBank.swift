
import Foundation


class AchivementBank {
    
    var achivementsArray: [Achivement] = [
        Achivement(imageName: "0_Color", title: "Салага", message: "1 концерт просмотрен", isAchived: false),
        Achivement(imageName: "1_Color", title: "Кишолог", message: "10 концертов просмотрено", isAchived: false),
        Achivement(imageName: "2_Color", title: "Кандидат кишелогических наук", message: "100 концертов просмотрено", isAchived: false),
        Achivement(imageName: "3_Color", title: "Кишедемик", message: "200 концертов просмотрено", isAchived: false),
        Achivement(imageName: "4_Color", title: "Кишевед", message: "300 концертов просмотрено", isAchived: false),
        Achivement(imageName: "5_Color", title: "Поручик", message: "1 квиз пройден", isAchived: false),
        Achivement(imageName: "6_Color", title: "Балу", message: "10 квизов пройдено", isAchived: false),
        Achivement(imageName: "7_Color", title: "Яков", message: "25 квизов пройдено", isAchived: false),
        Achivement(imageName: "8_Color", title: "Князь", message: "50 квизов пройдено", isAchived: false),
        Achivement(imageName: "9_Color", title: "Горшок", message: "100 квизов пройдено", isAchived: false),
        Achivement(imageName: "10_Color", title: "Оступившийся", message: "Поймал 1 баян", isAchived: false),
        Achivement(imageName: "11_Color", title: "Баянист", message: "Поймал 50 баянов", isAchived: false),
        Achivement(imageName: "12_Color", title: "Горшок", message: "Поймал 100 баянов", isAchived: false),
        Achivement(imageName: "13_Color", title: "Медаль за отвагу", message: "Запустил приложение 100 раз", isAchived: false),
        Achivement(imageName: "14_Color", title: "Ещё одна", message: "Запустил приложение 200 раз", isAchived: false),
        Achivement(imageName: "15_Color", title: "Дурак и приложение", message: "Запускал приложение 300 раз", isAchived: false),
        Achivement(imageName: "16_Color", title: "Ты не знаешь, что такое жизнь", message: "Поймал 100 пивасиков в игре", isAchived: false),
        Achivement(imageName: "17_Color", title: "Мертвый анархист", message: "Поймал 100 застывших факов в игре", isAchived: false),
        Achivement(imageName: "18_Color", title: "Похороненный панк", message: "Поймал 100 грибов в игре", isAchived: false),
        Achivement(imageName: "19_Color", title: "Охотник", message: "Провёл в игре 1 минуту", isAchived: false),
        Achivement(imageName: "20_Color", title: "Мужик с мясом", message: "Провёл в игре 10 минут", isAchived: false),
        Achivement(imageName: "21_Color", title: "Лесник", message: "Провёл в игре 1 час", isAchived: false),
        Achivement(imageName: "22_Color", title: "Куколд колдуна", message: "Провёл в игре 10 часов", isAchived: false),
        Achivement(imageName: "23_Color", title: "Зачем?", message: "Провёл в игре 24 часа", isAchived: false)
    ]
    
    let defaults = UserDefaults.standard
    var countKey: Int
    var scoreKey: Int
    var correctAnswers: Int
    var quizPassed: Int
    var percent = 0.0
    var launchCount: Int
    var itemsLost: Int
    var trashItems: Int
    var bayanCount: Int
    var timeInGame: Int
    
    var beerInGame: Int
    var fuckInGame: Int
    var mushroomInGame: Int
    
    init() {
        countKey = defaults.integer(forKey: "countKey")
        scoreKey = defaults.integer(forKey: "scoreKey")
        correctAnswers = defaults.integer(forKey: "correctAnswers")
        quizPassed = defaults.integer(forKey: "quizPassed")
        
        if defaults.integer(forKey: "answersCount") != 0 {
            let answersCount = defaults.double(forKey: "answersCount")
            percent = (Double(correctAnswers) / answersCount) * 100
        }
        
        launchCount = defaults.integer(forKey: "launchCount")
        itemsLost = defaults.integer(forKey: "itemsLost")
        trashItems = defaults.integer(forKey: "trashItems")
        bayanCount = defaults.integer(forKey: "bayanCount")
        timeInGame = defaults.integer(forKey: "timeInGame")
        
        beerInGame = defaults.integer(forKey: "beerInGame")
        fuckInGame = defaults.integer(forKey: "fuckInGame")
        mushroomInGame = defaults.integer(forKey: "mushroomInGame")
        
        // ачивки за число концертов
        if countKey >= 1 { achivementsArray[0].isAchived = true }
        if countKey >= 10 { achivementsArray[1].isAchived = true }
        if countKey >= 100 { achivementsArray[2].isAchived = true }
        if countKey >= 200 { achivementsArray[3].isAchived = true }
        if countKey >= 300 { achivementsArray[4].isAchived = true }
        
        // ачивки за пройденные квизы
        if quizPassed >= 1 { achivementsArray[5].isAchived = true }
        if quizPassed >= 10 { achivementsArray[6].isAchived = true }
        if quizPassed >= 25 { achivementsArray[7].isAchived = true }
        if quizPassed >= 50 { achivementsArray[8].isAchived = true }
        if quizPassed >= 100 { achivementsArray[9].isAchived = true }
        
        // баяны
        if bayanCount >= 1 { achivementsArray[10].isAchived = true }
        if bayanCount >= 50 { achivementsArray[11].isAchived = true }
        if bayanCount >= 100 { achivementsArray[12].isAchived = true }
        
        // медальки за запуск
        if launchCount >= 100 { achivementsArray[13].isAchived = true}
        if launchCount >= 200 { achivementsArray[14].isAchived = true}
        if launchCount >= 300 { achivementsArray[15].isAchived = true}
        
        //новые ачивки
        if beerInGame >= 100 { achivementsArray[16].isAchived = true }
        if fuckInGame >= 100 { achivementsArray[17].isAchived = true }
        if mushroomInGame >= 100 { achivementsArray[18].isAchived = true }
        
        // время в игре
        if timeInGame >= 60 { achivementsArray[19].isAchived = true }
        if timeInGame >= 600 { achivementsArray[20].isAchived = true }
        if timeInGame >= 3600 { achivementsArray[21].isAchived = true }
        if timeInGame >= 36000 { achivementsArray[22].isAchived = true }
        if timeInGame >= 86400 { achivementsArray[23].isAchived = true }
    }
    
    
}
