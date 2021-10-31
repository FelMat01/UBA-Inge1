!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'LNB 10/31/2021 16:05:57'!
catalogue
	
	^OrderedCollection new.! !

!CartTest methodsFor: 'tests' stamp: 'LNB 10/31/2021 16:06:12'!
catalogueWith: aBook

    ^OrderedCollection with: aBook! !

!CartTest methodsFor: 'tests' stamp: 'LNB 10/31/2021 16:06:25'!
catalogueWith: aBook with: anotherBook

    ^OrderedCollection with: aBook with: anotherBook! !

!CartTest methodsFor: 'tests' stamp: 'LNB 10/31/2021 17:52:12'!
test01NewCartIsEmpty

	| cart |
	
	cart _ Cart withCatalogue: self catalogue.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LNB 10/31/2021 17:39:17'!
test02CartWithOneItemIsNotEmpty

	| cart book |
	
	book _ 'bookISBN'.
	cart _ Cart withCatalogue: (self catalogueWith: book).
	
	cart add: book times: 1.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LNB 10/31/2021 17:39:39'!
test03CartWithTwoDifferentItemsIncludesBoth

	| cart book anotherBook |
	
	book _ 'book ISBN'.
	anotherBook _ 'another book ISBN'.
	
	cart _ Cart withCatalogue: (self catalogueWith: book with: anotherBook).
	
	cart add: book times: 1.
	cart add: anotherBook times: 1.
	
	self assert: cart includes: book.
	self assert: cart includes: anotherBook.! !

!CartTest methodsFor: 'tests' stamp: 'LNB 10/31/2021 17:41:44'!
test04CannotAddItemNotIncludedInCatalogue

	| cart book |
	
	book _ 'book ISBN'.
	
	cart _ Cart withCatalogue: self catalogue.
	
	
	
	self 
		should: [cart add: book times: 1.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart cannotAddItemNotIncludedInCatalogueErrorDescription.
			self assert: (cart isEmpty).
			].! !

!CartTest methodsFor: 'tests' stamp: 'LNB 10/31/2021 17:44:28'!
test05CanAddMoreThanOneCopyOfTheSameBook

	| cart book |
	
	book _ 'bookISBN'.
	cart _ Cart withCatalogue: (self catalogueWith: book).
	
	cart add: book times: 2.
	
	self assert: (cart occurrencesOf: book) equals: 2.
	self assert: cart size equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'LNB 10/31/2021 17:44:45'!
test06CannotAddLessThanOneCopyOfABook

	| cart book |
	
	book _ 'book ISBN'.
	
	cart _ Cart withCatalogue: (self catalogueWith: book).
	
	
	
	self 
		should: [cart add: book times: 0.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cart cannotAddLessThanOneItemErrorDescription.
			self assert: (cart isEmpty).
			].! !

!CartTest methodsFor: 'tests' stamp: 'LNB 10/31/2021 17:45:03'!
test07BookNotAddedIsNotIncluded

	| cart book |
	
	book _ 'book ISBN'.
	
	cart _ Cart withCatalogue: (self catalogueWith: book).
	
	self deny: (cart includes: book).! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'contents catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'LNB 10/31/2021 17:50:50'!
initializeWith: aCatalogue 

	contents _ Bag new.
	catalogue := aCatalogue.! !


!Cart methodsFor: 'adding' stamp: 'LNB 10/31/2021 17:47:55'!
add: aBook times: anAmount  

	self assertIsInCatalogue: aBook.
	self assertIsPositive: anAmount.
	
	contents add: aBook withOccurrences: anAmount.! !


!Cart methodsFor: 'testing' stamp: 'LNB 10/31/2021 17:46:05'!
includes: aBookISBN 

	^contents includes: aBookISBN.! !

!Cart methodsFor: 'testing' stamp: 'LNB 10/31/2021 17:46:10'!
isEmpty

	^contents isEmpty.! !

!Cart methodsFor: 'testing' stamp: 'LNB 10/31/2021 17:46:14'!
occurrencesOf: aBook

	^contents occurrencesOf: aBook.! !

!Cart methodsFor: 'testing' stamp: 'LNB 10/31/2021 17:46:18'!
size

	^contents size.! !


!Cart methodsFor: 'asserting' stamp: 'LNB 10/31/2021 17:48:20'!
assertIsInCatalogue: aBook

	^ (catalogue includes: aBook) ifFalse: [ self signalCannotAddItemNotIncludedInCatalogue]! !

!Cart methodsFor: 'asserting' stamp: 'LNB 10/31/2021 17:48:37'!
assertIsPositive: anAmount

	^ (anAmount > 0) ifFalse: [self signalCannotAddLessThanOneItem]! !


!Cart methodsFor: 'signaling' stamp: 'LNB 10/31/2021 17:48:20'!
signalCannotAddItemNotIncludedInCatalogue

	^ self error: self class cannotAddItemNotIncludedInCatalogueErrorDescription! !

!Cart methodsFor: 'signaling' stamp: 'LNB 10/31/2021 17:48:36'!
signalCannotAddLessThanOneItem

	^ self error: self class cannotAddLessThanOneItemErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'LNB 10/31/2021 16:08:19'!
withCatalogue: aCatalogue 
	^self new initializeWith: aCatalogue ! !


!Cart class methodsFor: 'error description' stamp: 'LNB 10/31/2021 16:16:41'!
cannotAddItemNotIncludedInCatalogueErrorDescription
	^'Cannot add a Book not included in catalogue.'! !

!Cart class methodsFor: 'error description' stamp: 'LNB 10/31/2021 16:55:27'!
cannotAddLessThanOneItemErrorDescription
	^'Cannot add less than one item.'! !
