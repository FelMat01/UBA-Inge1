!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'factory'
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

!CartTest methodsFor: 'tests' stamp: 'MF 11/2/2021 22:34:55'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSoldByTheStore withOccurrences: 0 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'MF 11/2/2021 22:35:25'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemNotSoldByTheStore withOccurrences: 2  ]
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

!CartTest methodsFor: 'tests' stamp: 'MF 11/2/2021 22:35:34'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore withOccurrences: 2.
	self assert: (cart occurrencesOf: self itemSoldByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'MF 11/2/2021 22:12:44'!
createCart
	
	^ factory createCart.! !

!CartTest methodsFor: 'support' stamp: 'MF 11/2/2021 22:12:52'!
defaultCatalog
	
	^ factory defaultCatalog ! !

!CartTest methodsFor: 'support' stamp: 'MF 11/2/2021 22:13:03'!
itemNotSoldByTheStore
	
	^ factory itemNotSoldByTheStore! !

!CartTest methodsFor: 'support' stamp: 'MF 11/2/2021 22:13:14'!
itemSoldByTheStore
	
	^ factory itemSoldByTheStore! !

!CartTest methodsFor: 'support' stamp: 'MF 11/2/2021 22:12:20'!
setUp

	factory _ StoreTestObjectFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:02:49'!
test01CantCheckoutEmptyCart
	
	| cart salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cart _ factory createCart.
	
	self 
		should: [Cashier 
				toCheckout: cart
				charging: factory notExpiredCreditCard
				on: factory today
				registeringOn: salesBook 
				withMerchantProcessor: simulatedMerchantProcessor] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier cantCheckoutEmptyCartErrorDescription.
			self assert: salesBook isEmpty.
			]! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:02:58'!
test02CartsCheckoutTotalEqualsItsItemPrice
	
	| cashier cart salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	
	cashier _ Cashier 
				toCheckout: cart
				charging: factory notExpiredCreditCard
				on: factory today
				registeringOn: salesBook withMerchantProcessor: simulatedMerchantProcessor.
	
	self assert: cashier checkout equals: 10.! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:03:26'!
test03CartsCheckoutTotalEqualsAllOfItsItemPrice
	
	| cashier cart salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore withOccurrences: 2.
	
	cashier _ Cashier 
				toCheckout: cart
				charging: factory notExpiredCreditCard
				on: factory today 
				registeringOn: salesBook withMerchantProcessor: simulatedMerchantProcessor.
				
	self assert: cashier checkout equals: 20.! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:03:43'!
test04CantCheckoutWithAnExpiredCreditCard
	
	| cart salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	
	self 
		should: [Cashier 
				toCheckout: cart
				charging: factory expiredCreditCard
				on: factory today 
				registeringOn: salesBook withMerchantProcessor: simulatedMerchantProcessor] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier canNotChargeAnExpiredCreditCardErrorDescription.
			self assert: salesBook isEmpty.
			].! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:03:55'!
test05CantCheckoutCardWithEmptyName
	
	| cart salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	
	self 
		should: [Cashier 
				toCheckout: cart
				charging: factory creditCardWithInvalidName
				on: factory today 
				registeringOn: salesBook withMerchantProcessor: simulatedMerchantProcessor] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier canNotChargeACardWithInvalidNameErrorDescription.
			self assert: salesBook isEmpty.
			].! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:04:01'!
test06CantCheckoutCardThatOnlyContainsSpaces
	
	| cart salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	
	self 
		should: [Cashier 
				toCheckout: cart
				charging: factory creditCardWithSpacesName
				on: factory today 
				registeringOn: salesBook withMerchantProcessor: simulatedMerchantProcessor] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier canNotChargeACardWithInvalidNameErrorDescription.
			self assert: salesBook isEmpty.
			].! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:04:08'!
test07AddsSaleToSalebookAtCheckout
	
	| cashier cart salesBook total simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	
	cashier _ Cashier 
				toCheckout: cart
				charging: factory notExpiredCreditCard
				on: factory today
				registeringOn: salesBook withMerchantProcessor: simulatedMerchantProcessor.
	
	total _ cashier checkout.
	
	self assert: salesBook includes: total.! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:04:14'!
test08CheckoutFailsWhenMerchantProcessorReportsStolenCard
	
	| cart cashier salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.

	simulatedMerchantProcessor denyStolenCard.
	
	cashier _ Cashier 
				toCheckout: cart
				charging: factory notExpiredCreditCard 
				on: factory today 
				registeringOn: salesBook
				withMerchantProcessor: simulatedMerchantProcessor.
	
	self 
		should: [ cashier checkout ] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier canNotDebitAStolenCardErrorDescription.
			self assert: salesBook isEmpty.
			].! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:04:20'!
