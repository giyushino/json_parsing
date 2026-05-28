const std = @import("std");

const lexer = @import("lexer.zig");

pub fn main(init: std.process.Init) !void {
    // Memory that lives for the whole process; freed automatically on exit.
    const arena = init.arena.allocator();
    const io = init.io;

    // First CLI arg is the JSON file to read; fall back to the repo-root
    // test.json (relative to where `zig build run` runs, i.e. src/zig).
    const args = try init.minimal.args.toSlice(arena);
    const path = if (args.len > 1) args[1] else "../../test.json";

    const contents = try lexer.readin(io, arena, path);
    std.debug.print("read {d} bytes from {s}\n", .{ contents.len, path });
    lexer.tokenizer(contents);
}
