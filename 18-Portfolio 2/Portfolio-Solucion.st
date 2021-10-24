!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'special summary tests' stamp: 'LNB 10/24/2021 19:14:28'!
test20SpecialSummaryForEmptyPortfolioOnlyDisplaysItsNameAndBalance

	| portfolio name expectedStructureReport |
	
	name _ 'Portfolio de la familia'.
	portfolio _ Portfolio named: name.
	
	expectedStructureReport _ OrderedCollection with: name
											  with: '  Balance = 0'.
	
	self assert: expectedStructureReport equals: (SpecialSummaryPrinter for: portfolio) getReport.! !

!ReportTest methodsFor: 'special summary tests' stamp: 'LNB 10/24/2021 19:14:34'!
test21SpecialSummaryWithOneAccountDisplaysPortfolioStructureAndAccountSummaryForThatAccount

	| portfolio expectedStructureReport account |
	
	account _ ReceptiveAccount named: 'Cuenta Mia'.
	portfolio _ Portfolio named: 'Portfolio de la familia' with: account.
	Deposit register: 50 on: account.
	
	expectedStructureReport _ OrderedCollection with: 'Portfolio de la familia' 
											  with: '  Cuenta Mia'
											  with: '    Depósito por 50.'
											  with: '    Balance = 50'
											  with: '  Balance = 50'.
	
	self assert: expectedStructureReport equals: (SpecialSummaryPrinter for: portfolio) getReport.! !

!ReportTest methodsFor: 'special summary tests' stamp: 'LNB 10/24/2021 19:14:42'!
test22SpecialSummaryDisplaysDifferentTransactions

	| portfolio expectedStructureReport account |
	
	account _ ReceptiveAccount named: 'Cuenta Mia'.
	portfolio _ Portfolio named: 'Portfolio de la familia' with: account.
	Withdraw register: 50 on: account.
	
	expectedStructureReport _ OrderedCollection with: 'Portfolio de la familia' 
											  with: '  Cuenta Mia'
											  with: '    Extracción por 50.'
											  with: '    Balance = -50'
											  with: '  Balance = -50'.
	
	self assert: expectedStructureReport equals: (SpecialSummaryPrinter for: portfolio) getReport.! !

!ReportTest methodsFor: 'special summary tests' stamp: 'LNB 10/24/2021 19:15:35'!
test26SpecialSummaryPrinterIsReusable

	| account reporter expectedSummary name |
	
	name _ 'Cuenta Mia'.
	account _ ReceptiveAccount named: name.
	reporter _ (SpecialSummaryPrinter for: account).
	reporter getReport.
	
	expectedSummary _ OrderedCollection with: name with: '  Balance = 0'.
	
	self assert: expectedSummary equals: reporter getReport.! !


!ReportTest methodsFor: 'auxiliaries' stamp: 'MF 10/23/2021 19:07:48'!
summaryFor: anAccount

	^(AccountSummaryPrinter for: anAccount) getReport! !

!ReportTest methodsFor: 'auxiliaries' stamp: 'MF 10/21/2021 21:25:26'!
transferNetFor: anAccount

	^(TransferNetCalculator for: anAccount) transferNet! !


!ReportTest methodsFor: 'account summary tests' stamp: 'LNB 10/24/2021 19:11:24'!
test01AccountSummaryForReceptiveAccountDisplaysBalance

	| account |
	account _ ReceptiveAccount new.
	
	self assert: (self summaryFor: account) includes: 'Balance = 0'! !

!ReportTest methodsFor: 'account summary tests' stamp: 'LNB 10/24/2021 19:11:39'!
test02AccountSummaryForReceptiveAccountDisplaysDeposits

	| account expectedSummary |
	account _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	expectedSummary _ OrderedCollection with: 'Depósito por 100.' with: 'Balance = 100'.
	
	self assert: expectedSummary equals: (self summaryFor: account).! !

