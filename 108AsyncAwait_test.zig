const expect = @import("std").testing.expect;
var bar: i32 = 1;

test "suspend with resume" {
    var frame = async func2();  //1
    resume frame;               //4
    try expect(bar == 3);       //6
}

fn func2() void {
    bar += 1;                   //2
    suspend {}                  //3
    bar += 1;                   //5
}
