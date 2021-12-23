const std = @import("std");

const ZigString = extern struct {
    ptr: [*]const u8,
    len: usize,
};

extern fn gimme(ptr: ?*c_void, in: ZigString) ZigString;
extern fn gimme_no_ptr(ZigString) ZigString;

pub fn main() anyerror!void {
    const real: []const u8 = "hello";
    var str = ZigString{ .ptr = real.ptr, .len = real.len };
    var fails = gimme(null, str);
    var works = gimme_no_ptr(str);

    std.debug.assert(std.mem.eql(u8, real, str.ptr[0..str.len]));

    for (&[_]ZigString{ fails, works }) |new| {
        std.debug.assert(new.ptr == str.ptr);
        std.debug.assert(new.len == str.len);
        std.debug.assert(std.mem.eql(u8, real, new.ptr[0..new.len]));
    }
}
