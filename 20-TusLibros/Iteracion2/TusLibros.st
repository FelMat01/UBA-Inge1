!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'LNB 11/1/2021 19:56:11'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LNB 11/1/2021 19:56:19'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'LNB 11/1/2021 19:56:18'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 withOccurrences: self itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LNB 11/1/2021 19:56:11'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 withOccurrences: self itemNotSoldByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LNB 11/1/2021 19:56:19'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore.
	self assert: (cart includes: self itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'LNB 11/1/2021 19:56:19'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'LNB 11/1/2021 19:56:19'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 withOccurrences: self itemSoldByTheStore.
	self assert: (cart occurrencesOf: self itemSoldByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'LNB 11/1/2021 20:03:51'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'LNB 11/1/2021 20:11:13'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSoldByTheStore put: 10;
		yourself.! !

!CartTest methodsFor: 'support' stamp: 'LNB 11/1/2021 20:04:01'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'LNB 11/1/2021 20:04:09'!
itemSoldByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'LNB 11/1/2021 20:26:19'!
test01
	| cashier cart |
	
	cashier _ self createCashier.
	cart _ self createCart.
	
	
	self 
		should: [cashier checkout: cart.] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier cantCheckoutEmptyCartErrorDescription.
			]! !

!CashierTest methodsFor: 'tests' stamp: 'LNB 11/1/2021 20:28:08'!
test02
	| cashier cart |
	
	cashier _ self createCashier.
	cart _ self createCart.
	cart add: self itemThatCosts10.
	
	
	self assert: (cashier checkout: cart) equals: 10.! !

!CashierTest methodsFor: 'tests' stamp: 'LNB 11/1/2021 20:28:10'!
test03
	| cashier cart |
	
	cashier _ self createCashier.
	cart _ self createCart.
	cart add: self itemThatCosts20.
	
	
	self assert: (cashier checkout: cart) equals: 20.! !

!CashierTest methodsFor: 'tests' stamp: 'LNB 11/1/2021 20:29:21'!
test04
	| cashier cart |
	
	cashier _ self createCashier.
	cart _ self createCart.
	cart add: self itemThatCosts20.
	cart add: self itemThatCosts10.
	
	self assert: (cashier checkout: cart) equals: 30.! !


!CashierTest methodsFor: 'support' stamp: 'LNB 11/1/2021 20:03:51'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'support' stamp: 'LNB 11/1/2021 20:12:54'!
defaultCatalog
	
	^ Dictionary new
		at: self itemThatCosts10 put: 10;
		at: self itemThatCosts20 put: 20;
		yourself.! !

!CashierTest methodsFor: 'support' stamp: 'LNB 11/1/2021 21:04:55'!
expiredExpirationDate
	
	^GregorianMonthOfYear current previous: 1*month.! !

!CashierTest methodsFor: 'support' stamp: 'LNB 11/1/2021 20:04:02'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!CashierTest methodsFor: 'support' stamp: 'LNB 11/1/2021 20:02:19'!
itemThatCosts10
	^'item that costs 10'.! !

!CashierTest methodsFor: 'support' stamp: 'LNB 11/1/2021 21:05:16'!
validExpirationDate
	
	^GregorianMonthOfYear current .! !


!CashierTest methodsFor: 'as yet unclassified' stamp: 'LNB 11/1/2021 20:27:19'!
createCashier
	^Cashier acceptingItemsOf: self defaultCatalog.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'LNB 11/1/2021 20:06:23'!
itemThatCosts20
	'item that costs 20'! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'LNB 11/1/2021 20:11:40'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self signalInvalidItemError ]! !

!Cart methodsFor: 'assertions' stamp: 'LNB 11/1/2021 19:28:08'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self signalInvalidQuantityError ]! !


!Cart methodsFor: 'initialization' stamp: 'LNB 11/1/2021 19:25:49'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	contents := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'LNB 11/1/2021 19:25:49'!
occurrencesOf: anItem

	^contents occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'LNB 11/1/2021 19:25:49'!
includes: anItem

	^contents includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'LNB 11/1/2021 19:25:49'!
isEmpty
	
	^contents isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'LNB 11/1/2021 19:26:01'!
add: anItem

	^ self add: 1 withOccurrences: anItem ! !

!Cart methodsFor: 'adding' stamp: 'LNB 11/1/2021 19:26:01'!
add: aQuantity withOccurrences: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	contents add: anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'signaling' stamp: 'LNB 11/1/2021 19:27:51'!
signalInvalidItemError

	^ self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'signaling' stamp: 'LNB 11/1/2021 19:28:08'!
signalInvalidQuantityError

	^ self error: self invalidQuantityErrorMessage! !


!Cart methodsFor: 'as yet unclassified' stamp: 'LNB 11/1/2021 20:23:23'!
do: aBlockClosure 
	contents do: aBlockClosure.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'LNB 11/1/2021 20:24:02'!
checkout: aCart 
	
	
	| totalPrice |
	
	
	(aCart isEmpty) ifTrue: [self error: self class cantCheckoutEmptyCartErrorDescription.].
	
	
	totalPrice _ 0.
	aCart do: [:aProduct | totalPrice _ totalPrice + (catalogue at: aProduct) ].
	
	^totalPrice.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'LNB 11/1/2021 20:21:23'!
initializeWith: aCatalogue

	catalogue _ aCatalogue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error description' stamp: 'LNB 11/1/2021 20:22:17'!
acceptingItemsOf: aCatalog

	^self new initializeWith: aCatalog.! !

!Cashier class methodsFor: 'error description' stamp: 'LNB 11/1/2021 19:43:29'!
cantCheckoutEmptyCartErrorDescription
	^'Cant checkout an empty cart.'.! !
