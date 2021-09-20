!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'emptyStack prefixToSearch sentenceWithPrefix anotherSentenceWithPrefix sentenceWithoutPrefix sentenceCaseSensitiveWithoutPrefix stackWithOneSentence caseSensitiveStack stackWithOneSentenceWithoutPrefix stackWithManySentencesWithPrefixInOnlyOneSentence stackWithManySentencesWithPrefixInManySentences sentenceFinderWithEmptyStack sentenceFinderWithStackWithOneSentenceWithoutPrefix sentenceFinderWithStackWithOneSentence sentenceFinderWithStackWithManySentencesWithPrefixInOnlyOneSentence sentenceFinderWithStackWithManySentencesWithPrefixInManySentences sentenceFinderWithCaseSensitiveStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LNB 9/20/2021 14:34:01'!
test01WhenStackIsEmptyReturnsEmptyCollection
	
	self assert: (sentenceFinderWithEmptyStack find) isEmpty. 
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LNB 9/20/2021 14:34:01'!
test02WhenNoSentenceHasPrefixReturnsEmptyCollection

	self assert: (sentenceFinderWithStackWithOneSentenceWithoutPrefix find) isEmpty.
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LNB 9/20/2021 14:34:01'!
test03OnlyOneSentenceWithPrefixReturnsSentence

	| foundSentences |
	
	foundSentences := sentenceFinderWithStackWithOneSentence find.
	
	self assert: foundSentences includes: sentenceWithPrefix. 
	self assert: foundSentences size = 1.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LNB 9/20/2021 14:34:01'!
test04MoreThanOneSentenceWithOnlyOneWithPrefixReturnsOnlyThatSentence

	| foundSentences |
	
	foundSentences := sentenceFinderWithStackWithManySentencesWithPrefixInOnlyOneSentence find.
	
	self assert: foundSentences includes: sentenceWithPrefix .
	self assert: foundSentences size = 1.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LNB 9/20/2021 14:34:01'!
test05MultipleSentencesWithPrefixReturnsAll

	| foundSentences |

	foundSentences := sentenceFinderWithStackWithManySentencesWithPrefixInManySentences find.
	
	self assert: foundSentences includes: sentenceWithPrefix.
	self assert: foundSentences includes: anotherSentenceWithPrefix.
	self assert: foundSentences size = 2.
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'dd 9/20/2021 15:50:16'!
test06CanNotFindWithEmptyPrefix
	
	self should: [ SentenceFinderByPrefix withPrefix: '' AndStack: emptyStack. ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDescription]
		! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'dd 9/20/2021 15:50:25'!
test07CanNotFindWithPrefixWithOnlySpaces
	
	self should: [ SentenceFinderByPrefix withPrefix: '   ' AndStack: emptyStack. ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDescription]
		! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'dd 9/20/2021 15:50:40'!
test08CanNotFindWithPrefixWithSpaces

	self should: [ SentenceFinderByPrefix withPrefix: 'Lorem   Ipsum ' AndStack: emptyStack. ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDescription]
		! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LNB 9/20/2021 14:34:01'!
test09FindIsCaseSensitive

	| foundSentences |
	
	foundSentences := sentenceFinderWithCaseSensitiveStack find.
	
	self assert: foundSentences includes: sentenceWithPrefix.
	self deny: (foundSentences includes: sentenceCaseSensitiveWithoutPrefix).
	self assert: foundSentences size = 1.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'dd 9/20/2021 15:50:50'!
test10FindDoesNotChangeStack

	| aStack orderedSentenceFinder |
	aStack := OOStack new.
	aStack push: 'first sentence'.
	aStack push: 'second sentence'.
	
	orderedSentenceFinder := (SentenceFinderByPrefix withPrefix: prefixToSearch AndStack: aStack).

	orderedSentenceFinder find.
	
	self assert: (aStack pop = 'second sentence').
	self assert: (aStack pop = 'first sentence').! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'dd 9/20/2021 15:49:40'!
setUp
	
	prefixToSearch := 'Lorem'.
	
	sentenceWithPrefix := 'Lorem Ipsum Dolor'.
	
	anotherSentenceWithPrefix := 'LoremIpsumDolor'.
	
	sentenceWithoutPrefix := 'Ipsum Lorem Dolor'.
	
	sentenceCaseSensitiveWithoutPrefix := 'lorem ipsum dolor'.
	
	emptyStack := OOStack new.
	
	stackWithOneSentence := OOStack new.
	stackWithOneSentence push: sentenceWithPrefix.
	
	stackWithOneSentenceWithoutPrefix := OOStack new.
	stackWithOneSentenceWithoutPrefix push: sentenceWithoutPrefix.
	
	stackWithManySentencesWithPrefixInOnlyOneSentence := OOStack new.
	stackWithManySentencesWithPrefixInOnlyOneSentence push: sentenceWithPrefix.
	stackWithManySentencesWithPrefixInOnlyOneSentence push: sentenceWithoutPrefix.
	
	stackWithManySentencesWithPrefixInManySentences := OOStack new.
	stackWithManySentencesWithPrefixInManySentences push: sentenceWithPrefix.
	stackWithManySentencesWithPrefixInManySentences push: anotherSentenceWithPrefix.
	
	caseSensitiveStack := OOStack new.
	caseSensitiveStack push: sentenceWithPrefix.
	caseSensitiveStack push: sentenceCaseSensitiveWithoutPrefix.
	
	sentenceFinderWithEmptyStack := SentenceFinderByPrefix withPrefix: prefixToSearch AndStack: emptyStack.
	
	sentenceFinderWithStackWithOneSentenceWithoutPrefix := SentenceFinderByPrefix withPrefix: prefixToSearch AndStack: stackWithOneSentenceWithoutPrefix.
	
	sentenceFinderWithStackWithOneSentence := SentenceFinderByPrefix withPrefix: prefixToSearch AndStack: stackWithOneSentence.
	
	sentenceFinderWithStackWithManySentencesWithPrefixInOnlyOneSentence := SentenceFinderByPrefix withPrefix: prefixToSearch AndStack: stackWithManySentencesWithPrefixInOnlyOneSentence.
	
	sentenceFinderWithStackWithManySentencesWithPrefixInManySentences := SentenceFinderByPrefix withPrefix: prefixToSearch AndStack: stackWithManySentencesWithPrefixInManySentences.
	
	sentenceFinderWithCaseSensitiveStack := SentenceFinderByPrefix withPrefix: prefixToSearch AndStack: caseSensitiveStack.
	
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topNode'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'MF 9/18/2021 20:09:30'!
pop

	| element |
	
	element := self top.
	topNode := topNode next.
	^element.! !

