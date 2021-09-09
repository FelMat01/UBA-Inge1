!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'assertions' stamp: 'MF 9/7/2021 22:38:29'!
assert: aCustomerBook hasActiveCustomers: anExpectedAmountOfActiveCustomers hasSuspendedCustomers: anExpectedAmountOfSuspendedCustomers hasTotalCustomers: anExpectedAmountOfTotalCustomers
	
	self assert: anExpectedAmountOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: anExpectedAmountOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: anExpectedAmountOfTotalCustomers equals: aCustomerBook numberOfCustomers.

	
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'MF 9/8/2021 23:08:44'!
assert: aCustomerBook hasExactlyOneCustomerNamed: aCustomerName

	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: aCustomerName)! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'MF 9/7/2021 19:05:55'!
assertMillisecondsToRun: aTimedClosure isLessThan: aTimeConstraint

	self assert: aTimedClosure timeToRun < aTimeConstraint! !


!CustomerBookTest methodsFor: 'testing' stamp: 'MF 9/8/2021 23:15:28'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertMillisecondsToRun: [ customerBook addCustomerNamed: 'John Lennon' ] isLessThan: 50 * millisecond.	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MF 9/8/2021 23:15:22'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.

	self assertMillisecondsToRun: [ customerBook removeCustomerNamed: paulMcCartney ] isLessThan: 100 * millisecond.	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MF 9/8/2021 23:10:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self should: [ customerBook addCustomerNamed: ''. ]
		raise: Error
		withExceptionDo: [ :anError | 
					     self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
					     self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MF 9/8/2021 23:09:15'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self should: [ customerBook removeCustomerNamed: 'Paul McCartney' ] 
		raise: NotFound 
		withExceptionDo: [ :anError | 
					     self assert: customerBook hasExactlyOneCustomerNamed: johnLennon ].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MF 9/7/2021 22:39:00'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: customerBook hasActiveCustomers: 0 hasSuspendedCustomers: 1 hasTotalCustomers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MF 9/7/2021 22:39:14'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: customerBook hasActiveCustomers: 0 hasSuspendedCustomers: 0 hasTotalCustomers: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MF 9/8/2021 23:09:08'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
		
	self should: [ customerBook suspendCustomerNamed: 'George Harrison'. ] 
		raise: CantSuspend
		withExceptionDo: [ :anError | 
					     self assert: customerBook hasExactlyOneCustomerNamed: johnLennon ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MF 9/8/2021 23:08:58'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self should: [ customerBook suspendCustomerNamed: johnLennon. ] 
		raise: CantSuspend
		withExceptionDo: [ :anError | 
					     self assert: customerBook hasExactlyOneCustomerNamed: johnLennon ].
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'MF 9/7/2021 18:56:13'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MF 9/7/2021 22:10:50'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MF 9/7/2021 22:15:44'!
removeCustomerNamed: aName 
 
	active remove: aName ifAbsent: [ suspended remove: aName ifAbsent: [ ^ NotFound signal ] ].! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'MF 9/8/2021 23:14:32'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:13'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:09'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!!!!!'! !