!ReportTest methodsFor: 'account summary tests' stamp: 'LNB 10/24/2021 19:11:57'!
test03AccountSummaryForReceptiveAccountDisplaysWithdrawals

	| account expectedSummary |
	account _ ReceptiveAccount new.
	Withdraw register: 100 on: account. 
	
	expectedSummary _ OrderedCollection with: 'Extracción por 100.' with: 'Balance = -100'.
	
	self assert: expectedSummary equals: (self summaryFor: account)! !

!ReportTest methodsFor: 'account summary tests' stamp: 'LNB 10/24/2021 19:12:07'!
test04AccountSummaryForReceptiveAccountDisplaysTransactionsForDifferentValues

	| account expectedSummary |
	account _ ReceptiveAccount new.
	Deposit register: 50 on: account. 
	
	expectedSummary _ OrderedCollection with: 'Depósito por 50.' with: 'Balance = 50'.
	
	self assert: expectedSummary equals: (self summaryFor: account).! !

!ReportTest methodsFor: 'account summary tests' stamp: 'LNB 10/24/2021 19:12:15'!
test05AccountSummaryForReceptiveAccountDisplaysMultipleTransactions

	| account expectedSummary |
	account _ ReceptiveAccount new.
	Deposit register: 50 on: account. 
	Withdraw register: 40 on: account. 
	
	expectedSummary _ OrderedCollection with: 'Depósito por 50.' 
									with: 'Extracción por 40.'
									with: 'Balance = 10'.
	
	self assert: expectedSummary equals: (self summaryFor: account).! !

!ReportTest methodsFor: 'account summary tests' stamp: 'LNB 10/24/2021 19:12:27'!
test06AccountSummaryForReceptiveAccountDisplaysTransferDeposits

	| transfereeAccount transfererAccount expectedSummary |
	transfereeAccount _ ReceptiveAccount new.
	transfererAccount _ ReceptiveAccount new.
	Transfer register: 50 from: transfererAccount to: transfereeAccount. 
	
	expectedSummary _ OrderedCollection with: 'Entrada por transferencia de 50.'
										with: 'Balance = 50'.
	
	self assert: expectedSummary equals: (self summaryFor: transfereeAccount ).! !

!ReportTest methodsFor: 'account summary tests' stamp: 'LNB 10/24/2021 19:12:33'!
test07AccountSummaryForReceptiveAccountDisplaysTransferWithdrawEnd

	| transfereeAccount transfererAccount expectedSummary |
	transfereeAccount _ ReceptiveAccount new.
	transfererAccount _ ReceptiveAccount new.
	Transfer register: 50 from: transfererAccount to: transfereeAccount. 
	
	expectedSummary _ OrderedCollection with: 'Salida por transferencia de 50.'
										with: 'Balance = -50'.
	
	self assert: expectedSummary equals: (self summaryFor: transfererAccount ).! !

!ReportTest methodsFor: 'account summary tests' stamp: 'LNB 10/24/2021 19:13:31'!
test12AccountSummaryForEmptyPortfolioOnlyDisplaysBalance

	| portfolio expectedSummary |
	portfolio _ Portfolio new. 
	
	expectedSummary _ OrderedCollection with: 'Balance = 0'.
	
	self assert: expectedSummary equals: (self summaryFor: portfolio).! !

!ReportTest methodsFor: 'account summary tests' stamp: 'LNB 10/24/2021 19:13:41'!
test13AccountSummaryForPortfolioWithAnAccountDisplaysThatAccountsSummary

	| portfolio expectedSummary account |
	account _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio _ Portfolio with: account. 
	
	expectedSummary _ OrderedCollection with: 'Depósito por 100.' with: 'Balance = 100'.
	
	self assert: expectedSummary equals: (self summaryFor: portfolio).! !

!ReportTest methodsFor: 'account summary tests' stamp: 'LNB 10/24/2021 19:13:48'!
test14AccountSummaryForPortfolioDisplaysTransactionsOfAllAccountsAndPortfolioBalance

	| portfolio expectedSummary account anotherAccount |
	account _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	anotherAccount _ ReceptiveAccount new.
	Withdraw register: 50 on: anotherAccount.
	
	portfolio _ Portfolio with: account with: anotherAccount. 
	
	expectedSummary _ OrderedCollection with: 'Depósito por 100.' 
										with: 'Extracción por 50.'
										with: 'Balance = 50'.
	
	self assert: expectedSummary equals: (self summaryFor: portfolio).! !

