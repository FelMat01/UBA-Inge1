!classDefinition: #TusLibrosClientCatalogAndCartContentsWindow category: 'TusLibros-Views'!
SystemWindow subclass: #TusLibrosClientCatalogAndCartContentsWindow
	instanceVariableNames: 'cartContentsPluggableList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Views'!

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 16:48:08'!
build1stColumn

	| firstColumnLayoutMorph |
	
	firstColumnLayoutMorph _ LayoutMorph newColumn.
	firstColumnLayoutMorph axisEdgeWeight: 0.5;
	separation: 50;
	addMorph: (LabelMorph contents: 'Catalogue');
	addMorph: ((PluggableListMorph model: self model listGetter: #catalogueProducts indexGetter: #catalogueListIndex indexSetter: #catalogueListIndex:) borderWidth: 1; borderColor: Color black) layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1).
	"firstRowLayoutMorph borderColor: Color skyBlue; borderWidth: 1; morphWidth:300."
	
	^firstColumnLayoutMorph.! !

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 16:47:43'!
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

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 18:10:34'!
build3rdColumn

	| thirdColumnLayoutMorph |
	
	cartContentsPluggableList _ ((PluggableListMorph model: self model listGetter: #cartContents indexGetter: #cartContentsIndex indexSetter: #cartContentsIndex:) borderWidth: 1; borderColor: Color black) layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1).
	
	thirdColumnLayoutMorph _ LayoutMorph newColumn.
	thirdColumnLayoutMorph axisEdgeWeight: 0.5;
	separation: 50;
	addMorph: (LabelMorph contents: 'Cart');
	addMorph: cartContentsPluggableList.
	
	^thirdColumnLayoutMorph.! !

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 16:42:22'!
buildMorphicWindow

	self layoutMorph beRow;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: self build1stColumn layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1);
	addMorph: self build2ndColumn layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1);
	addMorph: self build3rdColumn layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1).
	
	" estaria bueno que la responsabilidad de hacer el layoutSpec la tenga el morph que va a cambiar
	su layout spec"! !

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 14:57:52'!
defaultExtent

	^ 1280@720
! !

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 17:52:05'!
initializeNamed: aTitle modeledBy: aModel

	"self titleMorph showButtonsNamed: #( close collapse )."
	self setLabel: aTitle.
	self model: aModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	
	self model when: #cartContentsModified send: #updateCartContents to: self.
	
	self openInWorld.! !

!TusLibrosClientCatalogAndCartContentsWindow methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 18:10:52'!
updateCartContents
	
	cartContentsPluggableList updateList.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientCatalogAndCartContentsWindow class' category: 'TusLibros-Views'!
TusLibrosClientCatalogAndCartContentsWindow class
	instanceVariableNames: ''!

!TusLibrosClientCatalogAndCartContentsWindow class methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 15:06:36'!
openWithModel: aModel

	^self new initializeNamed: 'TusLibros - Client Window' modeledBy: aModel.! !


!classDefinition: #TusLibrosClientWindow category: 'TusLibros-Views'!
SystemWindow subclass: #TusLibrosClientWindow
	instanceVariableNames: 'usernameTextBoxMorph passwordTextBoxMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Views'!

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'MF 11/18/2021 18:18:09'!
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

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'MF 11/18/2021 18:20:20'!
build2ndRow

	^PluggableButtonMorph model: self model stateGetter: nil action: #createCart label: 'Create Cart'
	
	! !

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'MF 11/18/2021 18:05:57'!
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

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 15:17:49'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: self build1stRow layoutSpec: (LayoutSpec proportionalWidth: 1 fixedHeight: 1);
	addMorph: self build2ndRow layoutSpec: (LayoutSpec fixedWidth: 200 fixedHeight: 50).
	
	" estaria bueno que la responsabilidad de hacer el layoutSpec la tenga el morph que va a cambiar
	su layout spec"! !

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 15:18:25'!
buildMorphicWindowDisplayingCartContentsAndCatalog

	TusLibrosClientCatalogAndCartContentsWindow openWithModel: self model.
	self delete.! !

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'MF 11/18/2021 18:01:44'!
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

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'MF 11/18/2021 18:01:19'!
buildUsernameTextMorph

	usernameTextBoxMorph _ TextModelMorph 
								textProvider: self model 
								textGetter: #username 
								textSetter: #username:.
	usernameTextBoxMorph innerTextMorph 
							setProperty: #keyStroke: 
							toValue: [ :key | usernameTextBoxMorph innerTextMorph acceptContents ].				
	usernameTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300; morphHeight: 1. ! !

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 21:38:33'!
defaultExtent

	^ 1280@720
! !

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 15:05:05'!
displayCatalogAndCartContents

	self buildMorphicWindowDisplayingCartContentsAndCatalog.! !

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 15:17:49'!
initializeWith: aTitle

	"self titleMorph showButtonsNamed: #( close collapse )."
	self setLabel: aTitle.
	self model: (TusLibrosLoginWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	
	self model when: #cartCreationSuccesful send: #displayCatalogAndCartContents to: self.
	
	self openInWorld.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindow class' category: 'TusLibros-Views'!
TusLibrosClientWindow class
	instanceVariableNames: ''!

!TusLibrosClientWindow class methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 21:19:45'!
open

	^self new initializeWith: 'TusLibros - Client Window'! !


!classDefinition: #TusLibrosClientInterface category: 'TusLibros-Views'!
Object subclass: #TusLibrosClientInterface
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Views'!

!TusLibrosClientInterface methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 17:48:13'!
addToCartRequest: aCartId for: aBookISBN of: anAmount

	| fieldDict resp |
	fieldDict _ Dictionary newFromPairs: { 'cartId'. aCartId. 'bookISBN'. aBookISBN. 'bookQuantity'. anAmount }.
	
	resp _ WebClient htmlSubmit: (self url, '/addToCart') fields: fieldDict method: 'POST'.
	
	resp isSuccess 
        		ifFalse:[^self error: resp content].! !

!TusLibrosClientInterface methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 19:28:24'!
checkoutCartRequestFor: aCartId withCCN: aCCN withCCME: aCCME withCCYE: aCCYE withCCO: aCCO

	| fieldDict resp |
	fieldDict _ Dictionary newFromPairs: { 'cartId'. aCartId. 'ccn'. aCCN. 'ccme'. aCCME. 'ccye'. aCCYE. 'cco'. aCCO. }.
	
	resp _ WebClient htmlSubmit: (self url, '/checkoutCart') fields: fieldDict method: 'POST'.
	
	resp isSuccess 
		ifTrue:[^WebUtils jsonDecode: ((resp content) readStream).] 
        		ifFalse:[^self error: resp content].! !

!TusLibrosClientInterface methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 17:35:33'!
createCartRequestFor: aUsername with: aPassword

	" un username no deberia tener espacios, todo: chequear que eso no suceda"
	| fieldDict resp |
	fieldDict _ Dictionary newFromPairs: { 'clientId'. aUsername. 'password'. aPassword }.
	
	resp _ WebClient htmlSubmit: (self url, '/createCart') fields: fieldDict method: 'POST'.
	
	resp isSuccess 
        		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
        		ifFalse:[^self error: resp content].! !

!TusLibrosClientInterface methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 18:19:17'!
listCartRequestFor: aCartId

	| fieldDict resp |
	fieldDict _ Dictionary newFromPairs: { 'cartId'. aCartId }.
	
	resp _ WebClient htmlSubmit: (self url, '/listCart') fields: fieldDict method: 'POST'.
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).]
        		ifFalse:[^self error: resp content].! !

