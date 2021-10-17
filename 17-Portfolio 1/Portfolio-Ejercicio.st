!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'assertions' stamp: 'MF 10/17/2021 17:38:30'!
assertCantAdd: aFinancialRecord to: aPortfolio

	| previouslyAddedRecords |
	
	previouslyAddedRecords _ aPortfolio size.
	
	self should: [ aPortfolio add: aFinancialRecord ] 
		raise: Error
		withExceptionDo: 
		[ :anError | 
			self assert: anError messageText equals: Portfolio cannotAddFinancialRecordErrorDescription.
			self assert: previouslyAddedRecords equals: aPortfolio size.].
	
	! !


!PortfolioTest methodsFor: 'auxiliaries' stamp: 'LNB 10/14/2021 21:51:31'!
accountWithDepositWorth: aTransactionValue

	| account |
	
	account _ ReceptiveAccount new.
	Deposit register: aTransactionValue on: account.
	^account.! !

!PortfolioTest methodsFor: 'auxiliaries' stamp: 'LNB 10/16/2021 17:48:46'!
addNewAccountWithATransactionTo: aPortfolio

	| account |
	
	account _ (self accountWithDepositWorth: 50).
	
	aPortfolio add: account.
	
	^account transactions first.! !


!PortfolioTest methodsFor: 'balance tests' stamp: 'MF 10/17/2021 17:18:18'!
test01WhenEmptyHasZeroBalance

	| portfolio |
	
	portfolio _ self portfolio.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'balance tests' stamp: 'MF 10/17/2021 17:18:33'!
test02WithOneRecordHasThatRecordBalance

	| portfolio |
	
	portfolio _ self portfolio.
	
	portfolio add: (self accountWithDepositWorth: 50).
	
	self assert: 50 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'balance tests' stamp: 'MF 10/17/2021 17:18:38'!
test03WithManyRecordsHasSumOfRecordsBalance

	| portfolio |
	
	portfolio _ self portfolio.

	portfolio add: (self accountWithDepositWorth: 50).
	portfolio add: (self accountWithDepositWorth: 60).
	
	self assert: 110 equals: portfolio balance.! !


!PortfolioTest methodsFor: 'registered tests' stamp: 'MF 10/17/2021 17:18:44'!
test04WhenEmptyHasNoRegisteredTransactions

	| portfolio account transactionOfAccount |
	
	portfolio _ self portfolio.
	account _ (self accountWithDepositWorth: 50).
	transactionOfAccount _ account transactions first.
	
	self deny: (portfolio hasRegistered: transactionOfAccount).! !

!PortfolioTest methodsFor: 'registered tests' stamp: 'MF 10/17/2021 17:19:33'!
test05WithOneRecordHasThatRecordTransactionRegistered

	| portfolio newlyAddedTransaction |
	
	portfolio _ self portfolio.
	newlyAddedTransaction _ self addNewAccountWithATransactionTo: portfolio.
	
	self assert: (portfolio hasRegistered: newlyAddedTransaction).! !

!PortfolioTest methodsFor: 'registered tests' stamp: 'MF 10/17/2021 17:19:38'!
test06WithManyRecordsHasAllOfTheirTransactionsRegistered

	| portfolio anotherNewlyAddedTransaction newlyAddedTransaction |
	
	portfolio _ self portfolio.
	newlyAddedTransaction _ self addNewAccountWithATransactionTo: portfolio.
	anotherNewlyAddedTransaction _ self addNewAccountWithATransactionTo: portfolio.
	
	
	self assert: (portfolio hasRegistered: newlyAddedTransaction).
	self assert: (portfolio hasRegistered: anotherNewlyAddedTransaction).
	! !


!PortfolioTest methodsFor: 'transactions tests' stamp: 'MF 10/17/2021 17:19:51'!
test07WhenEmptyReturnsNoTransactions

	| portfolio |
	
	portfolio _ self portfolio.
	
	self assert: portfolio transactions isEmpty.! !

!PortfolioTest methodsFor: 'transactions tests' stamp: 'MF 10/17/2021 17:20:09'!
test08WithOneRecordReturnsItsTransactions

	| portfolio newlyAddedTransaction |
	
	portfolio _ self portfolio.
	newlyAddedTransaction _ self addNewAccountWithATransactionTo: portfolio.
	
	self assert: (portfolio transactions includes: newlyAddedTransaction).! !