!ReportTest methodsFor: 'account summary tests' stamp: 'LNB 10/24/2021 19:14:52'!
test23AccountSummaryPrinterIsReusable

	| account reporter expectedSummary |
	account _ ReceptiveAccount new.
	reporter _ (AccountSummaryPrinter for: account).
	reporter getReport.
	
	expectedSummary _ OrderedCollection with: 'Balance = 0'.
	
	self assert: expectedSummary equals: reporter getReport.! !


!ReportTest methodsFor: 'transfer net tests' stamp: 'LNB 10/24/2021 19:12:45'!
test08TransferNetForReceptiveAccountWithNoTransactionsTotals0

	| account |
	account _ ReceptiveAccount new.
	self assert: (self transferNetFor: account) equals: 0.! !

!ReportTest methodsFor: 'transfer net tests' stamp: 'LNB 10/24/2021 19:12:53'!
test09TransferNetForReceptiveAccountThatGotTransferedAnAmountTotalsThatAmount

	| account anotherAccount |
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	Transfer register: 50 from: anotherAccount to: account. 
	
	self assert: 50 equals: (self transferNetFor: account).! !

!ReportTest methodsFor: 'transfer net tests' stamp: 'LNB 10/24/2021 19:13:04'!
test10TransferNetDoesntCountDepositsOrWithdrawals

	| account anotherAccount |
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	Transfer register: 50 from: anotherAccount to: account. 
	Deposit register: 50 on: account.
	Withdraw register: 50 on: account.
	
	self assert: 50 equals: (self transferNetFor: account) .! !

!ReportTest methodsFor: 'transfer net tests' stamp: 'LNB 10/24/2021 19:13:18'!
test11TransferNetAddsTransfersDepositEndsAndSubstractsTransferWithdrawalEnds

	| account anotherAccount |
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	Transfer register: 50 from: anotherAccount to: account. 
	Transfer register: 40 from: account to: anotherAccount.
	Deposit register: 50 on: account.
	
	self assert: 10 equals: (self transferNetFor: account).! !

!ReportTest methodsFor: 'transfer net tests' stamp: 'LNB 10/24/2021 19:13:55'!
test15TransferNetForEmptyPortfolioTotals0

	| portfolio |
	portfolio _ Portfolio new.
	
	self assert: (self transferNetFor: portfolio) equals: 0.! !

!ReportTest methodsFor: 'transfer net tests' stamp: 'LNB 10/24/2021 19:15:02'!
test24TransferNetCalculatorIsReusable

	| account anotherAccount reporter |
	account _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	Transfer register: 50 from: anotherAccount to: account. 
	
	reporter _ (TransferNetCalculator for: account).
	reporter transferNet.
	
	self assert: 50 equals: reporter transferNet.! !


!ReportTest methodsFor: 'account structure tests' stamp: 'LNB 10/24/2021 19:14:02'!
test16AccountStructureForEmptyPortfolioDisplaysAParticularPortfolioName

	| portfolio name expectedStructureReport |
	
	name _ 'Portfolio de la familia'.
	portfolio _ Portfolio named: name.
	
	expectedStructureReport _ OrderedCollection with: name.
	
	self assert: expectedStructureReport equals: (AccountStructurePrinter for: portfolio) getReport.! !

!ReportTest methodsFor: 'account structure tests' stamp: 'LNB 10/24/2021 19:14:08'!
test17AccountStructureForEmptyPortfolioDisplaysAnArbitraryPortfolioName

	| portfolio name expectedStructureReport |
	
	name _ 'Portfolio de hijos'.
	portfolio _ Portfolio named: name.
	
	expectedStructureReport _ OrderedCollection with: name.
	
	self assert: expectedStructureReport equals: (AccountStructurePrinter for: portfolio) getReport.! !

