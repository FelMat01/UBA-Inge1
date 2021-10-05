!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:27:37'!
test01

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.

	marsRover process: ''.
	
	self assert: (marsRover isHeadingNorthAt: 1@2).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:32:14'!
test02

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isHeadingNorthAt: 1@3).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:32:40'!
test03

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: East new.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isHeadingEastAt: 2@2).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:33:39'!
test04

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: West new.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isHeadingWestAt: 0@2).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:33:55'!
test05

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: South new.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isHeadingSouthAt: 1@1).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:34:23'!
test06

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isHeadingNorthAt: 1@1).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:34:37'!
test07

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: East new.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isHeadingEastAt: 0@2).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:34:49'!
test08

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: West new.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isHeadingWestAt: 2@2).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:35:02'!
test09

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: South new.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isHeadingSouthAt: 1@3).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:39:08'!
test10

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isHeadingWestAt: 1@2).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:40:43'!
test11

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: East new.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isHeadingNorthAt: 1@2).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:42:13'!
test12

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: South new.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isHeadingEastAt: 1@2).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:42:52'!
test13

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: West new.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isHeadingSouthAt: 1@2).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:49:38'!
test14

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isHeadingEastAt: 1@2).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:50:58'!
test15

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: East new.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isHeadingSouthAt: 1@2).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:51:54'!
test16

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: South new.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isHeadingWestAt: 1@2).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 17:52:47'!
test17

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: West new.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isHeadingNorthAt: 1@2).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 18:07:19'!
test18

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover process: 'rf'.
	
	self assert: (marsRover isHeadingEastAt: 2@2).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MF 10/5/2021 18:19:12'!
test19ProcessCommandsUntilInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: North new.
	
	marsRover process: 'fXb'.
	
	self assert: (marsRover isHeadingNorthAt: 1@3).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'startingPoint cardinalPoint position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'processing' stamp: 'MF 10/5/2021 18:23:27'!
isValidCommand: aCommand
	
	^'fbrl' includes: aCommand.! !

!MarsRover methodsFor: 'processing' stamp: 'MF 10/5/2021 18:26:29'!
process: aSequenceOfCommands
	
	aSequenceOfCommands do: [ :aCommand | 
		(self isValidCommand: aCommand) ifFalse: [ ^self ].
		self processSingleCommand: aCommand.].
! !

!MarsRover methodsFor: 'processing' stamp: 'MF 10/5/2021 18:40:42'!
processSingleCommand: aCommand
	
	aCommand = $f ifTrue: [ direction moveForward: self ].
	aCommand = $b ifTrue: [ direction moveBackward: self ].
	aCommand = $l ifTrue: [ direction turnLeft: self ].
	aCommand = $r ifTrue: [ direction turnRight: self ].
! !


!MarsRover methodsFor: 'initialization' stamp: 'MF 10/5/2021 16:41:57'!
initializeAt: aStartingPoint heading: aCardinalPoint 
	
	position := aStartingPoint.
	direction := aCardinalPoint.! !


!MarsRover methodsFor: 'testing' stamp: 'MF 10/5/2021 16:43:21'!
isAt: aPoint heading: aCardinalPoint 
	
	^position = aPoint and: [ direction = aCardinalPoint ].! !

!MarsRover methodsFor: 'testing' stamp: 'MF 10/5/2021 17:31:31'!
isHeadingEastAt: aPoint

	^direction isEast and: [ position = aPoint ].! !

!MarsRover methodsFor: 'testing' stamp: 'MF 10/5/2021 17:28:10'!
isHeadingNorthAt: aPoint

	^direction isNorth and: [ position = aPoint ].! !

!MarsRover methodsFor: 'testing' stamp: 'MF 10/5/2021 17:30:29'!
isHeadingSouthAt: aPoint

	^direction isSouth and: [ position = aPoint ].! !

!MarsRover methodsFor: 'testing' stamp: 'MF 10/5/2021 17:31:42'!
isHeadingWestAt: aPoint

	^direction isWest and: [ position = aPoint ].! !


!MarsRover methodsFor: 'moving' stamp: 'MF 10/5/2021 17:03:55'!
moveEast

	position _ position + (1@0).! !

!MarsRover methodsFor: 'moving' stamp: 'MF 10/5/2021 17:03:44'!
moveNorth

	position _ position + (0@1).! !

!MarsRover methodsFor: 'moving' stamp: 'MF 10/5/2021 17:04:11'!
moveSouth

	position _ position - (0@1).! !

!MarsRover methodsFor: 'moving' stamp: 'MF 10/5/2021 17:04:03'!
moveWest

	position _ position - (1@0).! !


!MarsRover methodsFor: 'heading' stamp: 'MF 10/5/2021 17:48:29'!
headEast

	direction _ East new.! !

!MarsRover methodsFor: 'heading' stamp: 'MF 10/5/2021 17:48:22'!
headNorth

	direction _ North new.! !