test09MerchantProcessorRecievesCreditCardAndSalesTotalAtCheckout
	
	| cart cashier salesBook simulatedMerchantProcessor card total |
	
	salesBook _ OrderedCollection new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	card _ factory notExpiredCreditCard.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.
	
	cashier _ Cashier 
				toCheckout: cart
				charging: card
				on: factory today 
				registeringOn: salesBook
				withMerchantProcessor: simulatedMerchantProcessor.
	
	total _ cashier checkout.
	
	self assert: total equals: simulatedMerchantProcessor totalDebited.
	self assert: card equals: simulatedMerchantProcessor debitedCard.! !

!CashierTest methodsFor: 'tests' stamp: 'MF 11/3/2021 22:04:28'!
test10CheckoutFailsWhenMerchantProcessorReportsCardWithNoCredit
	
	| cart cashier salesBook simulatedMerchantProcessor |
	
	salesBook _ OrderedCollection new.
	
	cart _ factory createCart.
	cart add: factory itemSoldByTheStore.
	simulatedMerchantProcessor _ MerchantProcessorSimulator new.

	simulatedMerchantProcessor denyCardWithoutCredit.
	
	cashier _ Cashier 
				toCheckout: cart
				charging: factory notExpiredCreditCard 
				on: factory today 
				registeringOn: salesBook
				withMerchantProcessor: simulatedMerchantProcessor.
	
	self 
		should: [ cashier checkout ] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier canNotDebitACardWithoutCreditErrorDescription.
			self assert: salesBook isEmpty.
			].! !


!CashierTest methodsFor: 'setup' stamp: 'MF 11/2/2021 22:14:27'!
setUp

	factory _ StoreTestObjectFactory new.! !


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

!Cart methodsFor: 'queries' stamp: 'MF 11/2/2021 22:27:17'!
total
	
	| totalPrice |
	
	totalPrice _ 0.
	self do: [:aProduct | totalPrice _ totalPrice + (	catalog at: aProduct) ].
	
	^totalPrice.! !


!Cart methodsFor: 'testing' stamp: 'LNB 11/1/2021 19:25:49'!
includes: anItem

	^contents includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'LNB 11/1/2021 19:25:49'!
isEmpty
	
	^contents isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'MF 11/2/2021 22:35:09'!
add: anItem

	^ self add: anItem withOccurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'MF 11/2/2021 22:34:04'!
add: anItem withOccurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	contents add: anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'signaling' stamp: 'LNB 11/1/2021 19:27:51'!
signalInvalidItemError

	^ self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'signaling' stamp: 'LNB 11/1/2021 19:28:08'!
signalInvalidQuantityError

	^ self error: self invalidQuantityErrorMessage! !


!Cart methodsFor: 'enumerating' stamp: 'MF 11/2/2021 22:27:30'!
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
	instanceVariableNames: 'catalogue cartToCheckout creditCard date salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'MF 11/2/2021 23:47:18'!
initializeToCheckout: aCartToCheckout charging: aCreditCard on: aDate registeringOn: aSalesBook withMerchantProcessor: aMerchantProcessor   
	
	cartToCheckout := aCartToCheckout.
	creditCard := aCreditCard.
	date := aDate.

	salesBook _ aSalesBook.
	merchantProcessor _ aMerchantProcessor.! !


!Cashier methodsFor: 'checkout' stamp: 'MF 11/3/2021 00:00:16'!
checkout
	
	| total |
	
	total _ cartToCheckout total.
	
	merchantProcessor debit: total on: creditCard.
		
	salesBook add: total.
	
	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error description' stamp: 'MF 11/2/2021 22:56:57'!
canNotChargeACardWithInvalidNameErrorDescription
	
	^'can not charge a card with invalid name'! !

!Cashier class methodsFor: 'error description' stamp: 'MF 11/2/2021 22:41:13'!
canNotChargeAnExpiredCreditCardErrorDescription

	^'can not charge expired credit card'! !

!Cashier class methodsFor: 'error description' stamp: 'MF 11/3/2021 00:11:44'!
canNotDebitACardWithoutCreditErrorDescription
	
	^'can not debit a card without credit'! !

!Cashier class methodsFor: 'error description' stamp: 'MF 11/2/2021 23:49:28'!
canNotDebitAStolenCardErrorDescription
	
	^'can not debit a stolen credit card'! !

!Cashier class methodsFor: 'error description' stamp: 'LNB 11/1/2021 19:43:29'!
cantCheckoutEmptyCartErrorDescription
	^'Cant checkout an empty cart.'.! !


!Cashier class methodsFor: 'instance creation' stamp: 'MF 11/2/2021 23:46:56'!
toCheckout: aCartToCheckout charging: aCreditCard on: aDate registeringOn: aSalesBook withMerchantProcessor: aMerchantProcessor   
	
	(aCartToCheckout isEmpty) ifTrue: [self error: self cantCheckoutEmptyCartErrorDescription.].
	(aCreditCard isExpiredOn: aDate) ifTrue: [self error: self canNotChargeAnExpiredCreditCardErrorDescription].
	(aCreditCard hasValidName) ifFalse: [self error: self canNotChargeACardWithInvalidNameErrorDescription].
	
	^self new initializeToCheckout: aCartToCheckout charging: aCreditCard on: aDate registeringOn: aSalesBook withMerchantProcessor: aMerchantProcessor ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'ownerName expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'MF 11/2/2021 22:50:52'!