!OOStack methodsFor: 'operations' stamp: 'MF 9/18/2021 17:47:12'!
push: anObject

	| newElement |
	
	newElement := OOStackObjectNode with: anObject pointingTo: topNode.
	topNode := newElement.! !

!OOStack methodsFor: 'operations' stamp: 'MF 9/18/2021 17:49:24'!
size

	^topNode depth.! !

!OOStack methodsFor: 'operations' stamp: 'MF 9/18/2021 17:44:27'!
top

	^topNode content.! !


!OOStack methodsFor: 'testing' stamp: 'MF 9/18/2021 17:23:54'!
isEmpty

	^self size = 0.! !


!OOStack methodsFor: 'initialization' stamp: 'MF 9/18/2021 17:40:37'!
initialize

	topNode := OOStackBase new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackComponent category: 'Stack-Exercise'!
Object subclass: #OOStackComponent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackComponent methodsFor: 'accessing' stamp: 'MF 9/18/2021 18:03:08'!
content

	self subclassResponsibility.! !

!OOStackComponent methodsFor: 'accessing' stamp: 'MF 9/18/2021 18:03:26'!
depth

	self subclassResponsibility.! !


!classDefinition: #OOStackBase category: 'Stack-Exercise'!
OOStackComponent subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'accessing' stamp: 'MF 9/18/2021 17:57:32'!
content
	self error: OOStack stackEmptyErrorDescription.! !

!OOStackBase methodsFor: 'accessing' stamp: 'MF 9/18/2021 17:51:52'!
depth
	^0.! !


!classDefinition: #OOStackObjectNode category: 'Stack-Exercise'!
OOStackComponent subclass: #OOStackObjectNode
	instanceVariableNames: 'content nextComponent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackObjectNode methodsFor: 'initialization' stamp: 'MF 9/18/2021 17:55:10'!
initializeWith: anObject pointingTo: anOOStackComponent 

	content := anObject.
	nextComponent := anOOStackComponent.! !


!OOStackObjectNode methodsFor: 'accessing' stamp: 'MF 9/18/2021 17:56:17'!
content

	^content! !

!OOStackObjectNode methodsFor: 'accessing' stamp: 'MF 9/18/2021 17:55:33'!
depth

	^1 + nextComponent depth.! !

!OOStackObjectNode methodsFor: 'accessing' stamp: 'MF 9/18/2021 17:56:42'!
next
	
	^nextComponent.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackObjectNode class' category: 'Stack-Exercise'!
OOStackObjectNode class
	instanceVariableNames: ''!

!OOStackObjectNode class methodsFor: 'instance creation' stamp: 'MF 9/18/2021 17:53:42'!
with: anObject pointingTo: anOOStackComponent 

	^self new initializeWith: anObject pointingTo: anOOStackComponent! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'prefix sentenceStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'dd 9/20/2021 15:47:28'!
initializeWithPrefix: aPrefix AndStack: aSentenceStack 
	
	prefix := aPrefix.
	sentenceStack := aSentenceStack.! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'LNB 9/20/2021 14:34:01'!
find
	
	| foundSentencesWithPrefix sentence |
	
	sentenceStack isEmpty ifTrue: [ ^OrderedCollection new ].
	
	sentence := sentenceStack pop.
	foundSentencesWithPrefix := self find.
	
	(sentence beginsWith: prefix) ifTrue: [ foundSentencesWithPrefix add: sentence ].
	
	sentenceStack push: sentence.
	^foundSentencesWithPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'dd 9/20/2021 15:48:06'!
withPrefix: aPrefix AndStack: aSentenceStack 

	(aPrefix isEmpty or: [ aPrefix includes: $  ]) ifTrue: 
		[ self error: SentenceFinderByPrefix invalidPrefixErrorDescription ].

	^self new initializeWithPrefix: aPrefix AndStack: aSentenceStack.! !


!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'MF 9/18/2021 19:41:20'!
invalidPrefixErrorDescription
	^'prefix should not be empty nor have spaces!!!!!!!!'! !