!TusLibrosClientInterface methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 17:20:41'!
listCatalog

	| resp |
	
	resp _ WebClient httpGet: (self url, '/listCatalog').
	
	resp isSuccess 
        		ifTrue:[^WebUtils jsonDecode: ((resp content) readStream).] 
        		ifFalse:[^self error: resp content].! !

!TusLibrosClientInterface methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 21:14:54'!
port
	
	^port ifNil: [port:=8080].! !

!TusLibrosClientInterface methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 18:24:42'!
removeFromCartRequest: aCartId for: aBookISBN of: anAmount

	| fieldDict resp |
	fieldDict _ Dictionary newFromPairs: { 'cartId'. aCartId. 'bookISBN'. aBookISBN. 'bookQuantity'. anAmount }.
	
	resp _ WebClient htmlSubmit: (self url, '/removeFromCart') fields: fieldDict method: 'POST'.
	
	resp isSuccess 
        		ifFalse:[^self error: resp content].! !

!TusLibrosClientInterface methodsFor: 'as yet unclassified' stamp: 'MF 11/15/2021 21:14:48'!
url
	
	^'http://localhost:', self port asString! !


!classDefinition: #TusLibrosLoginWindowModel category: 'TusLibros-Views'!
Object subclass: #TusLibrosLoginWindowModel
	instanceVariableNames: 'username password restInterface cartId catalogueSelectionIndex cartSelectionIndex quantityToTransferTextBoxContents ticket ccn ccme ccye'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Views'!

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 18:14:56'!
addToCart

	| bookISBN |
	bookISBN _ (restInterface listCatalog keys at: catalogueSelectionIndex).

	restInterface addToCartRequest: cartId for: bookISBN of: quantityToTransferTextBoxContents asNumber.
	
	self triggerEvent: #cartContentsModified.! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 18:19:01'!