initializeOf: aName expiresOn: anExpirationDate 
	
	ownerName := aName.
	expirationDate := anExpirationDate.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'MF 11/2/2021 22:54:50'!
isExpiredOn: aDate

	^expirationDate < aDate.! !


!CreditCard methodsFor: 'testing' stamp: 'MF 11/2/2021 23:00:38'!
hasValidName
	
	^ownerName withoutTrailingBlanks isEmpty not! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'MF 11/2/2021 22:50:26'!
of: aName expiresOn: anExpirationDate 
	
	^self new initializeOf: aName expiresOn: anExpirationDate.! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'simulatedAction totalDebited debitedCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'changing behaviour' stamp: 'MF 11/3/2021 00:11:31'!
denyCardWithoutCredit

	simulatedAction _ [ :anAmount :aCreditCard | self error: Cashier canNotDebitACardWithoutCreditErrorDescription ].! !

!MerchantProcessorSimulator methodsFor: 'changing behaviour' stamp: 'MF 11/3/2021 00:06:51'!
denyStolenCard
	
	simulatedAction _ [ :anAmount :aCreditCard | self error: Cashier canNotDebitAStolenCardErrorDescription ].! !


!MerchantProcessorSimulator methodsFor: 'accessing' stamp: 'MF 11/3/2021 00:08:37'!
debitedCard

	^debitedCard! !

!MerchantProcessorSimulator methodsFor: 'accessing' stamp: 'MF 11/3/2021 00:08:31'!
totalDebited

	^totalDebited ! !


!MerchantProcessorSimulator methodsFor: 'debiting' stamp: 'MF 11/3/2021 00:06:41'!
debit: anAmount on: aCreditCard.

	^simulatedAction value: anAmount value: aCreditCard.! !


!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'MF 11/3/2021 00:06:25'!
initialize

	simulatedAction _ [ :anAmount :aCreditCard | 
		totalDebited _ anAmount.
		debitedCard _ aCreditCard.]! !


!classDefinition: #StoreTestObjectFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectFactory methodsFor: 'initialization' stamp: 'MF 11/2/2021 22:10:48'!
initialize

	today _ FixedGregorianDate today.! !


!StoreTestObjectFactory methodsFor: 'cart creation' stamp: 'MF 11/2/2021 22:10:57'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog.! !


!StoreTestObjectFactory methodsFor: 'card creation' stamp: 'MF 11/2/2021 22:52:24'!
creditCardWithInvalidName

	^ CreditCard of: '' expiresOn: self notExpiredMonthOfYear.! !

!StoreTestObjectFactory methodsFor: 'card creation' stamp: 'MF 11/2/2021 22:59:07'!
creditCardWithSpacesName

	^ CreditCard of: '  ' expiresOn: self notExpiredMonthOfYear.! !

!StoreTestObjectFactory methodsFor: 'card creation' stamp: 'MF 11/2/2021 22:52:34'!
expiredCreditCard

	^ CreditCard of: 'Lean' expiresOn: self expiredMonthOfYear.! !

!StoreTestObjectFactory methodsFor: 'card creation' stamp: 'MF 11/2/2021 22:52:24'!
notExpiredCreditCard
	
	^ CreditCard of: 'Lean' expiresOn: self notExpiredMonthOfYear.! !


!StoreTestObjectFactory methodsFor: 'catalog creation' stamp: 'MF 11/2/2021 22:13:56'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSoldByTheStore put: self itemSoldByTheStorePrice;
		yourself.! !


!StoreTestObjectFactory methodsFor: 'expiration dates creation' stamp: 'MF 11/2/2021 22:52:34'!
expiredMonthOfYear.

	^(today previous: 1*month) monthOfYear.! !

!StoreTestObjectFactory methodsFor: 'expiration dates creation' stamp: 'MF 11/2/2021 22:52:24'!
notExpiredMonthOfYear

	^(today next: 1*month) monthOfYear.! !


!StoreTestObjectFactory methodsFor: 'accessing' stamp: 'MF 11/2/2021 22:18:10'!
today

	^today.! !


!StoreTestObjectFactory methodsFor: 'item creation' stamp: 'MF 11/2/2021 22:11:39'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!StoreTestObjectFactory methodsFor: 'item creation' stamp: 'MF 11/2/2021 22:11:33'!
itemSoldByTheStore
	
	^ 'validBook'! !

!StoreTestObjectFactory methodsFor: 'item creation' stamp: 'MF 11/2/2021 22:15:07'!
itemSoldByTheStorePrice

	^ 10.! !
