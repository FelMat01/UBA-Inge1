!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 18:51:41'!
* aNaturalNumber
	
	^aNaturalNumber.! !

!I class methodsFor: 'as yet unclassified' stamp: 'MF 8/26/2021 21:14:00'!
+ aNaturalNumber

	^aNaturalNumber next! !

!I class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:15:46'!
- aNaturalNumber

	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 19:49:49'!
/ aNaturalNumber
	
	aNaturalNumber = I ifTrue: [^self].
	Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!I class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 19:49:01'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	
	^'Hubo un error: No se puede dividir por un numero mayor'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 19:14:52'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	
	^'Hubo un error: No hay numeros menores que el 1'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'MF 8/26/2021 20:42:56'!
next

	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:17:37'!
previous
	
	self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!I class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 18:24:03'!
subtractTo: aNaturalNumber

	^aNaturalNumber previous.! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 18:53:00'!
* aNaturalNumber

	^self previous * aNaturalNumber + aNaturalNumber. 
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'MF 8/26/2021 21:22:39'!
+ aNaturalNumber

	^self previous + aNaturalNumber next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 18:28:53'!
- aNaturalNumber

	^aNaturalNumber subtractTo: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 19:10:15'!
/ aNaturalNumber
	
	self = aNaturalNumber ifTrue: [^I].
	^self - aNaturalNumber / aNaturalNumber + I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 19:23:45'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'Hubo un error: No se puede dividir por un numero mayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:19:17'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MF 8/26/2021 21:23:46'!
next
	
	next ifNotNil: [^next].
	next _ II createChildNamed: self name, 'I'.
	next previous: self.
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MF 8/26/2021 21:21:45'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'MF 8/26/2021 21:29:34'!
previous: aNaturalNumber

	previous _ aNaturalNumber! !

!II class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 18:24:36'!
subtractTo: aNaturalNumber

	^self previous subtractTo: aNaturalNumber previous.! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:19:17'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:19:17'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Numeros Naturales'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Numeros Naturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:19:17'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'Numeros Naturales'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Numeros Naturales'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:19:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIII.
	previous := IIIII.! !


!classDefinition: #IIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: 'Numeros Naturales'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:19:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIII.
	previous := IIIIII.! !


!classDefinition: #IIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: 'Numeros Naturales'!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:19:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIII.
	previous := IIIIIII.! !


!classDefinition: #IIIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:19:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIII.
	previous := IIIIIIII.! !


!classDefinition: #IIIIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:19:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIII.
	previous := IIIIIIIII.! !


!classDefinition: #IIIIIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:19:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIII.
	previous := IIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:19:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIII.
	previous := IIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:19:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIII.
	previous := IIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:19:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'MF 8/28/2021 20:19:18'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := AnObsoleteIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!
IIIIIIIII initializeAfterFileIn!
IIIIIIIIII initializeAfterFileIn!
IIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIII initializeAfterFileIn!