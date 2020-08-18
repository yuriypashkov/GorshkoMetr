
import Foundation


class AchivementBank {
    
    var achivementsArray: [Achivement] = [
        Achivement(imageName: "bat", title: "Салага", message: "Первый рубеж взят. 1 концерт просмотрен", isAchived: false),
        Achivement(imageName: "skull", title: "Кишолог", message: "Ты невероятно хорош, ибо посмотрел 10 концертов КиШа", isAchived: false),
        Achivement(imageName: "zombie", title: "Кандидат кишелогических наук", message: "Тобой просмотрено 100 концертов, это очень мощно", isAchived: false),
        Achivement(imageName: "bat", title: "Кишедемик", message: "Позади 200 концертов, фантастика!", isAchived: false),
        Achivement(imageName: "skull", title: "Кишевед", message: "Цифра в 300 концертов казалась недостижимой, но ты справился!", isAchived: false),
        Achivement(imageName: "bat", title: "Поручик", message: "1 квиз пройден", isAchived: false),
        Achivement(imageName: "bat", title: "Балу", message: "10 квизов пройдено", isAchived: false),
        Achivement(imageName: "bat", title: "Яков", message: "25 квизов пройдено", isAchived: false),
        Achivement(imageName: "bat", title: "Князь", message: "50 квизов пройдено", isAchived: false),
        Achivement(imageName: "bat", title: "Горшок", message: "100 квизов пройдено", isAchived: false),
        Achivement(imageName: "bat", title: "Оступившийся", message: "Поймал 1 баян", isAchived: false),
        Achivement(imageName: "bat", title: "Баянист", message: "Поймал 50 баянов", isAchived: false),
        Achivement(imageName: "bat", title: "Горшок", message: "Поймал 100 баянов", isAchived: false),
        Achivement(imageName: "bat", title: "Медаль за отвагу", message: "Запустил приложение 100 раз", isAchived: false),
        Achivement(imageName: "bat", title: "Ещё одна", message: "Запустил приложение 200 раз", isAchived: false),
        Achivement(imageName: "bat", title: "Дурак и приложение", message: "Запускал приложение неделю подряд", isAchived: false),
        Achivement(imageName: "bat", title: "Ты не знаешь, что такое жизнь", message: "Запускал приложение 2 недели подряд", isAchived: false),
        Achivement(imageName: "bat", title: "Мертвый анархист", message: "Запускал приложение 3 недели подряд", isAchived: false),
        Achivement(imageName: "bat", title: "Похороненный панк", message: "Запускал приложение 4 недели подряд", isAchived: false),
        Achivement(imageName: "bat", title: "Охотник", message: "Провёл в игре 1 минуту", isAchived: false),
        Achivement(imageName: "bat", title: "Мужик с мясом", message: "Провёл в игре 10 минут", isAchived: false),
        Achivement(imageName: "bat", title: "Лесник", message: "Провёл в игре 1 час", isAchived: false),
        Achivement(imageName: "bat", title: "Куколд колдуна", message: "Провёл в игре 10 часов", isAchived: false),
        Achivement(imageName: "bat", title: "Зачем?", message: "Провёл в игре 24 часа", isAchived: false)
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
        
        // за недели запуска
        
        // время в игре
        if timeInGame >= 60 { achivementsArray[19].isAchived = true }
        if timeInGame >= 600 { achivementsArray[20].isAchived = true }
        if timeInGame >= 3600 { achivementsArray[21].isAchived = true }
        if timeInGame >= 36000 { achivementsArray[22].isAchived = true }
        if timeInGame >= 86400 { achivementsArray[23].isAchived = true }
    }
    
    
}