!ReportTest methodsFor: 'account structure tests' stamp: 'LNB 10/24/2021 19:14:14'!
test18AccountStructureDisplaysPortfolioAccountsNamesWithCorrectIndentation

	| portfolio expectedStructureReport account |
	
	account _ ReceptiveAccount named: 'Cuenta Mia'.
	portfolio _ Portfolio named: 'Portfolio de la familia' with: account.
	
	expectedStructureReport _ OrderedCollection with: 'Portfolio de la familia' 
											  with: '  Cuenta Mia'.
	
	self assert: expectedStructureReport equals: (AccountStructurePrinter for: portfolio) getReport.! !

!ReportTest methodsFor: 'account structure tests' stamp: 'LNB 10/24/2021 19:14:21'!
test19AccountStructureDisplaysInternalPortfolioStructureWithCorrectIndentation

	| portfolio expectedStructureReport account anotherAccount internalPortfolio |
	
	account _ ReceptiveAccount named: 'Cuenta Mia'.
	anotherAccount _ ReceptiveAccount named: 'Cuenta de Juan'.
	internalPortfolio _ Portfolio named: 'Portfolio de hijos' with: anotherAccount.
	portfolio _ Portfolio named: 'Portfolio de la familia' with: account with: internalPortfolio.
	
	expectedStructureReport _ OrderedCollection with: 'Portfolio de la familia' 
											  with: '  Cuenta Mia'
											  with: '  Portfolio de hijos'
											  with: '    Cuenta de Juan'.
	
	self assert: expectedStructureReport equals: (AccountStructurePrinter for: portfolio) getReport.! !

!ReportTest methodsFor: 'account structure tests' stamp: 'LNB 10/24/2021 19:15:13'!
test25AccountStructurePrinterIsReusable

	| account reporter expectedSummary name |
	
	name _ 'Cuenta Mia'.
	account _ ReceptiveAccount named: name.
	reporter _ (AccountStructurePrinter for: account).
	reporter getReport.
	
	expectedSummary _ OrderedCollection with: name.
	
	self assert: expectedSummary equals: reporter getReport.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'MF 10/18/2021 21:46:08'!
test01BalancesOfAccountsAreCorrectAfterTransfer

	| accountFrom accountTo |
	accountFrom _ ReceptiveAccount new.
	accountTo _ ReceptiveAccount new.
	
	Transfer register: 50 from: accountFrom to: accountTo.
	
	self assert: 50 equals: accountTo balance.
	self assert: -50 equals: accountFrom balance.! !

!TransferTest methodsFor: 'tests' stamp: 'MF 10/18/2021 21:47:08'!
test02TransferEndsKnowEachOther

	| accountFrom accountTo transfer |
	accountFrom _ ReceptiveAccount new.
	accountTo _ ReceptiveAccount new.
	
	transfer _ Transfer register: 50 from: accountFrom to: accountTo.
	
	self assert: transfer depositEnd otherEnd equals: transfer withdrawEnd.
	self assert: transfer withdrawEnd otherEnd equals: transfer depositEnd.! !

!TransferTest methodsFor: 'tests' stamp: 'MF 10/18/2021 21:46:48'!
test03TransferEndsAreRegisteredInAccounts

	| accountFrom accountTo transfer |
	accountFrom _ ReceptiveAccount new.
	accountTo _ ReceptiveAccount new.
	
	transfer _ Transfer register: 50 from: accountFrom to: accountTo.
	
	self assert: (accountFrom hasRegistered: transfer withdrawEnd).
	self assert: (accountTo hasRegistered: transfer depositEnd).! !

!TransferTest methodsFor: 'tests' stamp: 'MF 10/18/2021 21:35:01'!
test04TransferValueMustBePositive

	| accountFrom accountTo |
	accountFrom _ ReceptiveAccount new.
	accountTo _ ReceptiveAccount new.
	
	self should: [ Transfer register: 0 from: accountFrom to: accountTo ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Transfer cannotTransferLessThanOrEqualToZeroErrorDescription ] ! !

