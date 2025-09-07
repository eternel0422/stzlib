load "../stzbase.ring"

/*-----

pr()

? StzCharQ("⚝").Name()
#--> OUTLINED WHITE STAR

? StzCharQ("OUTLINED WHITE STAR").Content()
#--> ⚝

? StzCharQ("⚝").Unicode()
#--> 9885

? StzCharQ(9885).Content()
#--> ⚝

pf()
# Executed in 0.13 second(s) in Ring 1.22
# Executed in 0.17 second(s) in Ring 1.21

/*-----

pr()

? isvowel("a") 		# Ring function

? @IsVowel("a") 	# Softanza alternative
? @IsVowel("aie")
? @IsVowel([ "a", "i", "e" ])

? AreVowels("aie")
? AreVowels([ "a", "i", "e" ])

pf()
# Executed in 0.02 second(s)

/*-----

pr()

? NthChar(3, "ring")
#--> n

pf()
# Executed in 0.01 second(s)

/*-----

pr()

? Basmalah()
#--> ﷽

? StzChar(65021)
#--> ﷽

? StzCharQ(65021).Name()
#--> ARABIC LIGATURE BISMILLAH AR-RAHMAN AR-RAHEEM

? StzCharQ(65021).SizeInBytes()
#--> 3

? StzCharQ(65021).SizeInChars()
#--> 1

pf()
# Executed in 0.05 second(s) on Ring 1.21
# Executed in 0.09 second(s) on ring 1.20

/*---

pr()

? Allah()
#o--> ﷲ

? Basmalah()
#o--> ﷽

? Muhammad()
#o--> ﷴ

? SalatAlaMuhammad()
#o--> ﷺ

pf()
# Executed in almost 0 second(s).

/*------

pr()

? Smile()
#--> 😆

? Heart()
#--> ♥

? Flower()
#--> ❀

? Sun()
#--> 🌞

? Moon()
#--> 🌔

? Handshake()
#--> 🤝

? Dot()
#--> •

? Tick() # Or Check()
#--> ✓

pf()
# Executed in almost 0 second(s) in Ring 1.22
# Executed in 0.02 second(s) in Ring 1.21

/*=========== TODO : LOGICAL ERRORS

pr()

? StzCharQ("0x10481").Content() #--> TODO: ERR, should be "𐒁"
#--> ҁ

? Q("Schöne Grüße").Length() # means "Kind Regards" in german
#--> 12

? StzUnicodeDataQ().CharByName("OSMANYA LETTER BA") #ERRor! Should be 𐒁
#--> ҁ

? StzCharQ("ҁ").Name()
#--> CYRILLIC SMALL LETTER KOPPA

//? StzCharQ("𐒁") #TODO-ERROR
#--> Can't create char object!

? Q("𐒁").CharName() #TODO-ERROR: correct it to be OSMANYA LETTER BA
#--> QUESTION MARK

? StzCharQ("OSMANYA LETTER BA").Content()
#--> ҁ

pf()
# Executed in 0.28 second(s) in Ring 1.23
# Executed in 1.93 second(s) in Ring 1.20

/*======== TURNABLE NUMBERS

#TODO // Add TurnUp, TurnDown, Turn, IsTurnedUp, IsTurnedDown
# here in stzChar then in stzString

pr()

? @@(TurnableNumbers())
#--> [ 2, 3 ]

? @@(TurnableNumbersUnicodes())
#--> [ 2, 3 ]

? @@(TurnableNumbersXT()) #NOTE// Font in Notepad may not show the turned numbers
#--> [ [ 2, "↊" ], [ 3, "↋" ] ]

pf()
# Executed in 0.03 second(s) in Ring 1.23
# Executed in 0.11 second(s) in Ring 1.20

/*------ TURNED NUMBERS

pr()

? @@(TurnedNumbersUnicodes())
#--> [ 8586, 8587 ]

? @@(TurnedNumbers()) #NOTE: Idem
#--> [ "↊", "↋" ]

? @@( Q([ "↊", "↋" ]).Names() )
#--> [ "TURNED DIGIT TWO", "TURNED DIGIT THREE" ]

? @@(TurnedNumbersXT()) # Or TurnedNumberAndTheirUnicodes()
#--> [ [ "↊", 8586 ], [ "↋", 8587 ] ]

pf()
# Executed in 0.09 second(s) in Ring 1.23
# Executed in 0.51 second(s) in Ring 1.20

/*------- TURNABLE CHARS

pr()

? HowManyTurnableChars()
#--> 141

? @@S( TurnableChars() ) + NL
#--> [ "$", "&", "(", "...", "ꭃ", "ꭐ", "ꭑ" ]

? @@S( TurnableUnicodes() ) + NL
#--> [ 36, 38, 40, "...", 43843, 43856, 43857 ]

? @@S( TurnableUnicodesXT()) # Or ShowShort()
#--> [
#	[ 36, "$" ], [ 38, "&" ], [ 40, "(" ], "...",
#	[ 43843, "ꭃ" ], [ 43856, "ꭐ" ], [ 43857, "ꭑ" ] ]
# ]

? @@S(TurnableCharsXT()) + NL
#--> [ [ "δ", "ƍ" ], [ "Ɑ", "Ɒ" ], [ "ɑ", "ɒ" ], "...", [ "~", "~" ], [ "$", "$" ], [ "€", "€" ] ]

? @@S( TurnableCharsAndTheirUnicodes() )
#--> [ [ "$", 36 ], [ "&", 38 ], [ "(", 40 ], "...", [ "ꭃ", 43843 ], [ "ꭐ", 43856 ], [ "ꭑ", 43857 ] ]

pf()
# Executed in 0.08 second(s) in Ring 1.23
# Executed in 0.30 second(s) in Ring 1.20

/*=====

pr()

o1 = new stzChar("M")
? o1.Reverted()
#--> Ɯ

o1 = new stzChar("Ɯ")
? o1.Reverted()
#--> M

pf()
# Executed in 0.04 second(s) in Ring 1.23
# Executed in 0.08 second(s) in Ring 1.20

/*---

pr()

o1 = new stzChar("Ɯ")
? o1.IsTurned()
#--> TRUE

? o1.IsTurnable()
#--> TRUE

? o1.Turned()
#--> M

#--

o1 = new stzChar("M")
? o1.IsTurned()
#--> FALSE

? o1.IsTurnable()
#--> TRUE

? o1.Turned()
#--> Ɯ

pf()
# Executed in 0.08 second(s) in Ring 1.23
# Executed in 0.22 second(s) in Ring 1.207

/*=====

pr()

? QQ("Ǝ").IsTurned()
#--> TRUE

? QQ("Ⅎ").IsTurned()
#--> TRUE

? QQ("I").IsTurned()
#--> TRUE

? QQ("⅂").IsTurned()
#--> TRUE

? Q("ƎℲI⅂").IsTurned()
#--> TRUE

? Q("ƎℲI⅂").Turned()
#--> LIFE

? Q("LIFE").Turned()
#--> ƎℲI⅂

? Q("LIFE").CharsTurned()
#--> ⅂IℲƎ

? Q("⅂IℲƎ").CharsTurned()
#--> LIFE

pf()
# Executed in 0.26 second(s) in Ring 1.23
# Executed in 2.07 second(s) in Ring 1.20

/*-----------

pr()

# First, this is your name, nicely printed in a rounded box

? Q("GARY").BoxedRounded()
#-->
'
╭──────╮
│ GARY │
╰──────╯
'

? Q("GARY").CharsBoxedRounded()
#--> ╭───┬───┬───┬───╮
#    │ G │ A │ R │ Y │
#    ╰───┴───┴───┴───╯

? Q("GARY").Inversed() # Inverses the order of chars
#--> YRAG

? Q("GARY").Turned() # Turns the chars down
#--> ⅄RⱯ⅁

pf()
# Executed in 0.08 second(s) in Ring 1.23

/*---------

pr()

? @@( ArabicDotlessUnicodes() ) + NL
#--> [
#	1609, 1575, 1581, 1583, 1585,
#	1587, 1589, 1591, 1593, 1605,
#	1607, 1608, 1646, 1647, 1697,
#	1705, 1722
# ]

? @@( ArabicDotlessLetters() ) + NL
#--> [ "ى", "ا", "ح", "د", "ر", "س", "ص", "ط", "ع", "م", "ه", "و", "ٮ", "ٯ", "ڡ", "ک", "ں" ]

? @@( LatinDotlessUnicodes() ) + NL
#--> [ 305, 567 ]

? @@( LatinDotlessLetters() )
#--> [ "ı", "ȷ" ]

pf()
# Executed in 0.03 second(s) in Ring 1.23
# Executed in 0.74 second(s) in Ring 1.19

/*---------

pr()

StzCharQ('U+0649') {
	? Content() 	#--> ى
	? Name()	#--> ARABIC LETTER ALEF MAKSURA
	? Unicode()	#--> 1609
} ? ""

StzCharQ('U+062D') {
	? Content() 	#--> ح
	? Name()	#--> ARABIC LETTER HAH
	? Unicode()	#--> 1581
} ? ""

StzCharQ('U+062F') {
	? Content() 	#--> د
	? Name()	#--> ARABIC LETTER DAL
	? Unicode()	#--> 1583
} ? ""

StzCharQ('U+0631') {
	? Content() 	#--> ر
	? Name()	#--> ARABIC LETTER REH
	? Unicode()	#--> 1585
} ? ""

StzCharQ('U+0633') {
	? Content() 	#--> س
	? Name()	#--> ARABIC LETTER SEEN
	? Unicode()	#--> 1587
} ? ""

StzCharQ('U+0635') {
	? Content() 	#--> ص
	? Name()	#--> ARABIC LETTER SAD
	? Unicode()	#--> 1589
} ? ""

StzCharQ('U+0637') {
	? Content() 	#--> ط
	? Name()	#--> ARABIC LETTER TAH
	? Unicode()	#--> 1591
} ? ""

StzCharQ('U+06A9') {
	? Content() 	#--> ک
	? Name()	#--> ARABIC LETTER KEHEH
	? Unicode()	#--> 1705
} ? ""

StzCharQ('U+0645') {
	? Content() 	#--> م
	? Name()	#--> ARABIC LETTER MEEM
	? Unicode()	#--> 1605
} ? ""

StzCharQ('U+0647') {
	? Content() 	#--> ه
	? Name()	#--> ARABIC LETTER HEH
	? Unicode()	#--> 1607
} ? ""

StzCharQ('U+0648') {
	? Content() 	#--> و
	? Name()	#--> ARABIC LETTER WAW
	? Unicode()	#--> 1608
} ? ""

StzCharQ('U+0639') {
	? Content() 	#--> ع
	? Name()	#--> ARABIC LETTER AIN
	? Unicode()	#--> 1593
} ? ""

StzCharQ('U+0627') {
	? Content() 	#--> ا
	? Name()	#--> ARABIC LETTER ALEF
	? Unicode()	#--> 1575
} ? ""

StzCharQ('U+066E') {
	? Content() 	#--> ٮ
	? Name()	#--> ARABIC LETTER DOTLESS BEH
	? Unicode()	#--> 1646
} ? ""

StzCharQ('U+066F') {
	? Content() 	#--> ٯ
	? Name()	#--> ARABIC LETTER DOTLESS QAF
	? Unicode()	#--> 1647
} ? ""

StzCharQ('U+06A1') {
	? Content() 	#--> ڡ
	? Name()	#--> ARABIC LETTER DOTLESS FEH
	? Unicode()	#--> 1697
} ? ""

StzCharQ('U+06BA') {
	? Content() 	#--> ں
	? Name()	#--> ARABIC LETTER DOTLESS NOON GHUNNA
	? Unicode()	#--> 1722
}

pf()
# Executed in 0.73 second(s) on Ring 1.21
# Executed in 0.83 second(s) on Ring 1.20
# Executed in 6.96 second(s) on Ring 1.18

/*----- Arabic dotless letters

pr()

? @@( ArabicDotlessLetters() ) + NL
#--> [ "ى", "ا", "ح", "د", "ر", "س", "ص", "ط", "ع", "م", "ه", "و", "ٮ", "ٯ", "ڡ", "ک", "ں" ]

? @@( ArabicDotlessUnicodes() ) + NL
#--> [ 1609, 1575, 1581, 1583, 1585, 1587, 1589, 1591, 1593, 1605, 1607, 1608, 1646, 1647, 1697, 1705, 1722 ]

? @@( ArabicDotlessLettersAndTheirUnicodes() ) + NL
#--> [ [ "ى", 1609 ], [ "ا", 1575 ], [ "ح", 1581 ], [ "د", 1583 ], [ "ر", 1585 ], [ "س", 1587 ], [ "ص", 1589 ], [ "ط", 1591 ], [ "ع", 1593 ], [ "م", 1605 ], [ "ه", 1607 ], [ "و", 1608 ], [ "ٮ", 1646 ], [ "ٯ", 1647 ], [ "ڡ", 1697 ], [ "ک", 1705 ], [ "ں", 1722 ] ]

? @@( ArabicDotlessLettersXT() )
#--> [ [ "ى", "ى" ], [ "ي", "ٮ" ], [ "ح", "ح" ], [ "خ", "ح" ], [ "ج", "ح" ], [ "د", "د" ], [ "ذ", "د" ], [ "ر", "ر" ], [ "ز", "ر" ], [ "س", "س" ], [ "ش", "س" ], [ "ص", "ص" ], [ "ض", "ص" ], [ "ط", "ط" ], [ "ظ", "ط" ], [ "ک", "ک" ], [ "ك", "ک" ], [ "ع", "ع" ], [ "غ", "ع" ], [ "ٮ", "ٮ" ], [ "ب", "ٮ" ], [ "ت", "ٮ" ], [ "ث", "ٮ" ], [ "ٯ", "ٯ" ], [ "ق", "ٯ" ], [ "ف", "ٯ" ], [ "ں", "ں" ], [ "ن", "ں" ], [ "ه", "ه" ], [ "ة", "ه" ] ]

pf()
# Executed in 0.03 second(s) in Ring 1.23
# Executed in 0.12 second(s) in Ring 1.20

/*----- Latin dotless letters

pr() 

? @@( LatinDotlessLetters() ) + NL
#--> [ "ı", "ȷ" ]

? @@( LatinDotlessUnicodes() ) + NL
#--> [ 305, 567 ]

? @@( LatinDotlessLettersAndTheirUnicodes() ) + NL
#--> [ [ "ı", 305 ], [ "ȷ", 567 ] ]

? @@( LatinDotlessLettersXT() ) + NL
#--> [ [ "ı", "ı" ], [ "i", "ı" ], [ "ȷ", "ȷ" ], [ "j", "ȷ" ] ]

pf()
# Executed in 0.03 second(s) in Ring 1.23
# Executed in 0.08 second(s) in Ring 1.20

/*----- Dotless letters

pr() 

? @@( DotlessLetters() ) + NL
#--> [ "ى", "ا", "ح", "د", "ر", "س", "ص", "ط", "ع", "م", "ه", "و", "ٮ", "ٯ", "ڡ", "ک", "ں", "ı", "ȷ" ]

? @@( DotlessUnicodes() ) + NL
#--> [ 1609, 1575, 1581, 1583, 1585, 1587, 1589, 1591, 1593, 1605, 1607, 1608, 1646, 1647, 1697, 1705, 1722, 305, 567 ]

? @@( DotlessLettersAndTheirUnicodes() ) + NL
#--> [ [ "ى", 1609 ], [ "ا", 1575 ], [ "ح", 1581 ], [ "د", 1583 ], [ "ر", 1585 ], [ "س", 1587 ], [ "ص", 1589 ], [ "ط", 1591 ], [ "ع", 1593 ], [ "م", 1605 ], [ "ه", 1607 ], [ "و", 1608 ], [ "ٮ", 1646 ], [ "ٯ", 1647 ], [ "ڡ", 1697 ], [ "ک", 1705 ], [ "ں", 1722 ], [ "ı", 305 ], [ "ȷ", 567 ] ]

? @@( DotlessLettersXT() ) + NL
#--> [ [ "ى", "ى" ], [ "ي", "ٮ" ], [ "ح", "ح" ], [ "خ", "ح" ], [ "ج", "ح" ], [ "د", "د" ], [ "ذ", "د" ], [ "ر", "ر" ], [ "ز", "ر" ], [ "س", "س" ], [ "ش", "س" ], [ "ص", "ص" ], [ "ض", "ص" ], [ "ط", "ط" ], [ "ظ", "ط" ], [ "ک", "ک" ], [ "ك", "ک" ], [ "ع", "ع" ], [ "غ", "ع" ], [ "ٮ", "ٮ" ], [ "ب", "ٮ" ], [ "ت", "ٮ" ], [ "ث", "ٮ" ], [ "ٯ", "ٯ" ], [ "ق", "ٯ" ], [ "ف", "ٯ" ], [ "ں", "ں" ], [ "ن", "ں" ], [ "ه", "ه" ], [ "ة", "ه" ], [ "ı", "ı" ], [ "i", "ı" ], [ "ȷ", "ȷ" ], [ "j", "ȷ" ] ]

pf()
# Executed in 0.03 second(s) in Ring 1.23
# Executed in 0.14 second(s) in Ring 1.20

/*-----

pr()

? MaxUnicodeNumber()
#--> 1114112

? UnicodeChar(1114113)
#--> ERR: Incorrect param type! p must be a number less then 1114112!

pf()

/*---

pr()

? NumberOfUnicodeChars()
#--> 149186

? UnicodeChar(149186)
#--> "䛂"

? LastUnicodeChar()
#--> "䛂"

pf()
# Executed in almost 0 second(s) in Ring 1.23

/*---

pr()

? ACharOtherThan("y")
#--> 

? ACharOtherThan("䛂")
#--> "≜"
#--> "㎍"
#--> "⟶"
#--> "ਭ"

pf()
# Executed in 1.37 second(s) in Ring 1.23

/*---

pr()

? MaxUnicode()
#--> 1_114_112

? NumberOfUnicodeChars()
#--> 149_186

? LastUnicodeChar()
#--> 䛂

? Unicode("䛂")

pf()
# Executed in 0.01 second(s) in Ring 1.23
# Executed in 0.04 second(s) in Ring 1.20

/*---

pr()

? Q("✓").CharName() 			#--> CHECK MARK
? StzCharQ("CHECK MARK").Content() 	#--> ✓
? CQ("NOT CHECK MARK").Content()	#--> ⍻

? StzCharQ("Ã").IsLatinDiacritic() 	#--> TRUE
# To get the list of latin diacritics use LatinDiacritics()

? StzCharQ(" ").CharType() #--> separator_space

pf()
# Executed in 0.17 second(s) in Ring 1.23

/*------------------

pr()

? StzCharQ("⸁").Name() #--> RIGHT ANGLE DOTTED SUBSTITUTION MARKER 

pf()
# Executed in 0.04 second(s) in Ring 1.23

/*------------------

pr()

# There is no an empty char in Unicode
? Unicode("")	#--> ''
? StzCharQ("").Name()	#--> ERROR: Can't create char from empty string!

pf()

/*---

pr()

o1 = new stzChar(61)
? o1.Content() #--> "="
? o1.Name() #--> EQUALS SIGN

pf()
# Executed in 0.03 second(s) in Ring 1.23

/*---

pr()

o1 = new stzChar("EQUALS SIGN")
? o1.Content() #--> "="

pf()
# Executed in 0.04 second(s) in Ring 1.23

/*---

pr()

o1 = new stzChar("0x61")
? o1.Content() #--> "a"
? o1.Name() #--> LATIN SMALL LETTER A

pf()
# Executed in 0.04 second(s) in Ring 1.23

/*---

pr()

o1 = new stzChar(12500)
? o1.Content() #--> ピ
? o1.Name() #--> KATAKANA LETTER PI

pf()
# Executed in 0.04 second(s) in Ring 1.23

/*---

pr()

? StzCharQ(" ").UnicodeCategory()	#--> separator_space

pf()
# Executed in 0.01 second(s) in Ring 1.23

/*---

pr()

? IsUnicodeHex("U+33B2") #--> TRUE

pf()
# Executed in 0.01 second(s) in Ring 1.23

/*---

pr()

o1 = new stzChar("LATIN CAPITAL LETTER N")
? o1.Content() #--> N

o1 = new stzChar("ARABIC LETTER SEEN")
? o1.Content() #--> س

o1 = new stzChar("ROMAN NUMERAL THREE")
? o1.Content() #--> Ⅲ

pf()
# Executed in 0.13 second(s) in Ring 1.23

/*---

pr()

? Unicode("ↈ") #--> 8584
? StzCharQ("ↈ").Name()	#--> ROMAN NUMERAL ONE HUNDRED THOUSAND

pf()
# Executed in 0.04 second(s) in Ring 1.23

/*---

pr()

? StzCharQ("O").Name()	#--> LATIN CAPITAL LETTER O
? StzCharQ("0").Name()	#--> DIGIT ZERO
? StzCharQ("Ⅲ").Name()	#--> ROMAN NUMERAL THREE
? StzCharQ("ↈ").Name()	#--> ROMAN NUMERAL ONE HUNDRED THOUSAND
? StzCharQ("⅜").Name()	#--> VULGAR FRACTION THREE EIGHTHS
? StzCharQ("☗").Name()	#--> BLACK SHOGI PIECE
? StzCharQ("꧌").Name()	#--> JAVANESE PADA PISELEH
? StzCharQ("س").Name()	#--> ARABIC LETTER SEEN

# And we have this fency syntax we can also use

? Q("◐").CharName()	#--> CIRCLE WITH LEFT HALF BLACK
? Q("◰").CharName()	#--> WHITE SQUARE WITH UPPER LEFT QUADRANT
? Q("☁").CharName()	#--> CLOUD

pf()
# Executed in 0.30 second(s) in Ring 1.23

/*---

pr()

? StzCharQ("百").Name()
#--> Can't proceed! The name of this char does not exist in the local unicode database.

pf()

/*---

pr()

? Q("◐◰☁").CharsNames()
#--> [ "CIRCLE WITH LEFT HALF BLACK", "WHITE SQUARE WITH UPPER LEFT QUADRANT", "CLOUD" ]

pf()
# Executed in 0.09 second(s) in Ring 1.23

/*---

pr()

# Also, try this ;)
? Q("⛅⛱☕").CharsNames()
#--> [ "SUN BEHIND CLOUD", "UMBRELLA ON GROUND", "HOT BEVERAGE" ]

pf()
# Executed in 0.08 second(s) in Ring 1.23

/*---

pr()

? FirstCharOf("Sinus") #--> S
? LastCharOf("Sinus") #--> s

? FirstLetterOf("Sinus") #--> S
? FirstLetterOf("***Sinus") #--> S

? LastLetterOf("Sinus") #--> s
? LastLetterOf("Sinus***") #--> s

pf()
# Executed in 0.03 second(s) in Ring 1.23

/*---

pr()

? StzCharQ("R").IsCharOf("Ring") 	#--> TRUE
? StzCharQ("R").IsLetterOf("Ring") 	#--> TRUE

pf()
# Executed in 0.01 second(s) in Ring 1.23

/*---

pr()

? StzCharQ("R").UnicodeCategoryNumber() #--> 14

? StzStringQ("RiNG").IsLowercase()	#--> FALSE
? StzCharQ("R").IsLetter() 		#--> TRUE

pf()
# Executed in 0.02 second(s) in Ring 1.23

/*---

pr()

? StzCharQ("_").IsWordNonLetterChar() #--> TRUE
? WordNonLetterChars()
#--> [ "_", "-", "*", "/", "\", "+", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" ]

pf()
# Executed in 0.01 second(s) in Ring 1.23

/*---

pr()

? RemoveDiacritic("ſ") #--> s

pf()
# Executed in 0.02 second(s) in Ring 1.23

/*---

pr()

? StzCharQ("é").DiacriticRemoved() #--> e
? StzCharQ("Ŵ").DiacriticRemoved() #--> W
? StzCharQ("ſ").DiacriticRemoved() #--> s

pf()
# Executed in 0.03 second(s) in Ring 1.23

/*---

pr()

? ArabicDiacriticsXT()
#-->
'
1571
1569
Arabic Hamza Kat3ia ontop of Aleef
أ --> ء
1572
1569
Arabic Hamza Kat3ia ontop of Waw
ؤ --> ء
1573
1569
Arabic Hamza Kat3ia under Aleef
إ --> ء
1574
1569
Arabic Hamza Kat3ia ontop of Waw
ئ --> ء
1611

Arabic Tinween of Fat7ah
عََ --> ع
1612

Arabic Tinween of Dhammah
عُُ --> ع
1613

Arabic Tinween of Kasrah
عِِ --> ع
1614

Arabic Fat7ah
عَ --> ع
1615

Arabic Dhammah
عُ --> ع
1616

Arabic Kasrah
عِ --> ع
1618

Arabic Sukoon
عْ --> ع
1617

Arabic Shaddah
عّ --> ع
1648

Arabic small Alif Mamdoodah
لٰكن --> لكن
1649
1575
Arabic Hamzah Wasliah Madhmoomah
ٱ --> ا
1570
1575
Arabic ََAlif Mamdoodah
آ --> ا
'

? ArabicDiacriticsUnicodes()
#-->
'
1569
1611
1612
1613
1614
1615
1616
1617
1618
1648
1649
1570
'

pf()
# Executed in almost 0 second(s) in Ring 1.23

/*---

pr()

? StzCharQ("à").IsDiacricised() #--> TRUE
? StzCharQ("à").IsLatinDiacritic() #--> TRUE

? StzCharQ(ArabicFat7ah()).IsDiacritic() #--> TRUE
? StzCharQ(ArabicFat7ah()).IsArabicDiacritic() #--> TRUE

pf()
# Executed in 0.02 second(s) in Ring 1.23

/*----
*/
pr()

