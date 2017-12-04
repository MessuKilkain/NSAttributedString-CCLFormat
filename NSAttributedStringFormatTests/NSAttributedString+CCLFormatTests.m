@import XCTest;
@import Foundation;
@import NSAttributedStringFormat;


@interface NSAttributedStringTests : XCTestCase

@end

@implementation NSAttributedStringTests

- (void)testAttributedFormatStringCanFormatAttributedString {
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Hi" attributes:@{
        NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
    }];

    NSAttributedString *formattedAttributedString = [NSAttributedString attributedStringWithFormat:@"%@", attributedString];

    XCTAssertEqualObjects(formattedAttributedString, attributedString);
}

- (void)testAttributedFormatStringCanFormatString {
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithFormat:@"%@", @"Hello World"];
    XCTAssertEqualObjects([attributedString string], @"Hello World");
}

- (void)testAttributedFormatStringCanFormatDescription {
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithFormat:@"%@", @1337];
    XCTAssertEqualObjects([attributedString string], @"1337");
}

- (void)testAttributedFormatString {
    // Format Attributed String
    NSAttributedString *blue = [[NSAttributedString alloc] initWithString:@"Blue" attributes:@{
        NSFontAttributeName: [NSFont boldSystemFontOfSize:16.0f],
        NSForegroundColorAttributeName: [NSColor blueColor],
    }];

    NSAttributedString *green = [[NSAttributedString alloc] initWithString:@"Green" attributes:@{
        NSFontAttributeName: [NSFont boldSystemFontOfSize:16.0f],
        NSForegroundColorAttributeName: [NSColor greenColor],
    }];

    NSAttributedString *never = [[NSAttributedString alloc] initWithString:@"never" attributes:@{
        NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
    }];

    NSAttributedString *attributedString = [NSAttributedString attributedStringWithFormat:@"%@ and %@ must %@ be %@", blue, green, never, @"seen"];

    // Fixture
    NSMutableAttributedString *fixtureAttributedString = [[NSMutableAttributedString alloc] initWithString:@"Blue and Green must never be seen"];
    NSRange blueRange = [[fixtureAttributedString string] rangeOfString:@"Blue"];
    NSRange greenRange = [[fixtureAttributedString string] rangeOfString:@"Green"];
    NSRange neverRange = [[fixtureAttributedString string] rangeOfString:@"never"];
    
    [fixtureAttributedString setAttributes:@{
        NSFontAttributeName: [NSFont boldSystemFontOfSize:16.0f],
        NSForegroundColorAttributeName: [NSColor blueColor],
    } range:blueRange];

    [fixtureAttributedString setAttributes:@{
        NSFontAttributeName: [NSFont boldSystemFontOfSize:16.0f],
        NSForegroundColorAttributeName: [NSColor greenColor],
    } range:greenRange];

    [fixtureAttributedString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:neverRange];
    
    XCTAssertEqualObjects(attributedString, fixtureAttributedString, "");
}

- (void)testPositionalAttributedFormatStringCanFormatAttributedString {
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Hi" attributes:@{
        NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
    }];

    NSAttributedString *formattedAttributedString = [NSAttributedString attributedStringWithFormat:@"%1$@", attributedString];

    XCTAssertEqualObjects(formattedAttributedString, attributedString);
}

- (void)testPositionalAttributedFormatStringCanFormatString {
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithFormat:@"%1$@", @"Hello World"];
    XCTAssertEqualObjects([attributedString string], @"Hello World");
}

- (void)testPositionalAttributedFormatStringCanFormatDescription {
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithFormat:@"%1$@", @"1337"];
    XCTAssertEqualObjects([attributedString string], @"1337");
}

- (void)testPositionalAttributedFormatString {
    // Format Attributed String
    NSAttributedString *blue = [[NSAttributedString alloc] initWithString:@"Blue" attributes:@{
        NSFontAttributeName: [NSFont boldSystemFontOfSize:16.0f],
        NSForegroundColorAttributeName: [NSColor blueColor],
    }];

    NSAttributedString *green = [[NSAttributedString alloc] initWithString:@"Green" attributes:@{
        NSFontAttributeName: [NSFont boldSystemFontOfSize:16.0f],
        NSForegroundColorAttributeName: [NSColor greenColor],
    }];

    NSAttributedString *never = [[NSAttributedString alloc] initWithString:@"never" attributes:@{
        NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
    }];

    NSAttributedString *attributedString = [NSAttributedString attributedStringWithFormat:@"%1$@ and %2$@ must %4$@ be %3$@", blue, green, @"seen", never];

    // Fixture
    NSMutableAttributedString *fixtureAttributedString = [[NSMutableAttributedString alloc] initWithString:@"Blue and Green must never be seen"];
    NSRange blueRange = [[fixtureAttributedString string] rangeOfString:@"Blue"];
    NSRange greenRange = [[fixtureAttributedString string] rangeOfString:@"Green"];
    NSRange neverRange = [[fixtureAttributedString string] rangeOfString:@"never"];
    
    [fixtureAttributedString setAttributes:@{
        NSFontAttributeName: [NSFont boldSystemFontOfSize:16.0f],
        NSForegroundColorAttributeName: [NSColor blueColor],
    } range:blueRange];

    [fixtureAttributedString setAttributes:@{
        NSFontAttributeName: [NSFont boldSystemFontOfSize:16.0f],
        NSForegroundColorAttributeName: [NSColor greenColor],
    } range:greenRange];

    [fixtureAttributedString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:neverRange];
    
    XCTAssertEqualObjects(attributedString, fixtureAttributedString, "");
}

