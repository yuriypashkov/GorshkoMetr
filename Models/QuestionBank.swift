
import Foundation

class QuestionBank {
    var list = [Question]()
    var arrayOfData = [
                       "Назовите титул вокалиста и автора текстов группы Король и Шут#Король#Царь#Князь#Владыка#3",
                        "Как звали скрипачку группы Король и Шут?#Даша#Маша#Саша#Глаша#2",
                        "Как Горшок потерял зубы?#Драка#Амфетамин#Турник#Старость#3",
                        "Кто нарисовал большинство рисунков группы Король и Шут?#Князь#Горшок#Балу#Поручик#1",
                        "Из-за какого вещества умер Горшок?#Героин#Этанол#Кокаин#Все вместе#4",
                        "Где долгое время хранился знаменитый кожаный плащ Горшка?#КастлРок#Эрмитаж#Кунксткамера#Думская улица#1",
                        "В 1999-м году в клубе Спартак прошёл один из самых мощных концертов в истории группы. Что ныне находится на этом месте?#Баня#Анненкирхе#Пятёрочка#Бар Depeche Mode Spb#2",
                        "Где прошёл последний концерт группы Король и Шут?#Селигер#Казантип#Нашествие#На даче Балу#3",
                        "Сколько посмертных концертов Король и Шут проходило 19-го июля 2018-го года?#1#2#14#88#2",
                        "В какой песне группы Король и Шут слетела с петель в доме дверь?#Лесник#Собрание#Садовник#Охотник#4",
                        "Кто мертв - Горшок или Анархист?#Горшок#Анархист#Оба#Никто#2",
                        "Где проходило прощание с Горшком?#ДС Юбилейный#кафе Маяк#Бар Depeche Mode Spb#Не прощались#1",
                        "В каком состоянии ныне находится Горшок?#Аморфное#Прах#Окоченелое#Жив#4",
                        "В каком клубе проходили первые концерты группы Король и Шут?#ТамТам#Цоколь#Флэт#Бар Depeche Mode Spb#1",
                        "Как закончилось знаменитое интеллектуальное интервью Горшка на фоне зелёного самолета?#Плевком#Ударом репортера#Выпил пивка#Крикнул Хой#1",
                        "Что чаще всего кричал Горшок?#Ой#Хой#Хайль#Пиво#2",
                        "Какой медведь играл в группе Король и Шут?#Винни-Пух#По#Балу#Олимпийский#3",
                        "Как звали четвёртого мушкетера в песне «Песня мушкетёров»?#Атос#Портос#Арамис#Фак Де Полис#4",
                        "Кто из участников группы Король и Шут частенько заходит в бар Depeche Mode Spb?#Яков#Князь#Балу#Горшок#1",
                        "Как познакомились Князь и Горшок?#На концерте КиШа#В училище#В пивнухе#В Depeche Mode Spb#2",
                        "Как расшифровывается аббревиатура «КиШ»?#Кокс и Шмаль#Конкурсы и Шутки#Кек и Шпек#Король и Шут#4",
                        "Как прыгнуть со скалы?#Разревевшись#Набухавшись#Разбежавшись#Обрыгавшись#3",
                        "Трибьют какой группы записал Горшок в 2005-м году?#Сектор Газа#Гражданская Оборона#Бригадный подряд#Depeche Mode#3",
                        "На каком альбоме группы «Король и Шут» была песня «Король и Шут»?#Герои и злодеи#Будь как дома, путник#Бунт на корабле#Камнем по голове#2",
                        "Как обычно называют поклонников группы «Король и Шут»?#Добрый сэр#Отличный парень#Джентльмен#Говнарь#4",
                        "Что случилось с рукой Горшка на репетиции спектакля Тодд?#Потерял#Нашёл#Сломал#Пропил#3",
                        "В какой книге есть отсылки к образу Горшка?#Северные волки#Западные слоны#Восточные киски#Южные воробьи#1",
                        "В 2011-м году Лучано Паваротти планировал запись совместного альбома с Горшком. Как планировали назвать этот проект?#Горшок Белых ночей#Горшковаротти#Sweet Bubbles#Дурак и Опера#2",
                        "Кто мог спасти Горшка?#Врачи#Дилер#бар Depeche Mode Spb#никто#4",
                        "В каком городе был поставлен памятник Горшку?#Ленинград#Лаппеэнранта#Воронеж#Кострома#3",
                        "Как называется сольный проект Князя?#Княzz#Яззь#Гряззь#Арабская Вяззь#1",
                        "Кто продолжает жить в клипах Андрея Князева?#Горшок#Шок#Полтишок#Артишок#1",
                        "На кого помочился Горшок в Москве в 1999-м году?#Крутой#Ленин#Перегожин#Сам на себя#3",
                        "Логотип какой группы часто присутствовал на футболках Горшка?#Дюна#Misfits#Depeche Mode#Любе#2",
                        "Кто из музыкантов группы «Король и Шут» написал имя Филипп с двумя ошибками?#Князь#Балу#Поручик#Горшок#4",
                        "Татуировка с семью чем своих друзей была у Горшка?#С черепами#С жёнами#С пупками#С именами#1",
                        "Какой альбом группы «Король и Шут» издавался на чёрном CD?#Бунт на корабле#Жаль нет ружья#Камнем по голове#Тень клоуна#2",
                        "Купи нам папа - что закричали дети?#Краски#Пиво#Маски#Диплом#3",
                        "Тайна хозяйки старинных чего?#Весов#Трусов#Часов#Усов#3",
                        "Что же делать нам с?#Котлетой#Монетой#Сигаретой#Вот этой#2",
                        "С кем дрались Горшок и Князь на ринге в прямом эфире MTV?#Феминистки#Комбинация#Руки Вверх#На-На#4",
                        "Как назывался бар группы «Король и Шут», который открывался в Петербурге?#Старый дом#Собрание#Depeche Mode Spb#Изба-Татульня#1",
                        "Почему расстроился мужчина в песне «Камнем по голове»?#Мятый цилиндр#Наряд старинный#Маска обезьяны#Не успел на праздник#4",
                        "Кто стоит на холме и кричит?#Безумец#Мудрец#Горшок#Охотник#1",
                        "Как звали охотника, что спал на чердаке?#Владислав#Черномор#Себастьян#Ярополк#3",
                        "В какой группе играет брат Горшка?#Depeche Mode#Кукрыниксы#ABBA#Порнофильмы#2",
                        "Почему Мария ушла из группы «Король и Шут»?#Плохо играла#Любовная трагедия#Спилась#Надоело#2",
                        "Какой альбом группы «Король и Шут» был не электрическим?#Акустический#Жаль нет ружья#Герои и злодеи#Бунт на корабле#1",
                        "Как называлась первая группа Горшка, Балу и Поручика?#Контора#Depeche Mode#Кукрыниксы#Шут и Король#1",
                        "Кем приходились друг другу Горшок, Балу и Поручик?#Любовниками#Одноклассниками#Сослуживцами#Братьями#2",
                        "В каком музее Петербурга работали Князь и Горшок?#Кунсткамера#Русский музей#Эрмитаж#Музей водоканала#3",
                        "Жаль нет - чего?#Бухла#Ружья#Горшка#Счастья#2",
                        "В какой стране за пределами СНГ группа «Король и Шут» сыграла первый зарубежный концерт?#США#Израиль#Финляндия#Югославия#2",
                        "Кавер на какую песню группы «Кино» был записан группой «Король и Шут»?#Алюминиевые огурцы#Следи за собой#Мама-анархия#Восьмиклассница#2",
                        "Для какой зарубежной группы Горшок записал вокал в одной из песен?#Misfits#Nickelback#Red Elvises#Depeche mode#3",
                        "Аудиоспектакль по какой сказке Горшок и Князь записали для Нашего радио на новогодний эфир 2007-го года?#Красная шапочка#Золушка#Три поросёнка#Морозко#4",
                        "На каком проспекте находился клуб группы «Король и Шут» «Старый дом»?#Невский#Энтузиастов#Космонавтов#Металлистов#4"
    ]
    
    init() {
        createListOfData(questionCount: 11)
    }
    
    func createListOfData(questionCount: Int) {
        list.removeAll()
        arrayOfData.shuffle()
        for i in 0..<questionCount {
            let tempArray = arrayOfData[i].split(separator: "#")
            list.append(Question(questionText: String(tempArray[0]), choiceA: String(tempArray[1]), choiceB: String(tempArray[2]), choiceC: String(tempArray[3]), choiceD: String(tempArray[4]), answer: Int(tempArray[5]) ?? 0))
        }
        //list.shuffle()
    }
}