!TransferTest methodsFor: 'tests' stamp: 'MF 10/18/2021 21:37:15'!
test05AccountBeingTransferedToIsDifferentOfAccountThatTransfers

	| account  |
	account _ ReceptiveAccount new.
	
	self should: [ Transfer register: 50 from: account to: account ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Transfer cannotTransferToItselfErrorDescription ] ! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'transactions report' stamp: 'LNB 10/23/2021 20:59:07'!
getReportForTransactions: aReport

	self subclassResponsibility.! !


!Account methodsFor: 'accessing' stamp: 'LNB 10/23/2021 20:55:51'!
name

	^name.! !


!Account methodsFor: 'account report' stamp: 'LNB 10/23/2021 21:00:20'!
reportTo: aStructureReport

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'LNB 10/24/2021 18:28:13'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := ''.! !

!Portfolio methodsFor: 'initialization' stamp: 'MF 10/23/2021 17:20:02'!
initializeNamed: aName

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := aName.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'transactions report' stamp: 'MF 10/23/2021 17:58:57'!
getReportForTransactions: aReport

	accounts do: [ :account | account getReportForTransactions: aReport ]! !


!Portfolio methodsFor: 'account report' stamp: 'MF 10/23/2021 18:41:51'!
reportAccountsTo: aStructureReport

	accounts do: [ :anAccount | anAccount reportTo: aStructureReport ]! !

!Portfolio methodsFor: 'account report' stamp: 'MF 10/23/2021 18:32:08'!
reportTo: aStructureReport

	aStructureReport reportAPortfolio: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'MF 10/23/2021 17:20:34'!
named: aName

	^self new 
		initializeNamed: aName; 
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'MF 10/23/2021 17:44:09'!
named: aName with: anAccount
	
	^self new 
		initializeNamed: aName;
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'MF 10/23/2021 17:19:41'!
named: aName with: anAccount with: anotherAccount

	^self new 
		initializeNamed: aName; 
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'error descriptions' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LNB 10/24/2021 18:29:24'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	name := ''.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LNB 10/24/2021 18:31:38'!
initializeNamed: aName
	
	self initialize.
	name _ aName.
	! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'transactions report' stamp: 'MF 10/23/2021 17:58:57'!
getReportForTransactions: aReport
	
	transactions do: [ :transaction | 
		 transaction reportTo: aReport.
	].
! !


!ReceptiveAccount methodsFor: 'account report' stamp: 'MF 10/23/2021 18:32:22'!
reportTo: aStructureReport

	aStructureReport reportAReceptiveAccount: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'MF 10/23/2021 17:37:11'!
named: aName 
	
	^self new initializeNamed: aName.! !


!classDefinition: #AccountReport category: 'Portfolio-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReport methodsFor: 'account report' stamp: 'LNB 10/24/2021 18:36:36'!
initializeFor: aPortfolio

	self subclassResponsibility.! !

!AccountReport methodsFor: 'account report' stamp: 'MF 10/23/2021 19:25:49'!
reportAPortfolio: aPortfolio

	self subclassResponsibility.! !

!AccountReport methodsFor: 'account report' stamp: 'MF 10/23/2021 19:25:59'!
reportAReceptiveAccount: aReceptiveAccount.

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: 'Portfolio-Solucion'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'instance creation' stamp: 'MF 10/23/2021 19:25:06'!
for: anAccount

	^self new initializeFor: anAccount.! !


!classDefinition: #AccountStructurePrinter category: 'Portfolio-Solucion'!
AccountReport subclass: #AccountStructurePrinter
	instanceVariableNames: 'lines currentIndentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountStructurePrinter methodsFor: 'account report - private' stamp: 'MF 10/23/2021 19:28:24'!
decreaseIndentation

	currentIndentation _ currentIndentation withoutSuffix: '  '! !

!AccountStructurePrinter methodsFor: 'account report - private' stamp: 'MF 10/23/2021 19:28:20'!
increaseIndentation

	currentIndentation _ currentIndentation, '  '! !


!AccountStructurePrinter methodsFor: 'initialization' stamp: 'MF 10/23/2021 19:24:32'!
initializeFor: aPortfolio

	account _ aPortfolio.
	currentIndentation _ ''.
	lines _ OrderedCollection new.! !