- (void)testPositionalAttributedFormatStringCanFormatMoreThanNineArgs {
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithFormat:
        @"%1$@ %2$@ %3$@ %4$@ %5$@ %6$@ %7$@ %8$@ %9$@ %10$@", 
        @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];

    XCTAssertEqualObjects([attributedString string], @"1 2 3 4 5 6 7 8 9 10", "");
}

- (void)testPositionalFormatStringCanFormatRepeatedArgs {
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithFormat:
        @"%1$@ %2$@ %1$@", @"1", @"2"];
    XCTAssertEqualObjects([attributedString string], @"1 2 1", "");
}

- (void)testFormatStringCanHaveAttributes {
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttributes:@{
                                            NSForegroundColorAttributeName: [NSColor blueColor]
                                            } format:@"test %@", @"test"];
    NSAttributedString *formattedAttributedString = [[NSAttributedString alloc] initWithString:@"test test"
                    attributes:@{NSForegroundColorAttributeName: [NSColor blueColor]}];
    XCTAssertEqualObjects(formattedAttributedString, attributedString);
}

- (void)testArgumentAttributesOverrideBaseAttributes {
    NSAttributedString *attributedArg = [[NSAttributedString alloc] initWithString:@"test"
                            attributes:@{NSForegroundColorAttributeName: [NSColor greenColor]}];
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttributes:@{
                                NSForegroundColorAttributeName: [NSColor blueColor]
                                } format:@"test %@", attributedArg];
    NSMutableAttributedString *formattedAttributedString = [[NSMutableAttributedString alloc]
                                initWithString:@"test "
                                    attributes:@{NSForegroundColorAttributeName: [NSColor blueColor]}];
    [formattedAttributedString appendAttributedString:attributedArg];
    XCTAssertEqualObjects(formattedAttributedString, attributedString);
}

- (void)testMissingAttributeInAttributedArgumentUsesBaseAttribute {
    NSAttributedString *attributedArg = [[NSAttributedString alloc] initWithString:@"test"
                        attributes:@{NSForegroundColorAttributeName: [NSColor greenColor]}];
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttributes:@{
                        NSForegroundColorAttributeName: [NSColor blueColor],
                        NSFontAttributeName: [NSFont boldSystemFontOfSize:16.0f]
                        } format:@"test %@", attributedArg];
    NSMutableAttributedString *formattedAttributedString = [[NSMutableAttributedString alloc]
                                    initWithString:@"test " attributes:@{
                            NSForegroundColorAttributeName: [NSColor blueColor],
                            NSFontAttributeName: [NSFont boldSystemFontOfSize:16.0f]
                            }];
    [formattedAttributedString appendAttributedString:attributedArg];
    [formattedAttributedString addAttributes:@{
                                               NSFontAttributeName: [NSFont boldSystemFontOfSize:16.0f]
                                               }
                                       range:(NSRange) {5,4}];
    XCTAssertEqualObjects(formattedAttributedString, attributedString);
}

- (void)testNonAttributedArgumentUsesBaseAttributes {
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttributes:@{
                     NSForegroundColorAttributeName: [NSColor blueColor]
                     } format:@"test %@", @"test"];
    NSMutableAttributedString *formattedAttributedString = [[NSMutableAttributedString alloc]
                                initWithString:@"test test" attributes:@{
                                NSForegroundColorAttributeName: [NSColor blueColor]}];
    XCTAssertEqualObjects(formattedAttributedString, attributedString);
}

- (void)testNothingElseThanNormalStringAsFormat {
    NSMutableAttributedString *formattedAttributedString = [NSMutableAttributedString attributedStringWithFormat:@"test test"];
    NSMutableAttributedString *testText = [[NSMutableAttributedString alloc] initWithString:@"test test"];
    XCTAssertEqualObjects(formattedAttributedString, testText);
}

- (void)testAttributedArgumentWithComplexAttributesKeepsAttributes {
    NSDictionary *boldBlueAttrs = @{ NSFontAttributeName: [NSFont boldSystemFontOfSize:16.0f],
                                     NSForegroundColorAttributeName: [NSColor blueColor]};
    NSDictionary *redAttrs = @{NSForegroundColorAttributeName: [NSColor redColor]};
    NSDictionary *rootAttributes = @{NSForegroundColorAttributeName: [NSColor greenColor],
                                     NSFontAttributeName: [NSFont systemFontOfSize:14.0f]};
    
    NSAttributedString *attributedArg = [NSAttributedString attributedStringWithAttributes:redAttrs
                                                                                    format:@"red %@ red",
                                         [[NSAttributedString alloc] initWithString:@"bold blue"
                                                                         attributes:boldBlueAttrs]];

    NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttributes:rootAttributes
                                                                    format:@"test %@", attributedArg];
    NSMutableAttributedString *formattedAttributedString = [[NSMutableAttributedString alloc]
                                                            initWithString:@"test red bold blue red"
                                                            attributes:rootAttributes];
    [formattedAttributedString addAttributes:redAttrs range:(NSRange){5, 17}];
    [formattedAttributedString setAttributes:boldBlueAttrs range:(NSRange){9, 9}];

    XCTAssertEqualObjects(formattedAttributedString, attributedString);
}

- (void)testSubstituteAttributedStringPerformance {
    NSDictionary *attributes = @{ NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle) };
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Hi" attributes:attributes];

    [self measureBlock:^{
        NSAttributedString *formattedAttributedString = [NSAttributedString attributedStringWithFormat:@"%@", attributedString];
        XCTAssertEqualObjects(formattedAttributedString, attributedString);
    }];
}

@end
