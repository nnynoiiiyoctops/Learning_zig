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

//test "fetchPut" {
    