!AccountStructurePrinter methodsFor: 'reporting' stamp: 'LNB 10/23/2021 20:16:47'!
getReport
	
	lines _ OrderedCollection new.
	
	account reportTo: self.
	
	^lines! !


!AccountStructurePrinter methodsFor: 'account report' stamp: 'MF 10/23/2021 19:28:17'!
reportAPortfolio: aPortfolio

	lines add: currentIndentation, aPortfolio name.
	
	self increaseIndentation.
	aPortfolio reportAccountsTo: self.
	self decreaseIndentation.
	! !

!AccountStructurePrinter methodsFor: 'account report' stamp: 'MF 10/23/2021 18:43:03'!
reportAReceptiveAccount: aReceptiveAccount.

	lines add: currentIndentation, aReceptiveAccount name.! !


!classDefinition: #SpecialSummaryPrinter category: 'Portfolio-Solucion'!
AccountReport subclass: #SpecialSummaryPrinter
	instanceVariableNames: 'lines currentIndentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SpecialSummaryPrinter methodsFor: 'account report' stamp: 'MF 10/23/2021 19:27:21'!
increaseIndentation

	currentIndentation _ currentIndentation, '  '! !

!SpecialSummaryPrinter methodsFor: 'account report' stamp: 'MF 10/23/2021 19:30:17'!
reportAPortfolio: aPortfolio

	lines add: currentIndentation, aPortfolio name.
	
	self increaseIndentation.
	
	account reportAccountsTo: self.
	lines add: currentIndentation, 'Balance = ', aPortfolio balance asString.
	
	self decreaseIndentation ! !

!SpecialSummaryPrinter methodsFor: 'account report' stamp: 'MF 10/23/2021 19:27:16'!
reportAReceptiveAccount: aReceptiveAccount

	| accountSummaryReport |
	lines add: currentIndentation, aReceptiveAccount name.
	
	self increaseIndentation.

	accountSummaryReport _ (AccountSummaryPrinter for: aReceptiveAccount) getReport.
	accountSummaryReport do: [ :aLine | lines add: currentIndentation, aLine.].
	
	self decreaseIndentation.! !


!SpecialSummaryPrinter methodsFor: 'account report - private' stamp: 'MF 10/23/2021 19:27:24'!
decreaseIndentation

	currentIndentation _ currentIndentation withoutSuffix: '  '! !


!SpecialSummaryPrinter methodsFor: 'initialization' stamp: 'MF 10/23/2021 19:24:32'!
initializeFor: aPortfolio

	account _ aPortfolio.
	lines _ OrderedCollection new.
	currentIndentation _ ''.! !


!SpecialSummaryPrinter methodsFor: 'reporting' stamp: 'LNB 10/23/2021 20:19:04'!
getReport

	lines _ OrderedCollection new.

	account reportTo: self.
	
	^lines! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'transactions report' stamp: 'LNB 10/23/2021 20:47:11'!
reportTo: aReport

	self subclassResponsibility.! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'transactions report' stamp: 'MF 10/23/2021 18:11:49'!
reportTo: aReport

	aReport reportADeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'MF 10/18/2021 21:43:21'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferEnd category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferEnd
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferEnd methodsFor: 'accessing' stamp: 'MF 10/20/2021 22:05:57'!
otherEnd

	self subclassResponsibility ! !


!TransferEnd methodsFor: 'initialization' stamp: 'MF 10/18/2021 20:57:53'!
initializeOf: aTransfer.

	transfer _ aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferEnd class' category: 'Portfolio-Solucion'!
TransferEnd class
	instanceVariableNames: ''!

!TransferEnd class methodsFor: 'instance creation' stamp: 'MF 10/18/2021 20:57:30'!
of: aTransfer.
	
	^self new initializeOf: aTransfer.! !

!TransferEnd class methodsFor: 'instance creation' stamp: 'MF 10/18/2021 20:57:22'!
registerTransfer: aTransfer to: anAccount

	| transaction |
	
	transaction := self of: aTransfer.
	anAccount register: transaction.
		
	^transaction! !


