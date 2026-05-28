const std = @import("std");

// Read the entire file at `filename` into one allocated buffer.
// The buffer is allocated with `gpa`; the caller owns it (or lets an
// arena free it). This is the "slurp it all at once" approach — the
// returned slice is what the lexer scans with a cursor.
//

const TokenKind = union(enum) {
    left_brace,
    right_brace,
    left_bracket,
    right_bracket,
    colon,
    comma,
    string: []const u8,
    number: f64,
    true_literal,
    false_literal,
    null_literal,
    eof,
};

// Please add a new property to this struct called "health" and make
// it a u8 integer type.
const Token = struct {
    kind: TokenKind,
    lexme: []const u8,
    line: u32,
    column: u32,
};

pub fn readin(io: std.Io, gpa: std.mem.Allocator, filename: []const u8) ![]u8 {
    return std.Io.Dir.cwd().readFileAlloc(io, filename, gpa, .unlimited);
}

// change return type to []const Token later
pub fn tokenizer(raw_json_text: []const u8) void {
    // debug print
    std.debug.print("read in {s}\n", .{raw_json_text});

    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var tokens: std.ArrayList(Token) = .empty;
    defer tokens.deinit(allocator);

    var count: u32 = 0;
    count = 1;

    for (raw_json_text) |char| {
        if (char == '\n') {
            std.debug.print("found endline\n", .{});
        } else if (char == ' ') {
            std.debug.print("found space\n", .{});
        }
    }
}
