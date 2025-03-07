const std = @import("std");
const expect = std.testing.expect;

const PageAllocator = std.heap.page_allocator;

test "Хешмап" {
    const Point = struct {
        x: f64,
        y: f64,
    };

    var map = std.AutoHashMap(u32, Point).init(PageAllocator);
    defer map.deinit();

    try map.put(0 , .{ .x = 0, .y = 0 });
    try map.put(10, .{ .x = 8, .y = 6 });

    try expect(map.count() == 2);

    var sum = Point{ .x = 0, .y = 0 };
    var iterator = map.iterator();

    while (iterator.next()) |entry| {
        sum.x += entry.value_ptr.x;
        sum.y += entry.value_ptr.y;
    }

    try expect(sum.x == 8);
    try expect(sum.y == 6);
}

test "ТЕЕЕЕЕСТ" {
    var map = std.AutoHashMap(u8, *const [7:0]u8).init( PageAllocator );
    defer map.deinit();

    try map.put(100, "teeeest" );
    try map.put( 1 , "argolit" );

    const for_test = "argolit";

    const str = map.get(1).?;
    //Тут может быть nill
    try expect( str == for_test);
}

test "fetchPut" {
    var m = std.AutoHashMap( u8, u56 ).init( PageAllocator );
    defer m.deinit();

    try m.put( 0xFF, 0xFFFF_FFFF_FFFF_FF );
    try m.put( 0, 10 );

    const max = try m.fetchPut(0, 500);

    try expect( max.?.value == 10 );
}

test "Аллокатор со строками" {
    var string_map = std.StringHashMap( enum{ cute, ugly }) .init( PageAllocator);
    defer string_map.deinit();

    try string_map.put( "argollit", .cute );
    try string_map.put( "lithium ", .ugly );

    try expect( string_map.get("lithium ").? == .ugly );
}