!PortfolioTest methodsFor: 'transactions tests' stamp: 'MF 10/17/2021 17:20:29'!
test09WithManyRecordsReturnsUnionOfTransactions

	| portfolio anotherNewlyAddedTransaction newlyAddedTransaction |
	
	portfolio _ self portfolio.
	
	newlyAddedTransaction _ self addNewAccountWithATransactionTo: portfolio.
	anotherNewlyAddedTransaction _ self addNewAccountWithATransactionTo: portfolio.
	
	self assert: (portfolio transactions includes: newlyAddedTransaction).
	self assert: (portfolio transactions includes: anotherNewlyAddedTransaction).! !

!PortfolioTest methodsFor: 'transactions tests' stamp: 'MF 10/17/2021 18:05:30'!
test17WithPortfolioReturnsTransactionsInsideIncludedPortfolio

	| portfolio newlyAddedTransaction externalPortfolio |
	
	portfolio _ self portfolio.
	newlyAddedTransaction _ self addNewAccountWithATransactionTo: portfolio.
	
	externalPortfolio _ self portfolio.
	externalPortfolio add: portfolio.
	
	self assert: (externalPortfolio transactions includes: newlyAddedTransaction).
! !


!PortfolioTest methodsFor: 'adding assertions tests' stamp: 'MF 10/17/2021 17:20:41'!
test10CantAddRepeatedRecord

	| portfolio account |
	
	portfolio _ self portfolio.
	account _ self accountWithDepositWorth: 50.
	
	portfolio add: account.
	
	self assertCantAdd: account to: portfolio.! !

!PortfolioTest methodsFor: 'adding assertions tests' stamp: 'MF 10/17/2021 17:21:16'!
test11WithRecordCantAddAnotherPortfolioWithSameRecord

	| internalPortfolio externalPortfolio account |
	
	internalPortfolio _ self portfolio.
	account _ self accountWithDepositWorth: 50.
	internalPortfolio add: account.
	
	externalPortfolio _ self portfolio.
	externalPortfolio add: internalPortfolio.
	
	self assertCantAdd: account to: externalPortfolio.! !

!PortfolioTest methodsFor: 'adding assertions tests' stamp: 'MF 10/17/2021 17:53:15'!
test12CantAddItself

	| portfolio |
	
	portfolio _ self portfolio.
	
	self should: [ portfolio add: portfolio ] 
		raise: Error
		withExceptionDo: 
		[ :anError | self assert: 
			anError messageText equals: Portfolio cannotAddItselfErrorDescription ].! !

!PortfolioTest methodsFor: 'adding assertions tests' stamp: 'MF 10/17/2021 18:03:47'!
test13WithOneParentCantAddRecordRepeatedInParent

	| internalPortfolio externalPortfolio account |
	
	internalPortfolio _ self portfolio.
	account _ self accountWithDepositWorth: 50.
	
	externalPortfolio _ self portfolio.
	externalPortfolio add: account.
	externalPortfolio add: internalPortfolio. 
	
	self assertCantAdd: account to: internalPortfolio.! !

!PortfolioTest methodsFor: 'adding assertions tests' stamp: 'MF 10/17/2021 18:01:27'!
test14CantAddRecordThatIsInGrandparentPortfolio

	| internalPortfolio externalPortfolio account deeperInternalPortfolio |
	
	internalPortfolio _ self portfolio.
	account _ self accountWithDepositWorth: 50.
	
	externalPortfolio _ self portfolio.
	externalPortfolio add: account.
	externalPortfolio add: internalPortfolio. 
	
	deeperInternalPortfolio _ self portfolio.
	internalPortfolio add: deeperInternalPortfolio.
	
	self assertCantAdd: account to: deeperInternalPortfolio.! !