cartContents

	| cartContents |
	cartContents _ restInterface listCartRequestFor:cartId.
	
	^cartContents keys collect:[:aBookISBN | aBookISBN , ' | ' , ((cartContents at: aBookISBN) asString)].
	! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 16:09:56'!
cartContentsIndex

	^cartSelectionIndex.! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 16:10:22'!
cartContentsIndex: aNewIndex

	cartSelectionIndex _ aNewIndex.
	^true.! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 16:04:27'!
catalogueListIndex

	^catalogueSelectionIndex.! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 17:29:14'!
catalogueListIndex: aNewIndex

	catalogueSelectionIndex _ aNewIndex.
	^true.! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 17:27:56'!
catalogueProducts

	| catalog |
	catalog _ restInterface listCatalog.
	
	^catalog keys collect:[:aBookISBN | aBookISBN , ' | $' , ((catalog at: aBookISBN) asString)].! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 19:29:29'!
checkoutCart

	ticket _ restInterface checkoutCartRequestFor: cartId withCCN: ccn withCCME: ccme withCCYE: ccye withCCO: 'admin'.
	
	self halt.
	
	self triggerEvent: #checkoutCartSuccess.! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 17:03:24'!
createCart

	cartId _ restInterface createCartRequestFor: username with: password.
	
	self triggerEvent: #cartCreationSuccesful.! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 19:15:15'!
initialize

	username _ ''.
	password _ ''.
	restInterface _ TusLibrosClientInterface new.
	
	catalogueSelectionIndex _ 0.
	cartSelectionIndex _ 0.
	
	quantityToTransferTextBoxContents _ ''.
	
	"Cargamos un archivo encriptado con la tarjeta de credito del usuario"
	
	ccn _ '1234567890123456'.
	ccme _ GregorianMonth current number asString.
	ccye _ GregorianYear current number asString.! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'MF 11/18/2021 17:46:36'!
password

	^password.! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'MF 11/18/2021 18:17:30'!
password: aPassword

	password _ aPassword.
	^true.! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 16:23:45'!
quantityToTransfer

	^quantityToTransferTextBoxContents.! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 16:32:34'!
quantityToTransfer: transferableQuantityString

	quantityToTransferTextBoxContents _ transferableQuantityString.
	^true.! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'LNB 11/27/2021 18:22:10'!
removeFromCart

	| bookISBN |
	bookISBN _ (restInterface listCatalog keys at: catalogueSelectionIndex).

	restInterface removeFromCartRequest: cartId for: bookISBN of: quantityToTransferTextBoxContents asNumber.
	
	self triggerEvent: #cartContentsModified.! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'MF 11/18/2021 17:46:11'!
username

	^username! !

!TusLibrosLoginWindowModel methodsFor: 'as yet unclassified' stamp: 'MF 11/18/2021 18:17:35'!
username: aUsername

	username _ aUsername.
	^true.! !
