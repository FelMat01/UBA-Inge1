!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'MF 9/11/2021 18:24:24'!
* aMultiplier 
	
	^aMultiplier multiplyByInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MF 9/11/2021 17:48:35'!
+ anAdder 
	
	^anAdder addInteger: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MF 9/11/2021 18:48:58'!
- aSubtrahend 
	
	^aSubtrahend subtractToInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MF 9/11/2021 19:28:53'!
/ aDivisor 
	
	^aDivisor divideToInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MF 9/13/2021 22:51:51'!
fibonacci

	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'private - arithmetic with fractions' stamp: 'MF 9/11/2021 18:12:15'!
addFraction: aFractionAdder 
	
	^self + aFractionAdder.! !

!Entero methodsFor: 'private - arithmetic with fractions' stamp: 'MF 9/11/2021 19:27:40'!
divideToFraction: aFractionDividend

	^aFractionDividend numerator / (aFractionDividend denominator * self).! !

!Entero methodsFor: 'private - arithmetic with fractions' stamp: 'MF 9/11/2021 18:31:42'!
multiplyByFraction: aFractionMultiplier
	
	^self * aFractionMultiplier.! !

!Entero methodsFor: 'private - arithmetic with fractions' stamp: 'MF 9/13/2021 22:04:34'!
subtractToFraction: aFractionMinuend
	
	^aFractionMinuend numerator - (self * aFractionMinuend denominator) / aFractionMinuend denominator! !


!Entero methodsFor: 'private - arithmetic with integers' stamp: 'MF 9/13/2021 20:30:25'!
addInteger: anIntegerAdder

	^anIntegerAdder class with: anIntegerAdder integerValue + value
! !

!Entero methodsFor: 'private - arithmetic with integers' stamp: 'MF 9/13/2021 20:37:55'!
divideToInteger: anIntegerDividend
	
	^Fraccion with: anIntegerDividend over: self.! !

!Entero methodsFor: 'private - arithmetic with integers' stamp: 'MF 9/11/2021 18:21:32'!
multiplyByInteger: anIntegerMultiplier 

	^self class with: value * anIntegerMultiplier integerValue.! !

!Entero methodsFor: 'private - arithmetic with integers' stamp: 'MF 9/11/2021 19:29:48'!
subtractToInteger: anIntegerMinuend
	
	^self class with: anIntegerMinuend integerValue - value.! !


!Entero methodsFor: 'private - fraction making' stamp: 'MF 9/15/2021 18:32:35'!
makeFractionOver: aDenominator

	^Fraccion new initializeWith: self over: aDenominator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'MF 9/14/2021 17:47:33'!
with: aValue 
		
	^(Entero allSubclasses 
		detect: [ :anIntegerClass | anIntegerClass isClassOf: aValue ]
		ifNone: [ self error: 'aValue debe ser anInteger' ]) new initalizeWith: aValue.! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'MF 9/13/2021 22:59:41'!
fibonacci

	self error: self class negativeFibonacciErrorDescription.! !


!EnteroNegativo methodsFor: 'private - fraction making' stamp: 'MF 9/15/2021 18:31:15'!
makeFractionDividing: aNumerator

	^aNumerator negated makeFractionOver: self negated.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativo class' category: 'Numero-Exercise'!
EnteroNegativo class
	instanceVariableNames: ''!

!EnteroNegativo class methodsFor: 'testing' stamp: 'MF 9/14/2021 17:45:44'!
isClassOf: aValue

	^aValue isInteger and: [ aValue negative ].! !


!classDefinition: #EnteroNoNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNoNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNoNegativo class' category: 'Numero-Exercise'!
EnteroNoNegativo class
	instanceVariableNames: ''!

!EnteroNoNegativo class methodsFor: 'testing' stamp: 'MF 9/13/2021 23:26:20'!
isClassOf: anIntegerValue

	^false.! !


!classDefinition: #Cero category: 'Numero-Exercise'!
EnteroNoNegativo subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic operations' stamp: 'MF 9/13/2021 22:53:45'!
fibonacci

	^Entero with: 1! !


!Cero methodsFor: 'private - fraction making' stamp: 'MF 9/15/2021 18:26:25'!
makeFractionDividing: aNumerator

	^self error: self class canNotDivideByZeroErrorDescription.! !

