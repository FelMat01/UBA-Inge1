!classDefinition: #Cart category: #'TusLibros-Model'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^self class invalidQuantityErrorMessage ! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:17'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self signalInvalidItem ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:18'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [self signalInvalidQuantity ]! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:17'!
catalog

	^ catalog! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:30'!
content

	^items copy! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/23/2013 12:10'!
itemsAndQuantitiesDo: aBlock

	^ items contents keysAndValuesDo: [ :anItem :aQuantity | aBlock value: anItem value: aQuantity ]! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:29'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:18'!
signalInvalidItem

	self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:19'!
signalInvalidQuantity

	self error: self invalidQuantityErrorMessage ! !

!Cart methodsFor: 'error signal' stamp: 'LNB 11/27/2021 18:46:46'!
signalNotEnoughItemsToRemoveError

	self error: self class invalidQuantityErrorMessage.! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty

	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/22/2013 12:31'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !


!Cart methodsFor: 'removing' stamp: 'LNB 11/27/2021 18:46:46'!
remove: aQuantity of: anItem 
	
	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	
	(aQuantity > (self occurrencesOf: anItem)) ifTrue: [ self signalNotEnoughItemsToRemoveError ].

	aQuantity timesRepeat: [ items remove: anItem ifAbsent: [ self shouldNotHappen ] ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Model'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'MF 11/15/2021 20:59:22'!
cannotRemoveFromEmptyCartErrorMessage
	
	^'Cart is empty!!'.! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^'Invalid number of items'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: #'TusLibros-Model'!
Object subclass: #CartSession
	instanceVariableNames: 'owner cart lastUsedTime systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:34'!
assertIsNotExpirtedAt: aTime

	(self isExpiredAt: aTime) ifTrue: [ self signalCartSessionExpired ]! !

!CartSession methodsFor: 'time/expiration' stamp: 'LNB 11/14/2021 20:27:02'!
isExpiredAt: aGregorianDateTime

	^ (lastUsedTime next: systemFacade sessionDuration) < aGregorianDateTime! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
now

	^systemFacade now! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:37'!
today

	^systemFacade today! !


!CartSession methodsFor: 'session management' stamp: 'HernanWilkinson 6/17/2015 20:35'!
do: aBlock

	| now |

	now := self now.
	self assertIsNotExpirtedAt: now.

	^ [ aBlock value: self ] ensure: [ lastUsedTime := now  ]! !


!CartSession methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2015 20:36'!
initializeOwnedBy: aCustomer with: aCart on: aSystemFacade

	owner := aCustomer.
	cart := aCart.
	systemFacade := aSystemFacade.
	lastUsedTime := self now.! !


!CartSession methodsFor: 'error signal' stamp: 'HernanWilkinson 6/17/2015 20:37'!
signalCartSessionExpired

	self error: systemFacade sessionHasExpiredErrorDescription ! !


!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:34'!
addToCart: anAmount of: aBook

	^cart add: anAmount of: aBook! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
cartContent

	^cart content! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
checkOutCartWithCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	^(Cashier
		toCheckout: cart
		ownedBy: owner
		charging: (CreditCard expiringOn: anExpirationMonthOfYear)
		throught: systemFacade merchantProcessor
		on: self today
		registeringOn: systemFacade salesBook) checkOut ! !


!CartSession methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 20:52:43'!
removeFromCart: anAmount of: aBook 
	
	^cart remove: anAmount of: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #'TusLibros-Model'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2015 20:37'!
ownedBy: aCustomer with: aCart on: aSystemFacade

	^self new initializeOwnedBy: aCustomer with: aCart on: aSystemFacade! !


!classDefinition: #Cashier category: #'TusLibros-Model'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard owner ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
createLineItemOf: anItem quantity: aQuantity

	^LineItem of: anItem quantity: aQuantity total: (self totalOf: anItem quantity: aQuantity) ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:25'!
createSale

	^ Sale doneBy: owner certifiedWith: ticket
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:28'!
createTicket

	| lineItems |

	lineItems := OrderedCollection new.
	cart itemsAndQuantitiesDo: [ :anItem :aQuantity |
		lineItems add: (self createLineItemOf: anItem quantity: aQuantity)].

	ticket := Ticket of: lineItems
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:20'!
debitTotal

	merchantProcessor debit: ticket total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
totalOf: anItem quantity: aQuantity

	^(cart catalog at: anItem) * aQuantity  ! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/22/2013 12:28'!
checkOut

	self createTicket.
	self debitTotal.
	self registerSale.

	^ ticket ! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:02'!
initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook

	cart := aCart.
	owner := anOwner.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Model'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotEmpty: aCart

	aCart isEmpty ifTrue: [self signalCartCanNotBeEmpty ]! !

!Cashier class methodsFor: 'assertions' stamp: 'LNB 11/14/2021 19:51:58'!
assertIsNotExpired: aCreditCard on: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [self signalCanNotChargeAnExpiredCreditCard]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:00'!
toCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook

	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.

	^self new initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage

	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage

	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage

	^'Credit card has no credit'! !


!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCanNotChargeAnExpiredCreditCard

	 self error: self canNotChargeAnExpiredCreditCardErrorMessage ! !

!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCartCanNotBeEmpty

	self error: self cartCanNotBeEmptyErrorMessage! !


!classDefinition: #Clock category: #'TusLibros-Model'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
now

	self subclassResponsibility ! !

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
today

	self subclassResponsibility ! !


!classDefinition: #RealClock category: #'TusLibros-Model'!
Clock subclass: #RealClock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!



!RealClock methodsFor: 'time' stamp: 'LNB 11/14/2021 20:47:30'!
now

	^ GregorianDateTime now! !

!RealClock methodsFor: 'time' stamp: 'LNB 11/14/2021 20:52:41'!
today

	^FixedGregorianDate today! !


!classDefinition: #CreditCard category: #'TusLibros-Model'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CreditCard methodsFor: 'testing' stamp: 'LNB 11/14/2021 19:53:01'!
isExpiredOn: aGregorianDateTime

	^expiration < aGregorianDateTime monthOfYear! !


!CreditCard methodsFor: 'initialization' stamp: 'LNB 11/14/2021 19:09:42'!
initializeExpiringOn: aMonthOfYear

	expiration := aMonthOfYear ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Model'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'LNB 11/14/2021 19:09:33'!
expiringOn: aMonthOfYear

	^self new initializeExpiringOn: aMonthOfYear! !


!classDefinition: #CustomerPurchaseHistory category: #'TusLibros-Model'!
Object subclass: #CustomerPurchaseHistory
	instanceVariableNames: 'purchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CustomerPurchaseHistory methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 20:10:03'!
at: anItem

	^purchases at: anItem.! !

!CustomerPurchaseHistory methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 19:57:54'!
initialize

	purchases _ Dictionary new.! !

!CustomerPurchaseHistory methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 20:11:52'!
isEmpty

	^purchases isEmpty.! !

!CustomerPurchaseHistory methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 20:26:16'!
itemsDo: aBlock

	purchases keysDo: aBlock.! !

!CustomerPurchaseHistory methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 20:08:58'!
registerSale: aSale

	aSale lineItemsDo: [ :newLineItem | | item |
		item _ newLineItem item.
		purchases at: item 
			ifPresent: [ :oldLineItem | 
				purchases at: item put: (LineItem of: item 
										quantity: (oldLineItem quantity + newLineItem quantity) 
										total: (oldLineItem total + newLineItem total))]
			ifAbsent: [ purchases at: item put: newLineItem ] ].! !

!CustomerPurchaseHistory methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 20:35:52'!
total

	^purchases sum: [ :aLineItem | aLineItem total ] ifEmpty: [ 0 ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerPurchaseHistory class' category: #'TusLibros-Model'!
CustomerPurchaseHistory class
	instanceVariableNames: ''!

!CustomerPurchaseHistory class methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 20:16:35'!
forSales: salesOfUser

	| customerPurchaseHistory |
	customerPurchaseHistory _ self new.
	salesOfUser do: [ :aSale | customerPurchaseHistory registerSale: aSale ].
	^customerPurchaseHistory! !


!classDefinition: #LineItem category: #'TusLibros-Model'!
Object subclass: #LineItem
	instanceVariableNames: 'item quantity total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:33'!
item

	^ item! !

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:21'!
total

	^ total! !


!LineItem methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:18'!
initializeOf: anItem quantity: aQuantity total: aTotal

	item := anItem.
	quantity := aQuantity.
	total := aTotal

! !

!LineItem methodsFor: 'initialization' stamp: 'MF 11/15/2021 20:07:42'!
quantity

	^quantity.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LineItem class' category: #'TusLibros-Model'!
LineItem class
	instanceVariableNames: ''!

!LineItem class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:18'!
of: anItem quantity: aQuantity total: aTotal

	^self new initializeOf: anItem quantity: aQuantity total: aTotal

! !


!classDefinition: #MerchantProcessor category: #'TusLibros-Model'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:31'!
README

	"Aunque nadie subclasifica esta clase, esta para definir el protocolo que se espera que todo MerchantProcessor sepa responder - Hernan"! !

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:30'!
debit: anAmount from: aCreditCard

	self subclassResponsibility ! !


!classDefinition: #Sale category: #'TusLibros-Model'!
Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Sale methodsFor: 'testing' stamp: 'HernanWilkinson 6/22/2013 12:06'!
wasDoneBy: aCustomer

	^customer = aCustomer ! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:26'!
initializeDoneBy: aCustomer certifiedWith: aTicket

	customer := aCustomer.
	ticket := aTicket ! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/22/2013 12:26'!
total

	^ ticket total! !


!Sale methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^ticket lineItemsDo: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'TusLibros-Model'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:25'!
doneBy: aCustomer certifiedWith: aTicket

	^self new initializeDoneBy: aCustomer certifiedWith: aTicket ! !


!classDefinition: #SalesBook category: #'TusLibros-Model'!
Object subclass: #SalesBook
	instanceVariableNames: 'sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!SalesBook methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 19:50:37'!
add: aSale

	sales add: aSale.! !

!SalesBook methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 19:54:55'!
first

	^sales first.! !

!SalesBook methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 19:50:52'!
initialize

	sales _ OrderedCollection new.! !

!SalesBook methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 19:54:05'!
isEmpty

	^sales isEmpty.! !

!SalesBook methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 20:15:24'!
purchaseHistoryOf: aUser

	| salesOfUser |
	salesOfUser _ self salesDoneBy: aUser.
	^CustomerPurchaseHistory forSales: salesOfUser.! !

!SalesBook methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 19:49:15'!
salesDoneBy: aUser

	^sales select: [ :aSale | aSale wasDoneBy: aUser ]! !

!SalesBook methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 19:54:43'!
size

	^sales size.! !


!classDefinition: #Ticket category: #'TusLibros-Model'!
Object subclass: #Ticket
	instanceVariableNames: 'lineItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Ticket methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2015 20:39'!
total

	^lineItems sum: [ :aLineItem | aLineItem total]! !


!Ticket methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:20'!
initializeOf: aCollectionOfLineItems

	lineItems := aCollectionOfLineItems ! !


!Ticket methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^lineItems do: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #'TusLibros-Model'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:20'!
of: aCollectionOfLineItems

	^self new initializeOf: aCollectionOfLineItems ! !


!classDefinition: #TusLibrosServerInterface category: #'TusLibros-Model'!
Object subclass: #TusLibrosServerInterface
	instanceVariableNames: 'webServer port systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosServerInterface methodsFor: 'as yet unclassified' stamp: 'MF 11/14/2021 17:37:37'!
addService: anEndpoint action: anActionBlock

	webServer 
		addService: anEndpoint 
		action: [ :request |
			[ anActionBlock value: request ] 
			on: Error
			do: [ :anError |
				request send400Response: anError messageText.]]! !

!TusLibrosServerInterface methodsFor: 'as yet unclassified' stamp: 'MF 11/14/2021 23:47:37'!
addToCart: aRequest

	| bookISBN bookQuantity cartId |
	cartId _ aRequest fields at: 'cartId'.
	bookISBN _ aRequest fields at: 'bookISBN'.
	bookQuantity _ aRequest fields at: 'bookQuantity'.
	systemFacade add: bookQuantity asNumber of: bookISBN toCartIdentifiedAs: cartId asNumber.
	aRequest send200Response: 'OK'.! !

!TusLibrosServerInterface methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 19:27:34'!
checkoutCart: aRequest

	| cartId creditCardNumber monthExpiration yearExpiration creditCardOwner ticket ticketAsJson |
	cartId _ aRequest fields at: 'cartId'.
	creditCardNumber _ aRequest fields at: 'ccn'.
	monthExpiration _ aRequest fields at: 'ccme'.
	yearExpiration _ aRequest fields at: 'ccye'.
	creditCardOwner _ aRequest fields at: 'cco'.
	
	ticket _ systemFacade checkOutCartIdentifiedAs: cartId asNumber
					    withCreditCardNumbered: creditCardNumber 
					    ownedBy: creditCardOwner 
					    expiringOn: (GregorianMonthOfYear 
									yearNumber: yearExpiration asNumber 
									monthNumber: monthExpiration asNumber).
	
	ticketAsJson _ self serializeTicket: ticket.
	aRequest send200Response: ticketAsJson.! !

!TusLibrosServerInterface methodsFor: 'as yet unclassified' stamp: 'MF 11/14/2021 17:43:42'!
createCart: aRequest

	| cartId cartIdAsJson clientId password |
	clientId _ aRequest fields at: 'clientId'.
	password _ aRequest fields at: 'password'.
	cartId _ systemFacade createCartFor: clientId authenticatedWith: password.
	cartIdAsJson _ WebUtils jsonEncode: (cartId asString).
	aRequest send200Response: cartIdAsJson.! !

!TusLibrosServerInterface methodsFor: 'as yet unclassified' stamp: 'MF 11/14/2021 16:57:24'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosServerInterface methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 20:45:41'!
initializeWith: aPortNumber interactingWith: aTusLibrosSystemFacade
	
	systemFacade := aTusLibrosSystemFacade.
	
	port:= aPortNumber.
	
	webServer := WebServer new listenOn: self port.
	
	self addService: '/createCart' action: [ :request | self createCart: request ].
	self addService: '/listCatalog' action: [ :request | self listCatalog: request ].
	self addService: '/addToCart' action: [ :request | self addToCart: request ].
	self addService: '/removeFromCart' action: [ :request | self removeFromCart: request ].
	self addService: '/listCart' action: [ :request | self listCart: request ].
	self addService: '/checkoutCart' action: [ :request | self checkoutCart: request ].
	self addService: '/listPurchases' action: [ :request | self listPurchases: request ].
	! !

!TusLibrosServerInterface methodsFor: 'as yet unclassified' stamp: 'MF 11/14/2021 23:56:05'!
listCart: aRequest

	| cartId cartContents contentsAsJson |
	cartId _ aRequest fields at: 'cartId'.
	cartContents _ systemFacade listCartIdentifiedAs: cartId asNumber.
	contentsAsJson _ WebUtils jsonEncode: cartContents contents.
	aRequest send200Response: contentsAsJson.! !

!TusLibrosServerInterface methodsFor: 'as yet unclassified' stamp: 'MF 11/14/2021 17:53:27'!
listCatalog: aRequest

	| catalog catalogAsJson |
	catalog _ systemFacade listCatalog.
	catalogAsJson _ WebUtils jsonEncode: catalog.
	aRequest send200Response: catalogAsJson.! !

!TusLibrosServerInterface methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 20:36:19'!
listPurchases: aRequest

	| clientId password purchases purchasesAsJson |
	clientId _ aRequest fields at: 'clientId'.
	password _ aRequest fields at: 'password'.
	purchases _ systemFacade listPurchasesOf: clientId authenticatingWith: password.
	purchasesAsJson _ self serializePurchases: purchases.
	aRequest send200Response: purchasesAsJson.! !

!TusLibrosServerInterface methodsFor: 'as yet unclassified' stamp: 'LNB 11/11/2021 22:01:25'!
port
	"Use a random port to minimise chances of concurrently running test suites clashing."
	"^ port
		ifNil: [port := (10000 to: 50000) atRandom]"
	
	^port ifNil: [port:=8080].! !

!TusLibrosServerInterface methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 20:49:10'!
removeFromCart: aRequest

	| bookISBN bookQuantity cartId |
	cartId _ aRequest fields at: 'cartId'.
	bookISBN _ aRequest fields at: 'bookISBN'.
	bookQuantity _ aRequest fields at: 'bookQuantity'.
	systemFacade remove: bookQuantity asNumber of: bookISBN toCartIdentifiedAs: cartId asNumber.
	aRequest send200Response: 'OK'.

	! !

!TusLibrosServerInterface methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 20:29:17'!
serializePurchases: purchases

	| purchasesDictionary |
	purchasesDictionary _ Dictionary new.
	
	purchases itemsDo: [ :anItem | | lineItem |
		lineItem _ purchases at: anItem.
		purchasesDictionary 
			at: anItem 
			put: (Dictionary newFromPairs: { 'total'. lineItem total. 'quantity'. lineItem quantity. }).].
	
	purchasesDictionary at: 'total' put: purchases total.
	
	^ WebUtils jsonEncode: purchasesDictionary.! !

!TusLibrosServerInterface methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 20:24:11'!
serializeTicket: aTicket

	| ticketDictionary |
	ticketDictionary _ Dictionary new.
	
	aTicket lineItemsDo: [ :aLineItem | ticketDictionary at: aLineItem item put: aLineItem total ].
	ticketDictionary at: 'total' put: aTicket total.
	
	^ WebUtils jsonEncode: ticketDictionary.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerInterface class' category: #'TusLibros-Model'!
TusLibrosServerInterface class
	instanceVariableNames: ''!

!TusLibrosServerInterface class methodsFor: 'as yet unclassified' stamp: 'MF 11/14/2021 18:06:18'!
listeningOn: aPortNumber interactingWith: aTusLibrosSystemFacade

	^self new initializeWith: aPortNumber interactingWith: aTusLibrosSystemFacade.! !


!classDefinition: #TusLibrosSystemFacade category: #'TusLibros-Model'!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'validUsersAndPasswords catalog lastId merchantProcessor salesBook clock cartSessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:24'!
canNotChargeAnExpiredCreditCardErrorMessage

	^Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage

	^Cashier cartCanNotBeEmptyErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:27'!
invalidCartIdErrorDescription

	^'Invalid cart id'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^Cart invalidItemErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:03'!
invalidUserAndOrPasswordErrorDescription

	^'Invalid user and/or password'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'LNB 11/14/2021 20:34:19'!
sessionHasExpiredErrorDescription

	^'Can not use the cart after ', self sessionDuration printString , ' minutes of inactivity'! !


!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:02'!
now

	^clock now! !

!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:49'!
today

	^clock today! !


!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
does: aUser authenticatesWith: aPassword

	"Recordar que esto es solo un ejemplo. No se deben guardar passwords en un sistema de verdad sino un
	hash o similar - Hernan"

	| storedPassword |

	storedPassword := validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	^aPassword = storedPassword ! !

!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
if: aUser authenticatesWith: aPassword do: aBlock

	^ (self does: aUser authenticatesWith: aPassword)
		ifTrue: aBlock
		ifFalse: [ self signalInvalidUserAndOrPassword ].
	! !


!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:27'!
signalInvalidCartId

	self error: self invalidCartIdErrorDescription ! !

!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:02'!
signalInvalidUserAndOrPassword

	self error: self invalidUserAndOrPasswordErrorDescription! !


!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId

	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"

	lastId := lastId + 1.
	^lastId! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'LNB 11/14/2021 19:26:09'!
sessionDuration

	^30*minute! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/17/2015 20:50'!
withCartSessionIdentifiedAs: aCartId do: aBlock

	| cartSession |

	cartSession := cartSessions at: aCartId ifAbsent: [self signalInvalidCartId ].
	^cartSession do: aBlock
! !


!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:18:41'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession addToCart: anAmount of: aBook ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'MF 11/14/2021 18:22:01'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	^self
		withCartSessionIdentifiedAs: aCartId
		do: [ :cartSession | cartSession
			checkOutCartWithCreditCardNumbered: aCreditCartNumber
			ownedBy: anOwner
			expiringOn: anExpirationMonthOfYear ]
! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:52'!
createCartFor: aUser authenticatedWith: aPassword

	^ self if: aUser authenticatesWith: aPassword do: [ | cartId cartSession |

		cartId := self generateCartId.
		cartSession := CartSession ownedBy: aUser with: (Cart acceptingItemsOf: catalog) on: self..
		cartSessions at: cartId put: cartSession.

		cartId  ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:48'!
listCartIdentifiedAs: aCartId

	^ self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession cartContent ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'MF 11/15/2021 19:56:18'!
listPurchasesOf: aUser authenticatingWith: aPassword

	^self if: aUser authenticatesWith: aPassword do: [ salesBook purchaseHistoryOf: aUser ]
	
	"^self if: aUser authenticatesWith: aPassword do: [ | sales |
		sales := self salesDoneBy: aUser.
		sales
			inject: Dictionary new
			into: [ :salesOrderedByBook :aSale |
				self list: aSale on: salesOrderedByBook.
				salesOrderedByBook ] ]"! !


!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:49'!
merchantProcessor

	^ merchantProcessor! !

!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:50'!
salesBook

	^ salesBook! !


!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:56'!
list: aSale on: salesOrderedByBook

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	aSale lineItemsDo: [ :aLineItem | | oldTotal newTotal |
		oldTotal := salesOrderedByBook at: aLineItem item ifAbsentPut: [ 0 ].
		newTotal := oldTotal + aLineItem total.
		salesOrderedByBook at: aLineItem item put: newTotal ]! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'MF 11/15/2021 19:49:32'!
salesDoneBy: aUser

	^ salesBook salesDoneBy: aUser! !


!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 14:17'!
initializeAuthenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	validUsersAndPasswords := aValidUsersAndPasswords.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.

	cartSessions := Dictionary new.
	lastId := 0.! !


!TusLibrosSystemFacade methodsFor: 'as yet unclassified' stamp: 'MF 11/14/2021 17:51:28'!
listCatalog
	
	^ catalog copy.! !

!TusLibrosSystemFacade methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 20:51:30'!
remove: anAmount of: aBook toCartIdentifiedAs: aCartId 
	
	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession removeFromCart: anAmount of: aBook ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: #'TusLibros-Model'!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 14:17'!
authenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	^self new
		initializeAuthenticatingWith: aValidUsersAndPasswords
		acceptingItemsOf: aCatalog
		registeringOn: aSalesBook
		debitingThrought: aMerchantProcessor
		measuringTimeWith: aClock! !