!PortfolioTest methodsFor: 'adding assertions tests' stamp: 'MF 10/17/2021 18:03:54'!
test15WithManyParentsCantAddRecordRepeatedInParent

	| internalPortfolio externalPortfolio account anotherExternalPortfolio |
	
	internalPortfolio _ self portfolio.
	account _ self accountWithDepositWorth: 50.
	
	externalPortfolio _ self portfolio.
	externalPortfolio add: account.
	externalPortfolio add: internalPortfolio. 
	
	anotherExternalPortfolio _ self portfolio.
	anotherExternalPortfolio add: internalPortfolio .
	
	self assertCantAdd: account to: internalPortfolio.! !

!PortfolioTest methodsFor: 'adding assertions tests' stamp: 'MF 10/17/2021 18:09:49'!
test16CantAddRecordRepeatedInSiblingPortfolio

	| internalPortfolio siblingInternalPortfolio account externalPortfolio |
	
	internalPortfolio _ self portfolio.
	account _ self accountWithDepositWorth: 50.
	
	siblingInternalPortfolio _ self portfolio.
	siblingInternalPortfolio add: account.
	
	externalPortfolio _ self portfolio.
	externalPortfolio add: internalPortfolio.
	externalPortfolio add: siblingInternalPortfolio.
	
	self assertCantAdd: account to: internalPortfolio.! !

!PortfolioTest methodsFor: 'adding assertions tests' stamp: 'MF 10/17/2021 18:08:29'!
test18WithRecordCantAddPortfolioWithThatSameRecord

	| internalPortfolio externalPortfolio account |
	
	internalPortfolio _ self portfolio.
	account _ self accountWithDepositWorth: 50.
	internalPortfolio add: account.
	
	externalPortfolio _ self portfolio.
	externalPortfolio add: account.
	
	self assertCantAdd: internalPortfolio to: externalPortfolio.! !


!PortfolioTest methodsFor: 'portfolio creation' stamp: 'LNB 10/14/2021 21:43:28'!
portfolio

	^ Portfolio new! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'MF 10/13/2021 23:31:30'!
modifyBalance: balanceToChange

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'MF 10/13/2021 23:32:03'!
modifyBalance: balanceToChange

	^balanceToChange + self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'MF 10/13/2021 23:32:20'!
modifyBalance: balanceToChange

	^balanceToChange - self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialRecord category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialRecord
	instanceVariableNames: 'parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialRecord methodsFor: 'balance' stamp: 'MF 10/16/2021 19:49:16'!
balance

	self subclassResponsibility! !


!FinancialRecord methodsFor: 'transactions' stamp: 'MF 10/16/2021 20:15:03'!
addAllTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility.! !

!FinancialRecord methodsFor: 'transactions' stamp: 'MF 10/16/2021 19:51:22'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!FinancialRecord methodsFor: 'transactions' stamp: 'MF 10/16/2021 19:49:57'!
transactions

	self subclassResponsibility! !


!FinancialRecord methodsFor: 'assertions' stamp: 'MF 10/16/2021 19:41:49'!
assertDoesNotAppearRepeated: aFinancialRecord

	self subclassResponsibility.! !

!FinancialRecord methodsFor: 'assertions' stamp: 'MF 10/17/2021 17:59:40'!
assertIsNotEqual: aFinancialRecord

	self = aFinancialRecord ifTrue: [ self signalCannotAddFinancialRecordError ]! !


!FinancialRecord methodsFor: 'adding' stamp: 'MF 10/16/2021 19:19:05'!
addParent: aParentPortfolio.

	parentPortfolios add: aParentPortfolio.! !


!FinancialRecord methodsFor: 'error signals' stamp: 'MF 10/17/2021 17:59:51'!
signalCannotAddFinancialRecordError

	self error: FinancialRecord cannotAddFinancialRecordErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FinancialRecord class' category: 'Portfolio-Ejercicio'!
FinancialRecord class
	instanceVariableNames: ''!

!FinancialRecord class methodsFor: 'error descriptions' stamp: 'MF 10/17/2021 17:51:28'!
cannotAddFinancialRecordErrorDescription

	^'Cannot add repeated financial record'! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialRecord subclass: #Portfolio
	instanceVariableNames: 'financialRecords'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'LNB 10/14/2021 21:40:40'!
