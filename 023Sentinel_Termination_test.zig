const expect = @import("std").testing.expect;

//Объявляются они буквально как слайсы в Go. Привыкнуть будет тяжело но надо будет
//Из того что я понял - жто массив с доп элементом в конце который служит символом завершения строки.
// по типу \0 из C. Тут что-то похожее. Но так как длинна массива известна заранее - смысл этого инструмента ВРОДЕ КАК в совместимости с C

test "Sentiel Termination" {
    const terminated = [3:5]u8{ 68, 69, 90 };
    //                  ^ ^
    // кол-во элементов | | то что будет в конце
    //Это только то как я понял и надо будет проверить это
    //Чем сейчас и займусь)

    try expect(terminated.len == 3);
    //Что и было указано при объявлении
    try expect(@as(*const [4]u8, @ptrCast(&terminated))[3] == 5);
    //Вспоминаем что в массивах нумерация начинается с 0 и учитывается 0
    //И тут 3 по сути 4ый элемент

    //Сработало. Значит это массив со скрытым элементом!
}

//А теперь попробуем тупее

test "more easy" {
    const ter_arr = [3:0]u8{ 10, 15, 20 };
    const pter_ta = @as(*const [4]u8, &ter_arr);
    //Этот способ проще и без всяких @ptrCast
    //Несмотря на то что по идее @ptrCast должен быть понятнее и безопаснее
    //Средства языка дают иной способ

    try expect(pter_ta[3] == 0);
}
//Также хочу отметить что это лишь ЧАСТЬ МАССИВА
//Это тот же массив с теми же свойствами что видно в 1ом тесте. У него есть .len
//Но просто последний символ делается специальным