!MarsRover methodsFor: 'heading' stamp: 'MF 10/5/2021 17:48:34'!
headSouth

	direction _ South new.! !

!MarsRover methodsFor: 'heading' stamp: 'MF 10/5/2021 17:48:41'!
headWest

	direction _ West new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MF 10/5/2021 16:41:24'!
at: aStartingPoint heading: aCardinalPoint 

	^self new initializeAt: aStartingPoint heading: aCardinalPoint.! !


!classDefinition: #MarsRoverHeading category: 'MarsRover'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverHeading methodsFor: 'testing' stamp: 'MF 10/5/2021 17:28:23'!
isEast

	^false! !

!MarsRoverHeading methodsFor: 'testing' stamp: 'MF 10/5/2021 17:28:20'!
isNorth

	^false! !

!MarsRoverHeading methodsFor: 'testing' stamp: 'MF 10/5/2021 17:28:49'!
isSouth

	^false! !

!MarsRoverHeading methodsFor: 'testing' stamp: 'MF 10/5/2021 17:28:46'!
isWest

	^false! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'MF 10/5/2021 17:35:38'!
moveBackward: aMarsRover

	self subclassResponsibility! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'MF 10/5/2021 17:01:19'!
moveForward: aMarsRover

	self subclassResponsibility! !


!MarsRoverHeading methodsFor: 'turning' stamp: 'MF 10/5/2021 17:46:03'!
turnLeft: aMarsRover

	self subclassResponsibility! !

!MarsRoverHeading methodsFor: 'turning' stamp: 'MF 10/5/2021 17:53:31'!
turnRight: aMarsRover

	self subclassResponsibility! !


!classDefinition: #East category: 'MarsRover'!
MarsRoverHeading subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'testing' stamp: 'MF 10/5/2021 17:29:12'!
isEast

	^true! !


!East methodsFor: 'moving' stamp: 'MF 10/5/2021 17:36:28'!
moveBackward: aMarsRover

	aMarsRover moveWest.! !

!East methodsFor: 'moving' stamp: 'MF 10/5/2021 17:02:39'!
moveForward: aMarsRover

	aMarsRover moveEast.! !


!East methodsFor: 'turning' stamp: 'MF 10/5/2021 17:46:54'!
turnLeft: aMarsRover

	aMarsRover headNorth.! !

!East methodsFor: 'turning' stamp: 'MF 10/5/2021 17:53:45'!
turnRight: aMarsRover

	aMarsRover headSouth.! !


!classDefinition: #North category: 'MarsRover'!
MarsRoverHeading subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'testing' stamp: 'MF 10/5/2021 17:29:18'!
isNorth

	^true! !


!North methodsFor: 'moving' stamp: 'MF 10/5/2021 17:36:39'!
moveBackward: aMarsRover

	aMarsRover moveSouth.! !

!North methodsFor: 'moving' stamp: 'MF 10/5/2021 17:02:45'!
moveForward: aMarsRover

	aMarsRover moveNorth.! !


!North methodsFor: 'turning' stamp: 'MF 10/5/2021 17:47:22'!
turnLeft: aMarsRover

	aMarsRover headWest.! !

!North methodsFor: 'turning' stamp: 'MF 10/5/2021 17:53:55'!
turnRight: aMarsRover

	aMarsRover headEast.! !


!classDefinition: #South category: 'MarsRover'!
MarsRoverHeading subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'testing' stamp: 'MF 10/5/2021 17:29:25'!
isSouth

	^true.! !


!South methodsFor: 'moving' stamp: 'MF 10/5/2021 17:36:49'!
moveBackward: aMarsRover

	aMarsRover moveNorth.! !

!South methodsFor: 'moving' stamp: 'MF 10/5/2021 17:02:56'!
moveForward: aMarsRover

	aMarsRover moveSouth.! !


!South methodsFor: 'turning' stamp: 'MF 10/5/2021 17:47:45'!
turnLeft: aMarsRover

	aMarsRover headEast.! !

!South methodsFor: 'turning' stamp: 'MF 10/5/2021 17:54:06'!
turnRight: aMarsRover

	aMarsRover headWest.! !


!classDefinition: #West category: 'MarsRover'!
MarsRoverHeading subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'testing' stamp: 'MF 10/5/2021 17:29:31'!
isWest

	^true! !


!West methodsFor: 'moving' stamp: 'MF 10/5/2021 17:36:59'!
moveBackward: aMarsRover

	aMarsRover moveEast.! !

!West methodsFor: 'moving' stamp: 'MF 10/5/2021 17:03:02'!
moveForward: aMarsRover

	aMarsRover moveWest.! !


!West methodsFor: 'turning' stamp: 'MF 10/5/2021 17:47:54'!
turnLeft: aMarsRover

	aMarsRover headSouth.! !

!West methodsFor: 'turning' stamp: 'MF 10/5/2021 17:54:14'!
turnRight: aMarsRover

	aMarsRover headNorth.! !