? ShowShortXTNL(LatinDiacriticsXT(), 5)
#-->
'

'

? ShowShortXT(LatinDiacriticsUnicodes(), 5)
#-->
'

'
	
pf()

/*----

? StzCharQ("Â").IsLatinDiacritic() #--> TRUE

/*------

? InvertibleUnicodes()
? InvertibleChars()

/*------

? StzCharQ("v").IsInvertible() #--> TRUE
? StzCharQ("v").Inverted() #--> ʌ

/*-------------

? StzCharQ("f").Inverted()	#--> "f"

? StzCharQ("L").Inverted()	#--> "⅂"
? StzCharQ("I").Inverted()	#--> "I"
? StzCharQ("F").Inverted()	#--> "Ⅎ"
? StzCharQ("E").Inverted()	#--> "E"

/*-------------

? "LIFE"
? @("LIFE").Inverted() #--> ƎℲI⅂
? " "
? "GAYA"
? @("GAYA").Inverted() #--> Ɐ⅄Ɐ⅁
? " "
? "TELLAVIX (Y908$)"
? @("TELLAVIX (Y908$)").Inverted() #--> ($806⅄) XIɅⱯ⅂⅂ƎꞱ

/*-------------

? StzCharQ("V").Inverted()	#--> "Ʌ"
? StzCharQ("X").Inverted()	#--> "X"
? ""
? StzCharQ("☗").Inverted()	#--> "⛊"
? StzCharQ("❝").Inverted()	#--> "❞"
? StzCharQ("&").Inverted()	#--> "⅋"
? ""
? StzCharQ("꧌").Inverted()		#--> "꧍"

/*-------------

? UnicodeToChar(65021) #--> ﷽
? StzCharQ("﷽").Name()
#--> ARABIC LIGATURE BISMILLAH AR-RAHMAN AR-RAHEEM

/*-------------

? StringRepresentsNumberInUnicodeHexForm("U+214B")

/*-------------

? StzCharQ("U+214B").Content() #--> ⅋
? StzCharQ("0x214B").Name() #--> TURNED AMPERSAND

/*-------------

//? StzCharQ("🌹").Name() #--> ERROR: Can not create char object!
? Unicode("🌹") #--> [ 63, 63 ]
? @("🌹").CharName() # ?--> QUESTION MARK

/*-------------

? StzCharQ("k").Name() #--> LATIN SMALL LETTER K

/*-------------

? StzCharQ("n").IsVisible() #--> TRUE

? StzCharQ(8207).IsInvisible() #--> TRUE
? StzCharQ(8207).Name() #--> RIGHT-TO-LEFT MARK

/*-------------

? Arabic7araket()

/*-------------

? StzCharQ("a").IsAsciiLetter() #--> TRUE

/*---------


? StzCharQ("ỳ").IsDiacritic() #--> TRUE
? StzCharQ("ỳ").Name() #--> LATIN SMALL LETTER Y WITH GRAVE

? StzCharQ("ž").IsDiacritic() #--> TRUE
? StzCharQ("ž").Name() #--> LATIN SMALL LETTER Z WITH CARON

? StzCharQ("đ").IsDiacritic() #--> TRUE
? StzCharQ("đ").Name() #--> LATIN SMALL LETTER D WITH STROKE

? StzcharQ("é").IsDiacritic() #--> TRUE
? StzcharQ("é").Name() #--> LATIN SMALL LETTER E WITH ACUTE

? StzCharQ("ῃ").IsDiacritic() #--> FALSE
? StzCharQ("ῃ").Name() #--> GREEK SMALL LETTER ETA WITH YPOGEGRAMMENI

? StzCharQ("ὸ").IsDiacritic() #--> FALSE
? StzCharQ("ὸ").Name() #--> GREEK SMALL LETTER OMICRON WITH VARIA

? StzCharQ("ὑ").IsDiacritic() #--> FALSE
? StzCharQ("ὑ").Name() #--> GREEK SMALL LETTER UPSILON WITH DASIA

? StzCharQ("ē").IsDiacritic() #--> TRUE
? StzCharQ("ē").Name() #--> LATIN SMALL LETTER E WITH MACRON

? StzCharQ("ُ").IsDiacritic() #--> TRUE
? StzCharQ("ُ").Name() #--> ARABIC DAMMA

? StzCharQ("׳").IsDiacritic() #--> FALSE
? StzCharQ("׳").Name() #--> HEBREW PUNCTUATION GERESH

/*-------------

? StzCharQ("é").DiacriticRemoved() #--> "e"
? StzCharQ("æ").DiacriticRemoved() #--> "a"
? StzCharQ("Ķ").DiacriticRemoved() #--> "k"
? StzCharQ("œ").DiacriticRemoved() #--> "o"

? StzCharQ("ſ").RemoveDiacriticQ().Content() #--> "s"

/*-------------

? DiacriticsXT()

/*-------------

? DiacriticDescription("Ķ") #--> Capital K, cedilla accent

/*-------------

? DiacriticsOfAsciiLetter("k") #--> [ "ķ", "ĸ" ]

/*--------------

? TurnedChars() #TODO // This make confusion with InvertedChars: solve it!

/*--------------

? StzCharQ("ʍ").IsTurnedChar() #--> TRUE
? StzCharQ("ᴟ").IsTurnedChar() #--> TRUE
? StzCharQ("ꟺ").IsTurnedChar() #--> TRUE

/*-------------

o1 = new stzChar("-")
? o1.IsLetter() #--> FALSE
? o1.Islowercase() #--> FALSE

/*------------

o1 = new stzChar("ح")
? o1.ScriptIs(:Arabic) #--> TRUE
? o1.IsArabicScript()  #--> TRUE

o1 = new stzChar("j")
? o1.ScriptIs(:Latin) #--> TRUE
? o1.IsLatinScript()  #--> TRUE

/*-------------

? Unicode("ُ") #--> 1615

o1 = new stzChar("ُ")

? o1.IsArabic7arakah() #--> TRUE

? o1.Name() #--> ARABIC DAMMA
? o1.NameIs("ARABIC DAMMA") #--> TRUE

/*-------------

? StzCharQ("،").IsWordSeparator() 	#--> TRUE
? StzCharQ(" ").IsWordSeparator() 	#--> TRUE
? StzCharQ(".").IsSentenceSeparator() 	#--> TRUE
? StzCharQ(NL).IsLineSeparator() 	#--> TRUE

/*-------------

o1 = new stzChar("X")
? o1.AsciiCode() #--> 88

o1 = new stzChar("س")
? o1.AsciiCode() #--> ERROR: Can't get ASCII code for this character!

/*-------------

o1 = new stzChar(" ")
? o1.IsSpace() #--> TRUE

/*-------------

o1 = new stzChar("٠")
? o1.Script()	#--> arabic
? o1.unicode()	#--> 1632
? o1.IsDigit()	#--> TRUE
? o1.Name()	#--> ARABIC-INDIC DIGIT ZERO
? ""
o1 = new stzChar("۰")
? o1.Script()	#--> arabic
? o1.unicode()	#--> 1776
? o1.IsDigit()	#--> TRUE
? o1.Name()	#--> EXTENDED ARABIC-INDIC DIGIT ZERO
? ""
o1 = new stzChar("3")
? o1.Script()	#--> common
? o1.IsDigit()	#--> TRUE
? o1.Name()	#--> DIGIT THREE
? ""
o1 = new stzChar("૫") 
? o1.Script()	#--> gujarati
? o1.IsDigit()	#--> TRUE
? o1.Name()	#--> GUJARATI DIGIT FIVE
? ""
o1 = new stzChar("၉")
? o1.Script()	#--> myanmar
? o1.IsDigit()	#--> TRUE
? o1.Name()	#--> MYANMAR DIGIT NINE
? ""
o1 = new stzChar("꧓")
? o1.Script()	#--> javanese
? o1.IsDigit()	#--> TRUE
? o1.Name()	#--> JAVANESE DIGIT THREE
? ""
o1 = new stzChar(43217) # I used unicode because the char itself is imprintable ꣑
? o1.Script()	#--> saurashtra
? o1.IsDigit()	#--> TRUE
? o1.Name()	#--> SAURASHTRA DIGIT ONE
? ""
o1 = new stzChar("൫") 
? o1.Script()	#--> malayalam
? o1.IsDigit()	#--> TRUE
? o1.Name()	#--> MALAYALAM DIGIT FIVE
? ""
o1 = new stzChar("０")
? o1.Script()	#--> common
? o1.IsDigit()	#--> TRUE
? o1.Name()	#--> FULLWIDTH DIGIT ZERO

/*------------- TODO: Make it possible...

c1 = new stzChar("1/3") #--> ERROR: Can not create char object! 
? c1.Content()

/*-------------

c1 = new stzChar("೨")
? c1.Unicode() #--> 3304
? c1.IsANumber() #--> TRUE
? c1.IsDigit() #--> TRUE

? c1.UnicodeCategory() #--> number_decimaldigit
? c1.Script() #--> kannada
? c1.Name() #--> KANNADA DIGIT TWO

/*-------------

? CurrentUnicodeVersion() #--> 13.0

/*-------------

? LanguagesInScript(:cyrillic)
#--> 	belarusian
#	bosnian
#	bulgarian
#	kazakh
#	kyrgyz
#	ladino
#	macedonian
#	mongolian
#	montenegrin
#	persian
#	russian
#	serbian
#	ukrainian

/*-------------

? LanguagesInScript(:arabic)
#--> 	acehnese, adyghe, afar, afrikaans, algerian, amazigh, arabic, arwi,
#	azerbaijani, bakhtiari, balochi, balti, banjar, bashkir, belarusian,
#	bengali, bhadrawahi, bosnian, brahui, burushaski, centralkurdish, cham, 
#	chechen, chinese, comorian, crimeantatar, dari, dogri, dungan, dyula,
#	egyptian, filipino, french, fulani, gilaki, greek, harari, hausa,
#	ingush, iraqi, javanese, jolafonyi, judaeospanish, judeoarabic,
#	judeotunisianarabic, kanuri, karakalpak, kashmiri, kazakh, khowar,
#	kurdish, kyrgyz, lak, lebanese, lezgin, luri, madurese, malagasy,
#	malay, mandinka, marwari, mazanderani, minangkabau, moroccan,
#	mozarabic, ngai, nobiin, ottomanturkish, pashtu, persian, punjabi,
#	qashqai, rohingya, salar, saraiki, sindhi, somali, songhay, spanish,
#	swahili, tajik, talysh, tatar, tausug, tuareg, tunisian, turkish,
#	turkmen, urdu, uyghur, 	uzbek, wakhi, wolio, wolof, yoruba, zarma

/*-------------

o1 = new stzChar("⅋")
? o1.Name() #--> TURNED AMPERSAND
? o1.IntroducedInUnicodeVersion() #--> 3.2
? o1.UnicodeCategory() #--> symbol_math
? o1.IsTurnedChar() #--> TRUE

/*-------------

? CommonLanguagesInScripts([ :cyrillic, :arabic ]) #TODO // Check the performance lag!
#--> 	belarusian
#	bosnian
#	kazakh
#	kyrgyz
#	persian

/*-------------

? CommonLanguagesInScripts([ :cyrillic, :latin ]) #TODO // Check the performance lag!
#--> 	belarusian
#	bosnian
#	bulgarian
#	kazakh
#	ladino
#	mongolian
#	montenegrin
#	serbian
#	hungarian
/*-------------

? CommonLanguagesInScripts([ :armenian, :latin ]) #TODO // Check the performance lag!
#--> 	belarusian
#	hungarian
#	serbian

/*-------------

? Languages()
#--> 	c, :abkhazian, :oromo, :afar, :afrikaans, :albanian, :amharic,
#	:arabic, :armenian, :assamese, :aymara, :azerbaijani, :bashkir,
#	:basque, :bengali, :dzongkha, :bislama, :breton, :bulgarian,
#	:burmese, :belarusian, :khmer, :catalan, :chinese, :corsican,
#	:croatian, :czech, :danish, :dutch, :english, :esperanto, :estonian,
#	:faroese, :fijian, :finnish, :french, :western_frisian, :gaelic,
#	:galician, :georgian, :german, :greek, :greenlandic, :guarani,
#	:gujarati, :hausa, :hebrew, :hindi, :hungarian, :icelandic,
#	:indonesian, :interlingua, :interlingue, :inuktitut, :inupiak,
#	:irish, :italian, :japanese, :javanese, :kannada, :kashmiri,
#	:kazakh, :kinyarwanda, :kirghiz, :korean, :kurdish, :rundi,
#	:lao, :latin, :latvian, :lingala, :lithuanian, :macedonian,
#	:malagasy, :malay, :malayalam, :maltese, :maori, :marathi,
#	:marshallese, :mongolian, :nauruan, :nepali, :norwegian_bokmal,
#	:occitan, :oriya, :pashto, :persian, :polish, :portuguese, :punjabi,
#	:quechua, :romansh, :romanian, :russian, :samoan, :sango, :sanskrit,
#	:serbian, :ossetic, :southern_sotho, :tswana, :shona, :sindhi, :sinhala,
#	:swati, :slovak, :slovenian, :somali, :spanish, :sundanese, :swahili,
#	:swedish, :sardinian, :tajik, :tamil, :tatar, :telugu, :thai, :tibetan,
#	:tigrinya, :tongan, :tsonga, :turkish, :turkmen, :tahitian, :uighur,
#	:ukrainian, :urdu, :uzbek, :vietnamese, :volapuk, :welsh, :wolof,
#	:xhosa, :yiddish, :yoruba, :zhuang, :zulu, :norwegian_nynorsk, :bosnian,
#	:divehi, :manx, :cornish, :akan, :konkani, :ga, :igbo, :kamba, :syriac,
#	:blin, :geez, :koro, :sidamo, :atsam, :tigre, :jju, :friulian, :venda,
#	:ewe, :walamo, :hawaiian, :tyap, :nyanja, :filipino, :swiss_german,
#	:sichuan_yi, :kpelle, :low_german, :south_ndebele, :northern_sotho,
#	:northern_sami, :taroko, :gusii, :taita, :fulah, :kikuyu, :samburu,
#	:sena, :north_ndebele, :rombo, :tachelhit, :kabyle, :nyankole, :bena,
#	:vunjo, :bambara, :embu, :cherokee, :mauritian, :makonde, :langi, :ganda,
#	:bemba, :kabuverdianu, :meru, :kalenjin, :nama, :machame, :colognian,
#	:masai, :soga, :luyia, :asu, :teso, :saho, :koyra_chiini, :rwa, :luo,
#	:chiga, :standard_morocco_tamazight, :koyraboro_senni, :shambala, :bodo,
#	:avaric, :chamorro, :chechen, :church, :chuvash, :cree, :haitian, :herero,
#	:hiri_motu, :kanuri, :komi, :kongo, :kwanyama, :limburgish, :luba_katanga,
#	:luxembourgish, :navaho, :ndonga, :ojibwa, :pali, :walloon, :aghem, :basaa,
#	:zarma, :duala, :jola_fonyi, :ewondo, :bafia, :makhuwa_meetto, :mundang,
#	:kwasio, :coptic, :sakha, :sangu, :tasawaq, :vai, :walser, :yangben,
#	:avestan, :ngomba, :kako, :meta, :ngiemboon, :aragonese, :akkadian,
#	:ancient_egyptian, :ancient_greek, :aramaic, :balinese, :bamun, :batak_toba,
#	:buginese, :chakma, :dogri, :gothic, :ingush, :mandingo, :manipuri, :old_irish,
#	:old_norse, :old_persian, :pahlavi, :phoenician, :santali, :saurashtra,
#	:tai_dam, :tai_nua, :ugaritic, :akoose, :lakota, :standard_moroccan_tamazight,
#	:mapuche, :central_kurdish, :lower_sorbian, :upper_sorbian, :kenyang, :mohawk,
#	:nko, :prussian, :kiche, :southern_sami, :lule_sami, :inari_sami, :skolt_sami,
#	:warlpiri, :mende, :maithili, :american_sign_language, :bhojpuri,
#	:literary_chinese, :mazanderani, :newari, :northern_luri, :palauan,
#	:papiamento, :tokelauan, :tok_pisin, :tuvaluan, :cantonese, :osage, :ido,
#	:lojban, :sicilian, :southern_kurdish, :western_balochi, :cebuano, :erzya,
#	:chickasaw, :muscogee, :silesian

/*-------------

? ScriptsForLanguage(:belarusian) #TODO

/*-------------

? CharScript(",") 	#--> common
? CharScript("⅀") 	#--> common
? CharScript("ظ") 	#--> arabic
? CharScript("ܞ")  	#--> syriac

? CharScript("డ") 	#--> telugu
? CharScript("ল") 	#--> bengali
? CharScript("Ϡ") 	#--> greek
? CharScript("Ж") 	#--> cyrillic
? CharScript("经") 	#--> han

/*-------------

? StzCharQ(",").Name()	#--> COMMA
? StzCharQ("⅀").Name()	#--> DOUBLE-STRUCK N-ARY SUMMATION
? StzCharQ("ظ").Name()	#--> ARABIC LETTER ZAH
? StzCharQ("ܞ") .Name()	#--> SYRIAC LETTER YUDH HE

? StzCharQ("డ").Name()	#--> TELUGU LETTER DDA
? StzCharQ("ল").Name()	#--> BENGALI LETTER LA
? StzCharQ("Ϡ").Name()	#--> GREEK LETTER SAMPI
? StzCharQ("Ж").Name()	#--> CYRILLIC CAPITAL LETTER ZHE

? StzCharQ("经").Name()	#--> _NULL_ (Name inexistant in stzUnicodeData.ring file)

/*-------------

o1 = new stzChar(8204)
? CharScript( o1.Content() ) # inherited

/*-------------

? LanguagesInScript(CharScript("ض"))
? StzScriptQ(CharScript("ض")).Languages()

/*-------------

? CurrentUnicodeVersion() #--> 13.0
o1 = new stzChar("四")
? o1.UnicodeVersion() #--> 1.1
? o1.IntroducedInUnicodeVersion() #--> 1.1

/*-------------

? MandarinNumbersXT()
#--> [ [ "〇", 0 ], [ "一", 1 ], [ "二", 2 ], [ "三", 3 ],
#	[ "四", 4 ], [ "五", 5 ], [ "六", 6 ], [ "七", 7 ],
#	[ "八", 8 ], [ "九", 9 ], [ "十", 10 ], [ "百", 100 ],
#	[ "千", 1000 ], [ "万", 10000 ] ]

/*-------------

? RomanNumbersXT()
#--> [ [ "Ⅰ", 1 ], [ "ⅰ", 1 ], [ "Ⅱ", 2 ], [ "ⅱ", 2 ],
#	[ "Ⅲ", 3 ], [ "ⅲ", 3 ], [ "Ⅳ", 4 ], [ "ⅳ", 4 ],
#	[ "Ⅴ", 5 ], [ "ⅴ", 5 ], [ "Ⅵ", 6 ], [ "ⅵ", 6 ],
#	[ "Ⅶ", 7 ], [ "ⅶ", 7 ], [ "Ⅷ", 8 ], [ "ⅷ", 8 ],
#	[ "Ⅸ", 9 ], [ "ⅸ", 9 ], [ "Ⅹ", 10 ], [ "ⅹ", 10 ],
#	[ "Ⅺ", 11 ], [ "ⅺ", 11 ], [ "Ⅻ", 12 ], [ "ⅻ", 12 ],
#	[ "Ⅼ", 50 ], [ "ⅼ", 50 ], [ "Ⅽ", 100 ], [ "ⅽ", 100 ],
#	[ "Ↄ", 100 ], [ "ↄ", 100 ], [ "Ⅾ", 500 ], [ "ⅾ", 500 ],
#	[ "Ⅿ", 1000 ], [ "ⅿ", 1000 ], [ "ↀ", 1000 ], [ "ↁ", 5000 ],
#	[ "ↂ", 10000 ], [ "ↅ", 6 ], [ "ↆ", 50 ], [ "ↇ", 50000 ],
#	[ "ↈ", 100000 ] ]

/*-------------

o1 = new stzChar("Ⅺ")
? o1.lowercased() #--> ⅺ

o1 = new stzChar("ⅺ")
? o1.UPPERcased() #--> Ⅺ

/*-------------

? CircledDigits() #--> ①, ②, ③, ④, ⑤, ⑥, ⑦, ⑧, ⑨, ⓪
? CircledDigitUnicodes() #--> 9312:9320 + 9450

/*-------------

o1 = new stzChar("Σ")
? o1.IsLowercase() #--> FALSE
? o1.IsUPPERcase() #--> TRUE
? o1.CharCase() #--> uppercase

o1 = new stzChar("σ")
? o1.IsLowercase() #--> TRUE
? o1.IsUppercase() #--> FALSE
? o1.CharCase() #--> lowercase

/*-------------

o1 = new stzChar("ﮘ")
o1 {
	? Content()			#--> ﮘ
	? Unicode()			#--> 64408

	? IsArabic()			#--> TRUE
	? IsArabicLetter()		#--> TRUE

	? IsArabicPresentationForm()	#--> TRUE
	? IsArabicPresentationFormA()	#--> TRUE
	? IsArabicPresentationFormB()	#--> FALSE
}

/*-------------

? QuranicSigns()

/*-------------

o1 = new stzChar("۩")
o1 {
	? Content()			#--> ۩
	? Unicode()			#--> 1769

	? IsArabic()			#--> TRUE
	? IsArabicLetter()		#--> FALSE

	? IsQuranicSign()		#--> TRUE
}

/*-------------

? ArabicNumberFractions()

/*-------------

o1 = new stzChar("⅗")
? o1.IsArabicFraction() #--> TRUE

/*-------------

o1 = new stzChar("万")
? o1.IsMandarinNumber() #--> TRUE

/*-------------

? StzCharQ(12295).Content() #--> 〇
? StzCharQ(12295).Name() #--> IDEOGRAPHIC NUMBER ZERO

/*-------------

o1 = new stzChar(64544)
? o1.Content() #--> "ﰠ"

? StzCharQ("ﰠ").Name() # ARABIC LIGATURE SAD WITH HAH ISOLATED FORM

/*-------------

o1 = new stzChar("ↈ")
? o1.Unicode() #--> 8584
? o1.IsRomanNumber() #--> TRUE

/*-------------

? RomanToDecimalNumber("ↈ") #TODO

/*-------------

o1 = new stzChar("෴")
? o1.Unicode() #--> 3572

o1 = new stzChar(3572)
? o1.Content() #--> ෴
? o1.Name() #--> SINHALA PUNCTUATION KUNDDALIYA

/*-------------

? "۲" = "٢" #--> FALSE
o1 = new stzChar("۲")
? o1.Name() #--> EXTENDED ARABIC-INDIC DIGIT TWO
? o1.Unicode() #--> 1778
? o1.UnicodeCategory() #--> number_decimaldigit
? o1.IsIndianDigit() #--> TRUE
? ""
o1 = new stzChar("٢")
? o1.Name() #--> ARABIC-INDIC DIGIT TWO
? o1.Unicode() # 1634
? o1.UnicodeCategory() #--> number_decimaldigit
? o1.IsIndianDigit() #--> TRUE

/*-------------

o1 = new stzChar("O")
? o1.Name() #--> LATIN CAPITAL LETTER O
? o1.Unicode() #--> 79
? o1.UnicodeCategory() #--> letter_uppercase
? ""
o1 = new stzChar("Ο")
? o1.Name() #--> GREEK CAPITAL LETTER OMICRON
? o1.Unicode() #--> 927
? o1.UnicodeCategory() #--> letter_uppercase

/*-------------

_cRightToLeftOverride = "‮"
// Do you think this is an empty Char?
// Let's see...

o1 = new stzChar(_cRightToLeftOverride)
? o1.IsEmpty() # It's not! (returns FALSE)

// Nor it is a whitespace...
? o1.IsWhitespace() #--> FALSE

// Let's see why?
? o1.UnicodeCategory() # it belongs to other_format unicode category
? o1.Unicode() # it has a unicode (8238)
? o1.IsPrintable() # it's not printable
? o1.IsRightToLeftOverride() # it's the RLO unicode Char!

// What if we see its name!
? o1.Name() #--> RIGHT-TO-LEFT OVERRIDE

/*-------------

# Be careful: there is a hidden char that inverted the text "freind" and
# forced it to be written from right to left!

txt = "dear ‮friends!"

? txt

# Trying to get it in pure Ring

for c in txt
	? c
next

# Trying to know it in Softanza

o1 = new stzString(txt)
? o1.Content()
? o1.Chars()

/*-------------

o1 = new stzChar("و")
//o1 = new stzChar(1606)

? o1.Content() #--> و
? o1.Unicode() #--> 1608
? o1.NumberOfBytes() #--> 2
? o1.Orientation() #--> righttoleft
? o1.UnicodeDirectionNumber() #--> "13"
? o1.UnicodeDirection() #--> righttoleftarabic

? o1.Bytes()

/*-------------

ostr = new stzString("s㊱m")
? ostr.NumberOfChars() #--> 3
? ostr[2] #--> ㊱

/*-------------

o1 = new stzChar("㊱")
? o1.Unicode() #--> 12977
? o1.NumberOfBytes() #--> 3

/*-------------

o1 = new stzString("s㊱m")
? o1.NumberOfBytes() #--> 5
? o1.SizeInBytes() #--> 5

? o1.Bytes()

? o1.NumberOfBytesPerChar()
#-->	[ :s = 1, :㊱ = 3, :m = 1 ]

/*-------------

o1 = new stzChar("6")
? o1.IsANumber() # -> TRUE
? o1.IsDigit()	 # -> TRUE

/*-------------

# The "A":"E" syntax is a beautiful feature of Ring:

? "A" : "E"	#--> [ "A", "B", "C", "D", "E" ]

# And it works backward also like this:

? "E" : "A"	#--> [ "E", "D", "C", "B", "A" ]

# Softanza reproduces it using UpTo() and DownTo() functions:

? StzCharQ("A").UpTo("E")	#--> [ "A", "B", "C", "D", "E" ]
? StzCharQ("E").DownTo("A")	#--> [ "E", "D", "C", "B", "A" ]

# And extends it to cover any Unicode char not only ASCII chars
# as it is the case for the Ring syntax:

? StzCharQ("ب").UpTo("ج") 	#--> [ "ب", "ة", "ت", "ث", "ج" ]
? StzCharQ("ج").DownTo("ب")	#--> [ "ج", "ث", "ت", "ة", "ب" ]