!classDefinition: #TransferDepositEnd category: 'Portfolio-Solucion'!
TransferEnd subclass: #TransferDepositEnd
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDepositEnd methodsFor: 'balance' stamp: 'MF 10/20/2021 22:05:25'!
affectBalance: aBalance

	^aBalance + self value.! !


!TransferDepositEnd methodsFor: 'value' stamp: 'MF 10/18/2021 20:48:37'!
value

	^transfer value.! !


!TransferDepositEnd methodsFor: 'transactions report' stamp: 'MF 10/23/2021 17:00:25'!
reportTo: aReport

	aReport reportATransferDepositEnd: self.! !


!TransferDepositEnd methodsFor: 'accessing' stamp: 'MF 10/18/2021 20:53:36'!
otherEnd

	^transfer withdrawEnd.! !


!classDefinition: #TransferWithdrawEnd category: 'Portfolio-Solucion'!
TransferEnd subclass: #TransferWithdrawEnd
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdrawEnd methodsFor: 'balance' stamp: 'MF 10/20/2021 22:05:07'!
affectBalance: aBalance

	^aBalance - self value.! !


!TransferWithdrawEnd methodsFor: 'value' stamp: 'MF 10/20/2021 22:05:17'!
value

	^transfer value.! !


!TransferWithdrawEnd methodsFor: 'transactions report' stamp: 'MF 10/23/2021 17:00:41'!
reportTo: aReport

	aReport reportATransferWithdrawEnd: self.! !


!TransferWithdrawEnd methodsFor: 'accessing' stamp: 'MF 10/18/2021 20:53:36'!
otherEnd

	^transfer depositEnd.! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'transactions report' stamp: 'MF 10/23/2021 17:00:48'!
reportTo: aReport

	aReport reportAWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'MF 10/18/2021 21:43:21'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #AccountTransactionsReport category: 'Portfolio-Solucion'!
Object subclass: #AccountTransactionsReport
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransactionsReport methodsFor: 'transactions report' stamp: 'MF 10/23/2021 17:13:53'!
reportADeposit: aDeposit

	self subclassResponsibility! !

!AccountTransactionsReport methodsFor: 'transactions report' stamp: 'MF 10/23/2021 17:13:57'!
reportATransferDepositEnd: aTransferDepositEnd

	self subclassResponsibility! !

!AccountTransactionsReport methodsFor: 'transactions report' stamp: 'MF 10/23/2021 17:14:01'!
reportATransferWithdrawEnd: aTransferWithdrawEnd

	self subclassResponsibility! !

!AccountTransactionsReport methodsFor: 'transactions report' stamp: 'MF 10/23/2021 17:14:04'!
reportAWithdraw: aWithdraw

	self subclassResponsibility! !


!AccountTransactionsReport methodsFor: 'initialization' stamp: 'MF 10/23/2021 17:14:27'!
initializeFor: anAccount

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransactionsReport class' category: 'Portfolio-Solucion'!
AccountTransactionsReport class
	instanceVariableNames: ''!

!AccountTransactionsReport class methodsFor: 'instance creation' stamp: 'MF 10/21/2021 21:41:12'!
for: anAccount

	^self new initializeFor: anAccount.! !


!classDefinition: #AccountSummaryPrinter category: 'Portfolio-Solucion'!
AccountTransactionsReport subclass: #AccountSummaryPrinter
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryPrinter methodsFor: 'initialization' stamp: 'MF 10/21/2021 21:10:04'!
initializeFor: anAccount

	account _ anAccount.
	lines _ OrderedCollection new.! !


!AccountSummaryPrinter methodsFor: 'printing' stamp: 'LNB 10/23/2021 20:05:48'!
getReport

	lines _ OrderedCollection new.
	
	account getReportForTransactions: self.
	
	self addBalanceLine.
	^lines.! !


!AccountSummaryPrinter methodsFor: 'transactions report' stamp: 'MF 10/21/2021 21:36:23'!
reportADeposit: aDeposit

	lines add: 'Depósito por ', aDeposit value asString, '.'.! !