!Cero methodsFor: 'private - fraction making' stamp: 'MF 9/15/2021 18:32:07'!
makeFractionOver: aDenominator

	^self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: 'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'testing' stamp: 'MF 9/14/2021 17:46:09'!
isClassOf: aValue

	^aValue isInteger and: [ aValue isZero ].! !


!classDefinition: #EnteroPositivoNoUno category: 'Numero-Exercise'!
EnteroNoNegativo subclass: #EnteroPositivoNoUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroPositivoNoUno methodsFor: 'arithmetic operations' stamp: 'MF 9/13/2021 22:54:43'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci! !


!EnteroPositivoNoUno methodsFor: 'private - fraction making' stamp: 'MF 9/15/2021 18:35:32'!
makeFractionDividing: aNumerator

	^aNumerator makeFractionOver: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroPositivoNoUno class' category: 'Numero-Exercise'!
EnteroPositivoNoUno class
	instanceVariableNames: ''!

!EnteroPositivoNoUno class methodsFor: 'testing' stamp: 'MF 9/14/2021 17:46:18'!
isClassOf: aValue

	^aValue isInteger and: [ aValue > 1 ].! !


!classDefinition: #Uno category: 'Numero-Exercise'!
EnteroNoNegativo subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'MF 9/13/2021 22:54:25'!
fibonacci

	^Entero with: 1.! !


!Uno methodsFor: 'private - fraction making' stamp: 'MF 9/15/2021 18:31:01'!
makeFractionDividing: aNumerator

	^aNumerator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: 'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'testing' stamp: 'MF 9/14/2021 17:46:26'!
isClassOf: aValue

	^aValue isInteger and: [ aValue = 1 ].! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MF 9/11/2021 18:32:20'!
* aMultiplier 
	
	^aMultiplier multiplyByFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MF 9/11/2021 18:12:31'!
+ anAdder 
		
	^anAdder addFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MF 9/14/2021 17:13:05'!
- aSubtrahend 
	
	^aSubtrahend subtractToFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MF 9/14/2021 17:13:09'!
/ aDivisor 
	
	^aDivisor divideToFraction: self.! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'private - arithmetic with integers' stamp: 'MF 9/13/2021 20:30:55'!
addInteger: anIntegerAdder

	^anIntegerAdder * self denominator + self numerator / self denominator.! !

!Fraccion methodsFor: 'private - arithmetic with integers' stamp: 'MF 9/11/2021 19:22:32'!
divideToInteger: anIntegerDividend 
	
	^anIntegerDividend * denominator / numerator.! !

!Fraccion methodsFor: 'private - arithmetic with integers' stamp: 'MF 9/13/2021 20:37:26'!
multiplyByInteger: anIntegerMultiplier

	^anIntegerMultiplier * self numerator / self denominator.! !

!Fraccion methodsFor: 'private - arithmetic with integers' stamp: 'MF 9/11/2021 18:48:49'!
subtractToInteger: anIntegerMinuend

	^anIntegerMinuend * self denominator - self numerator / self denominator.! !


!Fraccion methodsFor: 'private - arithmetic with fractions' stamp: 'MF 9/11/2021 18:06:13'!
addFraction: aFractionAdder 
	
	| newNumerator newDenominator |
	
	newNumerator := (numerator * aFractionAdder denominator) + (denominator * aFractionAdder numerator).
	newDenominator := denominator * aFractionAdder denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'private - arithmetic with fractions' stamp: 'MF 9/11/2021 19:26:12'!
divideToFraction: aFractionDividend
	
	^(aFractionDividend numerator *  denominator) / (aFractionDividend denominator *  numerator)! !

!Fraccion methodsFor: 'private - arithmetic with fractions' stamp: 'MF 9/11/2021 19:30:23'!
multiplyByFraction: aFractionMultiplier
	
	^(numerator * aFractionMultiplier numerator) / (denominator * aFractionMultiplier denominator).! !

!Fraccion methodsFor: 'private - arithmetic with fractions' stamp: 'MF 9/11/2021 19:03:45'!
subtractToFraction: aFractionMinuend 
	
	| newNumerator newDenominator |
		
	newNumerator := (aFractionMinuend numerator * denominator) - (aFractionMinuend denominator *  numerator).
	newDenominator := aFractionMinuend denominator *  denominator.
	
	^newNumerator / newDenominator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'MF 9/15/2021 18:32:51'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	^denominator makeFractionDividing: numerator.
	! !
