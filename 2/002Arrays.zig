const expect = @import("std").testing.expect;
const mem = @import("std").mem;

test {
    const first_array: [10]u8 = [1]u8{1} ** 10;
    const second_array = [10]u8{1,1,1,1,1,1,1,1,1,1};
    try expect(mem.eql(u8, first_array[0..], second_array[0..]));
    //Как оказалось eql возвращает bool
}

const hello_world: *const [11:0]u8 = "hello world";
//Тип строк

test {
    const ptr: [*]u8 = @as([*]u8, @constCast(hello_world));
    //@constCast нужен чтобы убрать константу с типа
    try expect( ptr[11] == 0 );
}

test {
    const ptr_2 = &hello_world;
    try expect( ptr_2.*[11] == 0 );
}

test {
    try expect( hello_world[11] == 0 );
    //Т.е. необязательно создавать новый указатель. Можно прям так ....
    //Круто
}

test {
    const a = "hello world";
    try expect(mem.eql(u8, a[0..], hello_world[0..]));
}

test {
    const a: *const [5:0]u8 = "hello";
    const b: *const [5:0]u8 = "hello";

    try expect( a == b );

    const c: [5:0]u8 = .{'h','e','l','l','o'};
    const d: [5:0]u8 = .{'h','e','l','l','o'};

    try expect( &c == &d );
}

test {
    const array: [10]u8 = .{10} ** 10;
    var summ: u64 = 0;
    for (array) |byte| summ += byte;

    try expect( summ == 100 );
}
        
test {
    var summ: u64 = 0;
    for (hello_world[0..]) |byte| summ += byte;

    try expect( summ == comptime('h'+'e'+('l'*3)+('o'*2)+' '+'w'+'r'+'d'));
    try expect( hello_world.len == 11 );
}
        
