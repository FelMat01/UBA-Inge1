!classDefinition: #TusLibrosClientWindow category: 'TusLibros-Views'!
SystemWindow subclass: #TusLibrosClientWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Views'!


!classDefinition: #TusLibrosClientCatalogAndCartContentsWindow category: 'TusLibros-Views'!
TusLibrosClientWindow subclass: #TusLibrosClientCatalogAndCartContentsWindow
	instanceVariableNames: 'cartContentsPluggableList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Views'!

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'window building' stamp: 'LNB 11/27/2021 16:48:08'!
build1stColumn

	| firstColumnLayoutMorph |
	
	firstColumnLayoutMorph _ LayoutMorph newColumn.
	firstColumnLayoutMorph axisEdgeWeight: 0.5;
	separation: 50;
	addMorph: (LabelMorph contents: 'Catalogue');
	addMorph: ((PluggableListMorph model: self model listGetter: #catalogueProducts indexGetter: #catalogueListIndex indexSetter: #catalogueListIndex:) borderWidth: 1; borderColor: Color black) layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1).
	"firstRowLayoutMorph borderColor: Color skyBlue; borderWidth: 1; morphWidth:300."
	
	^firstColumnLayoutMorph.! !

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'window building' stamp: 'LNB 11/27/2021 16:47:43'!
build2ndColumn

	| secondColumnLayoutMorph quantityToTransferTextBoxMorph |
	
	quantityToTransferTextBoxMorph _ 
		(TextModelMorph
			textProvider: self model
			textGetter: #quantityToTransfer
			textSetter: #quantityToTransfer:).
			
	quantityToTransferTextBoxMorph innerTextMorph 
							setProperty: #keyStroke: 
							toValue: [ :key | quantityToTransferTextBoxMorph innerTextMorph acceptContents ].	
	
	quantityToTransferTextBoxMorph borderWidth: 1; borderColor: Color black.
	
	secondColumnLayoutMorph _ LayoutMorph newColumn.
	secondColumnLayoutMorph axisEdgeWeight: 0.5;
	separation: 50;
	addMorph: (LabelMorph contents: 'Quantity to transfer:');
	addMorph: quantityToTransferTextBoxMorph layoutSpec: (LayoutSpec fixedWidth: 200 fixedHeight: 25);
								
	addMorph: (PluggableButtonMorph model: self model stateGetter: nil action: #addToCart label: 'Add') layoutSpec: (LayoutSpec fixedWidth: 200 fixedHeight: 50);
	addMorph: (PluggableButtonMorph model: self model stateGetter: nil action: #removeFromCart label: 'Remove') layoutSpec: (LayoutSpec fixedWidth: 200 fixedHeight: 50);
	addMorph: (PluggableButtonMorph model: self model stateGetter: nil action: #checkoutCart label: 'Checkout Cart') layoutSpec: (LayoutSpec fixedWidth: 200 fixedHeight: 50).
	
	^secondColumnLayoutMorph.
	
	
	
	! !

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'window building' stamp: 'LNB 11/27/2021 18:10:34'!
build3rdColumn

	| thirdColumnLayoutMorph |
	
	cartContentsPluggableList _ ((PluggableListMorph model: self model listGetter: #cartContents indexGetter: #cartContentsIndex indexSetter: #cartContentsIndex:) borderWidth: 1; borderColor: Color black) layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1).
	
	thirdColumnLayoutMorph _ LayoutMorph newColumn.
	thirdColumnLayoutMorph axisEdgeWeight: 0.5;
	separation: 50;
	addMorph: (LabelMorph contents: 'Cart');
	addMorph: cartContentsPluggableList.
	
	^thirdColumnLayoutMorph.! !

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'window building' stamp: 'LNB 11/27/2021 16:42:22'!
buildMorphicWindow

	self layoutMorph beRow;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: self build1stColumn layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1);
	addMorph: self build2ndColumn layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1);
	addMorph: self build3rdColumn layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1).
	
	" estaria bueno que la responsabilidad de hacer el layoutSpec la tenga el morph que va a cambiar
	su layout spec"! !


!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'initialization' stamp: 'LNB 11/27/2021 14:57:52'!
defaultExtent

	^ 1280@720
! !

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'initialization' stamp: 'LNB 11/28/2021 00:32:43'!
initializeNamed: aTitle modeledBy: aModel

	self setLabel: aTitle.
	self model: aModel.
	
	self buildMorphicWindow.
	
	self model when: #cartContentsModified send: #updateCartContents to: self.
	self model when: #checkoutCartSuccess send: #displaySaleTicketWindow to: self.
	self model when: #checkoutCouldNotBePerformed send: #displayCheckoutError to: self.
	self model when: #triedToRemoveTooManyItems send: #displayRemoveError to: self.
	self model when: #mustInputAValidQuantity send: #displayInvalidQuantityError to: self.
	
	self openInWorld.
	self morphExtent: (self defaultExtent).! !


!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'error description' stamp: 'LNB 11/28/2021 00:24:54'!
checkoutErrorDescription

	^'Could not perform checkout'.! !

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'error description' stamp: 'LNB 11/28/2021 00:33:31'!
invalidQuantityErrorDescription

	^'Quantity must be a valid number.'! !

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'error description' stamp: 'LNB 11/28/2021 00:28:31'!
removeErrorDescription

	^'Tried to remove more items than currently found in cart'! !


!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'open new windows' stamp: 'LNB 11/28/2021 00:24:02'!
displayCheckoutError
	
	TusLibrosClientErrorWindow openWithErrorMessage: self checkoutErrorDescription.! !

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'open new windows' stamp: 'LNB 11/28/2021 00:33:09'!
displayInvalidQuantityError

	TusLibrosClientErrorWindow openWithErrorMessage: self invalidQuantityErrorDescription.! !

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'open new windows' stamp: 'LNB 11/28/2021 00:28:09'!
displayRemoveError
	
	TusLibrosClientErrorWindow openWithErrorMessage: self removeErrorDescription.! !

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'open new windows' stamp: 'LNB 11/27/2021 22:40:05'!
displaySaleTicketWindow

	TusLibrosClientTicketDisplayWindow openWithModel: self model.
	self delete.! !


!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'access' stamp: 'LNB 11/27/2021 18:10:52'!
updateCartContents
	
	cartContentsPluggableList updateList.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientCatalogAndCartContentsWindow class' category: 'TusLibros-Views'!
TusLibrosClientCatalogAndCartContentsWindow class
	instanceVariableNames: ''!

!TusLibrosClientCatalogAndCartContentsWindow class methodsFor: 'instance creation' stamp: 'LNB 11/27/2021 15:06:36'!
openWithModel: aModel

	^self new initializeNamed: 'TusLibros - Client Window' modeledBy: aModel.! !


!classDefinition: #TusLibrosClientErrorWindow category: 'TusLibros-Views'!
TusLibrosClientWindow subclass: #TusLibrosClientErrorWindow
	instanceVariableNames: 'errorDescription'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Views'!

!TusLibrosClientErrorWindow methodsFor: 'initialization' stamp: 'LNB 11/28/2021 00:14:38'!
defaultExtent

	^ 250@100.! !

!TusLibrosClientErrorWindow methodsFor: 'initialization' stamp: 'LNB 11/28/2021 17:05:18'!
initializeNamed: aTitle withMessageText: anErrorDescription

	self setLabel: aTitle.
	errorDescription _ anErrorDescription.
	self buildMorphicWindow.
	
	self model when: #cartCreationSuccesful send: #displayCatalogAndCartContents to: self.
	self model when: #succesfullyLoggedOut send: #logOut to: self.
	self model when: #purchaseHistoryArrived send: #createNewWindowForPurchaseHistory to: self.
	
	self openInWorld.
	Beeper beepPrimitive.
	self morphExtent: (self defaultExtent).
	self layoutMorph color: Color red.! !


!TusLibrosClientErrorWindow methodsFor: 'window building' stamp: 'LNB 11/28/2021 00:15:37'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 50;
	axisEdgeWeight: 0;
	addMorph: (LabelMorph contents: errorDescription) layoutSpec: (LayoutSpec fixedWidth: 1 fixedHeight: 1).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientErrorWindow class' category: 'TusLibros-Views'!
TusLibrosClientErrorWindow class
	instanceVariableNames: ''!

!TusLibrosClientErrorWindow class methodsFor: 'instance creation' stamp: 'LNB 11/28/2021 00:02:20'!
openWithErrorMessage: anErrorDescription

	^self new initializeNamed: 'TusLibros - Error' withMessageText: anErrorDescription.! !


!classDefinition: #TusLibrosClientMainWindow category: 'TusLibros-Views'!
TusLibrosClientWindow subclass: #TusLibrosClientMainWindow
	instanceVariableNames: 'usernameTextBoxMorph passwordTextBoxMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Views'!

!TusLibrosClientMainWindow methodsFor: 'window building' stamp: 'MF 11/18/2021 18:18:09'!
build1stRow

	| firstRowLayoutMorph |
	
	self buildUsernameTextMorph.
	self buildPasswordTextMorph.
	
	firstRowLayoutMorph _ LayoutMorph newRow.
	firstRowLayoutMorph axisEdgeWeight: 0.5;
	separation: 50;
	addMorph: (self buildLabeledTextMorphWith: usernameTextBoxMorph labeledBy: 'Username');
	addMorph: (self buildLabeledTextMorphWith: passwordTextBoxMorph labeledBy: 'Password').
	
	^firstRowLayoutMorph.
	! !

!TusLibrosClientMainWindow methodsFor: 'window building' stamp: 'MF 11/18/2021 18:20:20'!
build2ndRow

	^PluggableButtonMorph model: self model stateGetter: nil action: #createCart label: 'Create Cart'
	
	! !

!TusLibrosClientMainWindow methodsFor: 'window building' stamp: 'MF 11/18/2021 18:05:57'!
buildLabeledTextMorphWith: aTextMorph labeledBy: aLabelText

	| columnLayoutMorph |
	columnLayoutMorph _ LayoutMorph newColumn.
	columnLayoutMorph separation: 5;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: aLabelText);
	addMorph: aTextMorph.
	
	columnLayoutMorph layoutSpec fixedWidth: 390.
	
	^columnLayoutMorph.
	! !

!TusLibrosClientMainWindow methodsFor: 'window building' stamp: 'LNB 11/27/2021 15:17:49'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: self build1stRow layoutSpec: (LayoutSpec proportionalWidth: 1 fixedHeight: 1);
	addMorph: self build2ndRow layoutSpec: (LayoutSpec fixedWidth: 200 fixedHeight: 50).
	
	" estaria bueno que la responsabilidad de hacer el layoutSpec la tenga el morph que va a cambiar
	su layout spec"! !

!TusLibrosClientMainWindow methodsFor: 'window building' stamp: 'MF 11/18/2021 18:01:44'!
buildPasswordTextMorph

	passwordTextBoxMorph _ TextModelMorph
								textProvider: self model
								textGetter: #password
								textSetter: #password:.
	passwordTextBoxMorph innerTextMorph 
							setProperty: #keyStroke: 
							toValue: [ :key | passwordTextBoxMorph innerTextMorph acceptContents ].				
	passwordTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300; morphHeight: 1. 
! !

!TusLibrosClientMainWindow methodsFor: 'window building' stamp: 'MF 11/18/2021 18:01:19'!
buildUsernameTextMorph

	usernameTextBoxMorph _ TextModelMorph 
								textProvider: self model 
								textGetter: #username 
								textSetter: #username:.
	usernameTextBoxMorph innerTextMorph 
							setProperty: #keyStroke: 
							toValue: [ :key | usernameTextBoxMorph innerTextMorph acceptContents ].				
	usernameTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300; morphHeight: 1. ! !


!TusLibrosClientMainWindow methodsFor: 'open new window' stamp: 'LNB 11/27/2021 22:56:44'!
displayCatalogAndCartContents

	TusLibrosClientCatalogAndCartContentsWindow openWithModel: self model.
	self delete.! !

!TusLibrosClientMainWindow methodsFor: 'open new window' stamp: 'LNB 11/28/2021 00:00:13'!
displayWrongUsernameOrPasswordError

	TusLibrosClientErrorWindow openWithErrorMessage: self wrongUsernameOrPasswordErrorDescription.! !


!TusLibrosClientMainWindow methodsFor: 'initialization' stamp: 'MF 11/15/2021 21:38:33'!
defaultExtent

	^ 1280@720
! !

!TusLibrosClientMainWindow methodsFor: 'initialization' stamp: 'LNB 11/28/2021 00:17:14'!
initializeWith: aTitle

	self setLabel: aTitle.
	self model: (TusLibrosLoginWindowModel new).
	
	self buildMorphicWindow.
	
	self model when: #cartCreationSuccesful send: #displayCatalogAndCartContents to: self.
	self model when: #wrongUsernameOrPassword send: #displayWrongUsernameOrPasswordError to: self.
	
	self openInWorld.
	self morphExtent: (self defaultExtent).! !


!TusLibrosClientMainWindow methodsFor: 'error description' stamp: 'LNB 11/27/2021 23:59:19'!
wrongUsernameOrPasswordErrorDescription

	^'Username or password is incorrect.'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientMainWindow class' category: 'TusLibros-Views'!
TusLibrosClientMainWindow class
	instanceVariableNames: ''!

!TusLibrosClientMainWindow class methodsFor: 'instance creation' stamp: 'MF 11/15/2021 21:19:45'!
open

	^self new initializeWith: 'TusLibros - Client Window'! !


!classDefinition: #TusLibrosClientPurchaseHistoryWindow category: 'TusLibros-Views'!
TusLibrosClientWindow subclass: #TusLibrosClientPurchaseHistoryWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Views'!

!TusLibrosClientPurchaseHistoryWindow methodsFor: 'window building' stamp: 'LNB 11/27/2021 23:44:29'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 50;
	axisEdgeWeight: 0;
	addMorph: (LabelMorph contents: 'Purchase History:') layoutSpec: (LayoutSpec fixedWidth: 1 fixedHeight: 1);
	
	addMorph: ((PluggableListMorph model: self model listGetter: #purchaseHistoryDisplay indexGetter: #purchaseHistoryIndex indexSetter: #purchaseHistoryIndex:) borderWidth: 1; borderColor: Color black) layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1);
	
	addMorph: (LabelMorph contents: 'Total: $' , model purchaseHistoryTotal asString) layoutSpec: (LayoutSpec proportionalWidth: 1 fixedHeight: 1).! !


!TusLibrosClientPurchaseHistoryWindow methodsFor: 'initialization' stamp: 'LNB 11/27/2021 23:26:44'!
defaultExtent

	^ 1280@720
! !

!TusLibrosClientPurchaseHistoryWindow methodsFor: 'initialization' stamp: 'LNB 11/28/2021 00:39:00'!
initializeNamed: aTitle modeledBy: aModel

	self setLabel: aTitle.
	self model: aModel.
	
	self buildMorphicWindow.
	
	self openInWorld.
	self morphExtent: (self defaultExtent).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientPurchaseHistoryWindow class' category: 'TusLibros-Views'!
TusLibrosClientPurchaseHistoryWindow class
	instanceVariableNames: ''!

!TusLibrosClientPurchaseHistoryWindow class methodsFor: 'instance creation' stamp: 'LNB 11/27/2021 23:26:45'!
openWithModel: aModel

	^self new initializeNamed: 'TusLibros - Client Window' modeledBy: aModel.! !


!classDefinition: #TusLibrosClientTicketDisplayWindow category: 'TusLibros-Views'!
TusLibrosClientWindow subclass: #TusLibrosClientTicketDisplayWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Views'!

!TusLibrosClientTicketDisplayWindow methodsFor: 'window building' stamp: 'LNB 11/27/2021 23:16:15'!
buildButtonsRow

	| thirdColumnLayoutMorph createNewCartButton logOutButton listPurchasesButton |
	
	logOutButton _ ((PluggableButtonMorph model: self model stateGetter: nil action: #logOut label: 'Log out') borderWidth: 1; borderColor: Color black) layoutSpec: (LayoutSpec fixedWidth: 200 fixedHeight: 50).
	
	createNewCartButton _ ((PluggableButtonMorph model: self model stateGetter: nil action: #createCart label: 'Create New Cart') borderWidth: 1; borderColor: Color black) layoutSpec: (LayoutSpec fixedWidth: 200 fixedHeight: 50).
	
	listPurchasesButton _ ((PluggableButtonMorph model: self model stateGetter: nil action: #listPurchases label: 'List Purchases') borderWidth: 1; borderColor: Color black) layoutSpec: (LayoutSpec fixedWidth: 200 fixedHeight: 50).
	
	thirdColumnLayoutMorph _ LayoutMorph newRow.
	thirdColumnLayoutMorph axisEdgeWeight: 0.5;
	separation: 50;
	addMorph: logOutButton;
	addMorph: createNewCartButton;
	addMorph: listPurchasesButton.
	
	^thirdColumnLayoutMorph.! !

!TusLibrosClientTicketDisplayWindow methodsFor: 'window building' stamp: 'LNB 11/27/2021 22:47:16'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 50;
	axisEdgeWeight: 0;
	addMorph: (LabelMorph contents: 'Ticket:') layoutSpec: (LayoutSpec fixedWidth: 1 fixedHeight: 1);
	
	addMorph: ((PluggableListMorph model: self model listGetter: #lastTicketDisplay indexGetter: #ticketIndex indexSetter: #ticketIndex:) borderWidth: 1; borderColor: Color black) layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1);
	
	addMorph: (LabelMorph contents: 'Total: $' , model lastTicketTotal) layoutSpec: (LayoutSpec proportionalWidth: 1 fixedHeight: 1);
	
	addMorph: self buildButtonsRow layoutSpec: (LayoutSpec fixedWidth: 1 fixedHeight: 1).
	
	" estaria bueno que la responsabilidad de hacer el layoutSpec la tenga el morph que va a cambiar
	su layout spec"! !


!TusLibrosClientTicketDisplayWindow methodsFor: 'open new window' stamp: 'LNB 11/27/2021 23:43:15'!
createNewWindowForPurchaseHistory
	
	TusLibrosClientPurchaseHistoryWindow openWithModel: self model.! !

!TusLibrosClientTicketDisplayWindow methodsFor: 'open new window' stamp: 'LNB 11/27/2021 22:56:58'!
displayCatalogAndCartContents

	TusLibrosClientCatalogAndCartContentsWindow openWithModel: self model.
	self delete.! !

!TusLibrosClientTicketDisplayWindow methodsFor: 'open new window' stamp: 'LNB 11/27/2021 23:04:05'!
logOut

	TusLibrosClientMainWindow open.
	self delete.! !


!TusLibrosClientTicketDisplayWindow methodsFor: 'initialization' stamp: 'LNB 11/27/2021 22:23:54'!
defaultExtent

	^ 1280@720
! !

!TusLibrosClientTicketDisplayWindow methodsFor: 'initialization' stamp: 'LNB 11/28/2021 00:17:57'!
initializeNamed: aTitle modeledBy: aModel

	self setLabel: aTitle.
	self model: aModel.
	
	self buildMorphicWindow.
	
	self model when: #cartCreationSuccesful send: #displayCatalogAndCartContents to: self.
	self model when: #succesfullyLoggedOut send: #logOut to: self.
	self model when: #purchaseHistoryArrived send: #createNewWindowForPurchaseHistory to: self.
	
	self openInWorld.
	self morphExtent: (self defaultExtent).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientTicketDisplayWindow class' category: 'TusLibros-Views'!
TusLibrosClientTicketDisplayWindow class
	instanceVariableNames: ''!

!TusLibrosClientTicketDisplayWindow class methodsFor: 'instance creation' stamp: 'LNB 11/27/2021 22:23:54'!
openWithModel: aModel

	^self new initializeNamed: 'TusLibros - Client Window' modeledBy: aModel.! !


!classDefinition: #TusLibrosClientInterface category: 'TusLibros-Views'!
Object subclass: #TusLibrosClientInterface
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Views'!

!TusLibrosClientInterface methodsFor: 'sending requests' stamp: 'LNB 11/27/2021 17:48:13'!
addToCartRequest: aCartId for: aBookISBN of: anAmount

	| fieldDict resp |
	fieldDict _ Dictionary newFromPairs: { 'cartId'. aCartId. 'bookISBN'. aBookISBN. 'bookQuantity'. anAmount }.
	
	resp _ WebClient htmlSubmit: (self url, '/addToCart') fields: fieldDict method: 'POST'.
	
	resp isSuccess 
        		ifFalse:[^self error: resp content].! !

!TusLibrosClientInterface methodsFor: 'sending requests' stamp: 'LNB 11/27/2021 19:28:24'!
checkoutCartRequestFor: aCartId withCCN: aCCN withCCME: aCCME withCCYE: aCCYE withCCO: aCCO

	| fieldDict resp |
	fieldDict _ Dictionary newFromPairs: { 'cartId'. aCartId. 'ccn'. aCCN. 'ccme'. aCCME. 'ccye'. aCCYE. 'cco'. aCCO. }.
	
	resp _ WebClient htmlSubmit: (self url, '/checkoutCart') fields: fieldDict method: 'POST'.
	
	resp isSuccess 
		ifTrue:[^WebUtils jsonDecode: ((resp content) readStream).] 
        		ifFalse:[^self error: resp content].! !

!TusLibrosClientInterface methodsFor: 'sending requests' stamp: 'LNB 11/28/2021 19:41:09'!
createCartRequestFor: aUsername with: aPassword

	" un username no deberia tener espacios, todo: chequear que eso no suceda"
	| fieldDict resp |
	fieldDict _ Dictionary newFromPairs: { 'clientId'. aUsername. 'password'. aPassword }.
	
	resp _ WebClient htmlSubmit: (self url, '/createCart') fields: fieldDict method: 'POST'.
	
	resp isSuccess 
        		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
        		ifFalse:[^self error: resp content].! !

!TusLibrosClientInterface methodsFor: 'sending requests' stamp: 'LNB 11/28/2021 13:27:10'!
listCartRequestFor: aCartId

	| fieldDict resp |
	fieldDict _ Dictionary newFromPairs: { 'cartId'. aCartId }.
	
	resp _ WebClient htmlSubmit: (self url, '/listCart') fields: fieldDict method: 'GET'.
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).]
        		ifFalse:[^self error: resp content].! !

!TusLibrosClientInterface methodsFor: 'sending requests' stamp: 'LNB 11/27/2021 17:20:41'!
listCatalog

	| resp |
	
	resp _ WebClient httpGet: (self url, '/listCatalog').
	
	resp isSuccess 
        		ifTrue:[^WebUtils jsonDecode: ((resp content) readStream).] 
        		ifFalse:[^self error: resp content].! !

!TusLibrosClientInterface methodsFor: 'sending requests' stamp: 'LNB 11/28/2021 13:27:31'!
listPurchasesRequestFor: aUsername authenticatingWith: aPassword

	" un username no deberia tener espacios, todo: chequear que eso no suceda"
	| fieldDict resp |
	fieldDict _ Dictionary newFromPairs: { 'clientId'. aUsername. 'password'. aPassword }.
	
	resp _ WebClient htmlSubmit: (self url, '/listPurchases') fields: fieldDict method: 'GET'.
	
	resp isSuccess 
        		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
        		ifFalse:[^self error: resp content].! !

!TusLibrosClientInterface methodsFor: 'sending requests' stamp: 'LNB 11/27/2021 18:24:42'!
removeFromCartRequest: aCartId for: aBookISBN of: anAmount

	| fieldDict resp |
	fieldDict _ Dictionary newFromPairs: { 'cartId'. aCartId. 'bookISBN'. aBookISBN. 'bookQuantity'. anAmount }.
	
	resp _ WebClient htmlSubmit: (self url, '/removeFromCart') fields: fieldDict method: 'POST'.
	
	resp isSuccess 
        		ifFalse:[^self error: resp content].! !


!TusLibrosClientInterface methodsFor: 'initialization' stamp: 'MF 11/15/2021 21:14:54'!
port
	
	^port ifNil: [port:=8080].! !

!TusLibrosClientInterface methodsFor: 'initialization' stamp: 'MF 11/15/2021 21:14:48'!
url
	
	^'http://localhost:', self port asString! !


!classDefinition: #TusLibrosLoginWindowModel category: 'TusLibros-Views'!
Object subclass: #TusLibrosLoginWindowModel
	instanceVariableNames: 'username password restInterface cartId catalogueSelectionIndex cartSelectionIndex quantityToTransferTextBoxContents ticket ccn ccme ccye ticketSelectedIndex lastPurchaseHistoryRequest purchaseHistorySelectionIndex'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Views'!

!TusLibrosLoginWindowModel methodsFor: 'initialization' stamp: 'LNB 11/28/2021 00:31:52'!
initialize

	username _ ''.
	password _ ''.
	restInterface _ TusLibrosClientInterface new.
	
	catalogueSelectionIndex _ 1.
	cartSelectionIndex _ 1.
	
	quantityToTransferTextBoxContents _ '1'.
	
	ticketSelectedIndex _ 0.
	
	purchaseHistorySelectionIndex _ 0.
	
	"Cargamos un archivo encriptado con la tarjeta de credito del usuario"
	
	ccn _ '1234567890123456'.
	ccme _ GregorianMonth current number asString.
	ccye _ GregorianYear current number asString.! !


!TusLibrosLoginWindowModel methodsFor: 'login window selectors' stamp: 'LNB 11/28/2021 00:13:15'!
createCart

	[cartId _ restInterface createCartRequestFor: username with: password.
	self triggerEvent: #cartCreationSuccesful.] 
		on: Error - MessageNotUnderstood
		do: [:anError | self triggerEvent: #wrongUsernameOrPassword.].
	
	! !

!TusLibrosLoginWindowModel methodsFor: 'login window selectors' stamp: 'MF 11/18/2021 17:46:36'!
password

	^password.! !

!TusLibrosLoginWindowModel methodsFor: 'login window selectors' stamp: 'MF 11/18/2021 18:17:30'!
password: aPassword

	password _ aPassword.
	^true.! !

!TusLibrosLoginWindowModel methodsFor: 'login window selectors' stamp: 'MF 11/18/2021 17:46:11'!
username

	^username! !

!TusLibrosLoginWindowModel methodsFor: 'login window selectors' stamp: 'MF 11/18/2021 18:17:35'!
username: aUsername

	username _ aUsername.
	^true.! !


!TusLibrosLoginWindowModel methodsFor: 'checkout window selectors' stamp: 'LNB 11/28/2021 00:31:02'!
addToCart

	| bookISBN |
	[bookISBN _ (restInterface listCatalog keys at: catalogueSelectionIndex).

	restInterface addToCartRequest: cartId for: bookISBN of: quantityToTransferTextBoxContents asNumber.
	
	self triggerEvent: #cartContentsModified.]
		on: Error - MessageNotUnderstood
		do: [:anError | self triggerEvent: #mustInputAValidQuantity.].! !

!TusLibrosLoginWindowModel methodsFor: 'checkout window selectors' stamp: 'LNB 11/27/2021 18:19:01'!
cartContents

	| cartContents |
	cartContents _ restInterface listCartRequestFor:cartId.
	
	^cartContents keys collect:[:aBookISBN | aBookISBN , ' | ' , ((cartContents at: aBookISBN) asString)].
	! !

!TusLibrosLoginWindowModel methodsFor: 'checkout window selectors' stamp: 'LNB 11/27/2021 16:09:56'!
cartContentsIndex

	^cartSelectionIndex.! !

!TusLibrosLoginWindowModel methodsFor: 'checkout window selectors' stamp: 'LNB 11/27/2021 16:10:22'!
cartContentsIndex: aNewIndex

	cartSelectionIndex _ aNewIndex.
	^true.! !

!TusLibrosLoginWindowModel methodsFor: 'checkout window selectors' stamp: 'LNB 11/27/2021 16:04:27'!
catalogueListIndex

	^catalogueSelectionIndex.! !

!TusLibrosLoginWindowModel methodsFor: 'checkout window selectors' stamp: 'LNB 11/27/2021 17:29:14'!
catalogueListIndex: aNewIndex

	catalogueSelectionIndex _ aNewIndex.
	^true.! !

!TusLibrosLoginWindowModel methodsFor: 'checkout window selectors' stamp: 'LNB 11/27/2021 17:27:56'!
catalogueProducts

	| catalog |
	catalog _ restInterface listCatalog.
	
	^catalog keys collect:[:aBookISBN | aBookISBN , ' | $' , ((catalog at: aBookISBN) asString)].! !

!TusLibrosLoginWindowModel methodsFor: 'checkout window selectors' stamp: 'LNB 11/28/2021 00:23:16'!
checkoutCart

	[ticket _ restInterface checkoutCartRequestFor: cartId withCCN: ccn withCCME: ccme withCCYE: ccye withCCO: 'admin'.
	self triggerEvent: #checkoutCartSuccess.]
		on: Error - MessageNotUnderstood
		do: [:anError | self triggerEvent: #checkoutCouldNotBePerformed.].! !

!TusLibrosLoginWindowModel methodsFor: 'checkout window selectors' stamp: 'LNB 11/27/2021 16:23:45'!
quantityToTransfer

	^quantityToTransferTextBoxContents.! !

!TusLibrosLoginWindowModel methodsFor: 'checkout window selectors' stamp: 'LNB 11/27/2021 16:32:34'!
quantityToTransfer: transferableQuantityString

	quantityToTransferTextBoxContents _ transferableQuantityString.
	^true.! !

!TusLibrosLoginWindowModel methodsFor: 'checkout window selectors' stamp: 'LNB 11/28/2021 00:27:28'!
removeFromCart

	| bookISBN |
	[bookISBN _ (restInterface listCatalog keys at: catalogueSelectionIndex).

	restInterface removeFromCartRequest: cartId for: bookISBN of: quantityToTransferTextBoxContents asNumber.
	
	self triggerEvent: #cartContentsModified.]
		on: Error - MessageNotUnderstood
		do: [:anError | self triggerEvent: #triedToRemoveTooManyItems.].! !


!TusLibrosLoginWindowModel methodsFor: 'ticket window selectors' stamp: 'LNB 11/27/2021 22:41:50'!
lastTicketDisplay

	| ticketForDisplay |
	ticketForDisplay _ ticket copy.
	ticketForDisplay removeKey: 'total'.
	
	^ticketForDisplay keys collect:[:aBookISBN | aBookISBN , ' | $' , ((ticketForDisplay at: aBookISBN) asString)].! !

!TusLibrosLoginWindowModel methodsFor: 'ticket window selectors' stamp: 'LNB 11/27/2021 22:43:45'!
lastTicketTotal
	
	^(ticket at: 'total') asString.! !

!TusLibrosLoginWindowModel methodsFor: 'ticket window selectors' stamp: 'LNB 11/27/2021 23:19:38'!
listPurchases

	lastPurchaseHistoryRequest _ restInterface listPurchasesRequestFor: username authenticatingWith: password.
	
	self triggerEvent: #purchaseHistoryArrived.! !

!TusLibrosLoginWindowModel methodsFor: 'ticket window selectors' stamp: 'LNB 11/27/2021 23:04:03'!
logOut

	self triggerEvent: #succesfullyLoggedOut.! !

!TusLibrosLoginWindowModel methodsFor: 'ticket window selectors' stamp: 'LNB 11/27/2021 22:38:37'!
ticketIndex

	^ticketSelectedIndex.! !

!TusLibrosLoginWindowModel methodsFor: 'ticket window selectors' stamp: 'LNB 11/27/2021 22:39:13'!
ticketIndex: aSelectionIndex

	ticketSelectedIndex _ aSelectionIndex.
	^true.! !


!TusLibrosLoginWindowModel methodsFor: 'purchase history window selectors' stamp: 'LNB 11/27/2021 23:40:22'!
purchaseHistoryDisplay

	| purchaseHistoryForDisplay |
	purchaseHistoryForDisplay _ lastPurchaseHistoryRequest copy.
	purchaseHistoryForDisplay removeKey: 'total'.
	
	^purchaseHistoryForDisplay keys collect:[:aBookISBN | aBookISBN , 
		' | qty ' , (((purchaseHistoryForDisplay at: aBookISBN) at: 'quantity') asString),
		' | $' , (((purchaseHistoryForDisplay at: aBookISBN) at: 'total') asString)].
	! !

!TusLibrosLoginWindowModel methodsFor: 'purchase history window selectors' stamp: 'LNB 11/27/2021 23:34:07'!
purchaseHistoryIndex

	^purchaseHistorySelectionIndex.! !

!TusLibrosLoginWindowModel methodsFor: 'purchase history window selectors' stamp: 'LNB 11/27/2021 23:34:31'!
purchaseHistoryIndex: aNewSelectionIndex

	purchaseHistorySelectionIndex _ aNewSelectionIndex.
	^true.! !

!TusLibrosLoginWindowModel methodsFor: 'purchase history window selectors' stamp: 'LNB 11/27/2021 23:41:49'!
purchaseHistoryTotal

	^lastPurchaseHistoryRequest at: 'total'.! !