balance

	^financialRecords sum: [ :aFinancialRecord | aFinancialRecord balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'adding' stamp: 'MF 10/17/2021 17:53:14'!
add: aFinancialRecord 
	
	self assertIsNotItself: aFinancialRecord.
	self assertCanAdd: aFinancialRecord.
	
	financialRecords add: aFinancialRecord.
	aFinancialRecord addParent: self.! !


!Portfolio methodsFor: 'testing' stamp: 'LNB 10/14/2021 21:40:56'!
hasRegistered: aTransaction

	^ financialRecords anySatisfy: [ :aFinancialRecord | aFinancialRecord hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'MF 10/17/2021 17:30:20'!
includes: aFinancialRecord

	^ financialRecords includes: aFinancialRecord! !


!Portfolio methodsFor: 'transactions' stamp: 'MF 10/16/2021 20:14:33'!
addAllTransactionsTo: aCollectionOfTransactions
	
	financialRecords do: [ :aFinancialRecord | aFinancialRecord addAllTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'MF 10/16/2021 20:12:30'!
transactions

	| allTransactions |
	allTransactions _ OrderedCollection new.
	financialRecords do: [ :aFinancialRecord | aFinancialRecord addAllTransactionsTo: allTransactions ].
	
	^allTransactions.! !


!Portfolio methodsFor: 'error signals' stamp: 'MF 10/16/2021 18:42:35'!
signalCannotAddItselfError

	^ self error: Portfolio cannotAddItselfErrorDescription! !


!Portfolio methodsFor: 'initialization' stamp: 'MF 10/16/2021 19:19:27'!
initialize

	financialRecords _ OrderedCollection new.
	parentPortfolios _ OrderedCollection new.! !


!Portfolio methodsFor: 'assertions' stamp: 'MF 10/16/2021 20:03:00'!
assertAllRootPortfoliosCanAdd: aFinancialRecord

	^parentPortfolios do: [ :aParentPortfolio | aParentPortfolio assertCanAdd: aFinancialRecord ]! !

!Portfolio methodsFor: 'assertions' stamp: 'MF 10/17/2021 17:14:39'!
assertCanAdd: aFinancialRecord.
	
	parentPortfolios isEmpty
		ifTrue: [ self assertDoesNotAppearRepeated: aFinancialRecord ]
		ifFalse: [ self assertAllRootPortfoliosCanAdd: aFinancialRecord]! !

!Portfolio methodsFor: 'assertions' stamp: 'MF 10/17/2021 17:57:47'!
assertDoesNotAppearRepeated: aFinancialRecord
	
	self assertIsNotEqual: aFinancialRecord.
	self assertRecordIsNotIndirectlyIncluded: aFinancialRecord.! !

!Portfolio methodsFor: 'assertions' stamp: 'MF 10/17/2021 17:52:01'!
assertIsNotItself: aFinancialRecord

	self = aFinancialRecord ifTrue: [ self signalCannotAddItselfError ]! !

!Portfolio methodsFor: 'assertions' stamp: 'MF 10/17/2021 17:44:58'!
assertRecordIsNotIndirectlyIncluded: aFinancialRecord

	financialRecords do: [ :internalFinancialRecord | 
		internalFinancialRecord assertDoesNotAppearRepeated: aFinancialRecord.
		aFinancialRecord assertDoesNotAppearRepeated: internalFinancialRecord.]! !


!Portfolio methodsFor: 'size' stamp: 'MF 10/17/2021 17:38:45'!
size

	^ financialRecords size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'MF 10/16/2021 18:40:39'!
cannotAddItselfErrorDescription

	^'Cannot add portfolio to itself'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialRecord subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'MF 10/16/2021 19:19:40'!
initialize

	transactions _ OrderedCollection new.
	parentPortfolios _ OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'MF 10/16/2021 20:14:56'!
addAllTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: self transactions.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'MF 10/13/2021 23:32:36'!
balance

	^transactions inject: 0 into: [ :balanceBeingCalculated :transaction |
		 transaction modifyBalance: balanceBeingCalculated ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'assertions' stamp: 'MF 10/17/2021 17:58:02'!
assertDoesNotAppearRepeated: aFinancialRecord

	self assertIsNotEqual: aFinancialRecord.! !