!AccountSummaryPrinter methodsFor: 'transactions report' stamp: 'MF 10/21/2021 21:36:28'!
reportATransferDepositEnd: aTransferDepositEnd

	lines add: 'Entrada por transferencia de ', aTransferDepositEnd value asString, '.' ! !

!AccountSummaryPrinter methodsFor: 'transactions report' stamp: 'MF 10/21/2021 21:37:01'!
reportATransferWithdrawEnd: aTransferWithdrawEnd

	lines add: 'Salida por transferencia de ', aTransferWithdrawEnd value asString, '.'! !

!AccountSummaryPrinter methodsFor: 'transactions report' stamp: 'MF 10/21/2021 21:37:04'!
reportAWithdraw: aWithdraw

	lines add: 'Extracción por ', aWithdraw value asString, '.'! !


!AccountSummaryPrinter methodsFor: 'private - printing' stamp: 'MF 10/23/2021 17:01:59'!
addBalanceLine

	lines add: 'Balance = ', account balance asString! !


!classDefinition: #TransferNetCalculator category: 'Portfolio-Solucion'!
AccountTransactionsReport subclass: #TransferNetCalculator
	instanceVariableNames: 'netValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetCalculator methodsFor: 'initialization' stamp: 'MF 10/21/2021 21:18:14'!
initializeFor: anAccount

	account _ anAccount.
	netValue _ 0.
	! !


!TransferNetCalculator methodsFor: 'transactions report' stamp: 'MF 10/21/2021 21:37:40'!
reportADeposit: aDeposit

	netValue _ netValue.! !

!TransferNetCalculator methodsFor: 'transactions report' stamp: 'MF 10/21/2021 21:37:52'!
reportATransferDepositEnd: aTransferDepositEnd

	netValue _ netValue + aTransferDepositEnd value.! !

!TransferNetCalculator methodsFor: 'transactions report' stamp: 'MF 10/21/2021 21:38:00'!
reportATransferWithdrawEnd: aTransferWithdrawEnd

	netValue _ netValue - aTransferWithdrawEnd value.! !

!TransferNetCalculator methodsFor: 'transactions report' stamp: 'MF 10/21/2021 21:38:09'!
reportAWithdraw: aWithdraw

	netValue _ netValue.! !


!TransferNetCalculator methodsFor: 'net calculating' stamp: 'LNB 10/23/2021 20:12:59'!
transferNet

	netValue _ 0.
	
	account getReportForTransactions: self.
	
	^netValue! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'depositEnd withdrawEnd value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'MF 10/18/2021 20:53:07'!
initializeRegister: aValue from: anOriginAccount to: aDestinationAccount.

	value _ aValue.
	depositEnd _ TransferDepositEnd registerTransfer: self to: aDestinationAccount.
	withdrawEnd _ TransferWithdrawEnd registerTransfer: self to: anOriginAccount.! !


!Transfer methodsFor: 'accessing' stamp: 'MF 10/18/2021 20:53:07'!
depositEnd

	^depositEnd .! !

!Transfer methodsFor: 'accessing' stamp: 'MF 10/18/2021 20:49:14'!
value

	^value! !

!Transfer methodsFor: 'accessing' stamp: 'MF 10/18/2021 20:52:50'!
withdrawEnd

	^withdrawEnd.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'MF 10/18/2021 21:36:43'!
register: aValue from: anOriginAccount to: aDestinationAccount 
	
	aValue <= 0 ifTrue: [ self error: self cannotTransferLessThanOrEqualToZeroErrorDescription ].
	anOriginAccount = aDestinationAccount ifTrue: [ self error: self cannotTransferToItselfErrorDescription ].
	
	^self new initializeRegister: aValue from: anOriginAccount to: aDestinationAccount.! !



!Transfer class methodsFor: 'error descriptions' stamp: 'MF 10/18/2021 21:34:51'!
cannotTransferLessThanOrEqualToZeroErrorDescription 

	^'Transfer amount must be greater than 0!!'! !

!Transfer class methodsFor: 'error descriptions' stamp: 'MF 10/18/2021 21:36:17'!
cannotTransferToItselfErrorDescription

	^'Cannot transfer to same account'! !
