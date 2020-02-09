# MayanMath
A Swift class for Xcode iOS apps that provides Mayan Number Glyph mathematical operations

See the iOS app Mayan Math on the Apple App Store as one example of how this class can be 
used to convert decimal integers to Mayan glyphs and perform math operations using Mayan
glyphs.

https://apps.apple.com/us/app/mayan-math/id1450110752

MayanMath is setup to be used as a singleton. So it is referenced as MayanMath.shared in the code.

## Class functions


**mayanGlyph(forInt:symbolType:)** - Given an integer from 0 to 19, returns a MayanGlyph that contains the UIImage respresention

**symbols(forInt:symbolType:)** - Given any integer, returns an array of UIImages with the mayan representation

## Instance properties and functions


**leftSideDigitValues** *{ get set }* - an array of integers that represent a single base 20 place value ( 0 -> 19 )
**leftSide** *{ get }* - a readonly integer that is derived from the leftSideDigitValues array

**rightSideDigitValues** *{ get set }* - an array of integers that represent a single base 20 place value ( 0 -> 19 )
**rightSide** *{ get }* - a readonly integer that is derived from the rightSideDigitValues array

**negate()** - a function to negate, toggle the +/-, the active operand array

**resultDigitValues** *{ get }* - an array of integers that represent a single base 20 place value ( 0 -> 19 )
**resultsInt** *{ get }* - a readonly integer that is derived from the rightSideDigitValues array

**resultsString** *{ get }* - a string that contains the representation of the math expression after deriveResults() is invoked

**mathOp** *{ get set }* - an optional enum of the valid math operations.

**equalEnabled** *{ get set}* - a boolean set to true prior to invoking deriveResults()

**reset(withInt:)** - a function to reset the math expression and set the left side with any integer. This is normally used for decimal to Mayan Glyph conversions

**reset(startWithResult:)** - a function to reset the math expression and set the left side to the prior results.

**resetRightSide()** - a function to reset the right side of the math expression.

**deriveResults()** - a function to derive all results, converting the left and right side arrays to their integer representations, and if equal is enabled the math operation results as well.


## Usage Examples

> MayanMath.shared.reset(withInt: 0)
>
> MayanMath.shared.leftSideDigitValues = [8]
>
> MayanMath.shared.mathOp = .add
>
> MayanMath.shared.rightSideDigitValues = [17]
>
> MayanMath.shared.equalEnabled = true
>
> MayanMath.shared.deriveResults()

*MayanMath.shared.resultDigitValues* will now contain [1,5] and resultsInt value will be 25. 

Use the class methods *mayanGlyph(forInt:symbolType:)* and *symbols(forInt:symbolType:)* to get the glyph UIImage representations


# LICENSE


Copyright (C) 2019-2020 by Montiel Mobile, LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
