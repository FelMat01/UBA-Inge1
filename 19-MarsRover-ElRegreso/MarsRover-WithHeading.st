!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #TrackerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #TrackerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:16:03'!
headingAndPositionLogTrackerFor: aMarsRover 

	| logger |
	logger _ MarsRoverLogTracker new.
	logger trackPositionChangesOf: aMarsRover.
	logger trackHeadingChangesOf: aMarsRover.
	^logger! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:15:53'!
headingAndPositionStatusTrackerFor: aMarsRover 

	| statusView |
	statusView _ MarsRoverStatusView new.
	statusView trackPositionOf: aMarsRover.
	statusView trackHeadingOf: aMarsRover.
	^statusView! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:16:23'!
headingLogTrackerFor: aMarsRover 
	
	| logger |
	logger _ MarsRoverLogTracker new.
	logger trackHeadingChangesOf: aMarsRover.
	^logger! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:15:13'!
headingStatusTrackerFor: aMarsRover 
	
	| statusView |
	statusView _ MarsRoverStatusView new.
	statusView trackHeadingOf: aMarsRover.
	^statusView! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:16:16'!
positionLogTrackerFor: aMarsRover 
	
	| logger |
	logger _ MarsRoverLogTracker new.
	logger trackPositionChangesOf: aMarsRover.
	^logger! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:14:44'!
positionStatusTrackerFor: aMarsRover 
	
	| statusView |
	statusView _ MarsRoverStatusView new.
	statusView trackPositionOf: aMarsRover.
	^statusView! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 18:47:49'!
readStreamOn: changesLogger

	^ changesLogger readStream! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:01:27'!
test01LogTrackerTracksMovementToTheNorth

	| logReadStream marsRover changesLogger |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	changesLogger _ self positionLogTrackerFor: marsRover.
	
	marsRover process: 'f'.
	
	logReadStream _ self readStreamOn: changesLogger.
	
	self assert: '1@2' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:00:41'!
test02LogTrackerTracksManyMovements

	| logReadStream marsRover changesLogger |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	changesLogger _ self positionLogTrackerFor: marsRover.
	
	marsRover process: 'ff'.
	
	logReadStream _ self readStreamOn: changesLogger.
	
	self assert: '1@2' equals: logReadStream nextLine.
	self assert: '1@3' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:01:36'!
test03LogTrackerTracksMovementToTheSouth

	| logReadStream marsRover changesLogger |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	changesLogger _ self positionLogTrackerFor: marsRover.
	
	marsRover process: 'b'.
	
	logReadStream _ self readStreamOn: changesLogger.
	
	self assert: '1@0' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:01:51'!
test04LogTrackerTracksMovementToTheEast

	| logReadStream marsRover changesLogger |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	changesLogger _ self positionLogTrackerFor: marsRover.
	
	marsRover process: 'rf'.
	
	logReadStream _ self readStreamOn: changesLogger.
	
	self assert: '2@1' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:01:57'!
test05LogTrackerTracksMovementToTheWest

	| logReadStream marsRover changesLogger |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	changesLogger _ self positionLogTrackerFor: marsRover.
	
	marsRover process: 'lf'.
	
	logReadStream _ self readStreamOn: changesLogger.
	
	self assert: '0@1' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:02:18'!
test06NoMovementsLogsNothing

	| logReadStream marsRover changesLogger |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	changesLogger _ self headingLogTrackerFor: marsRover.
	
	marsRover process: ''.
	
	logReadStream _ self readStreamOn: changesLogger.
	
	self assert: logReadStream atEnd.! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:06:21'!
test07LogTrackerTracksHeadingToTheEast

	| logReadStream marsRover changesLogger |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	changesLogger _ self headingLogTrackerFor: marsRover.
	
	marsRover process: 'r'.
	
	logReadStream _ self readStreamOn: changesLogger.
	
	self assert: 'East' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:06:26'!
test08LogTrackerTracksHeadingToTheSouth

	| logReadStream marsRover changesLogger |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	changesLogger _ self headingLogTrackerFor: marsRover.
	
	marsRover process: 'rr'.
	
	logReadStream _ self readStreamOn: changesLogger.
	
	self assert: 'East' equals: logReadStream nextLine.
	self assert: 'South' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:06:33'!
test09LogTrackerTracksHeadingToTheWest

	| logReadStream marsRover changesLogger |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	changesLogger _ self headingLogTrackerFor: marsRover.
	
	marsRover process: 'l'.
	
	logReadStream _ self readStreamOn: changesLogger.
	
	self assert: 'West' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:06:38'!
test10LogTrackerTracksHeadingToTheNorth

	| logReadStream marsRover changesLogger |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	
	changesLogger _ self headingLogTrackerFor: marsRover.
	
	marsRover process: 'l'.
	
	logReadStream _ self readStreamOn: changesLogger.
	
	self assert: 'North' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:07:36'!
test11LogTrackerCanTrackBothPositionAndHeading

	| logReadStream marsRover changesLogger |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	changesLogger _ self headingAndPositionLogTrackerFor: marsRover.
	
	marsRover process: 'frf'.
	
	logReadStream _ self readStreamOn: changesLogger.
	
	self assert: '1@2' equals: logReadStream nextLine.
	self assert: 'East' equals: logReadStream nextLine.
	self assert: '2@2' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:07:55'!
test12StatusTrackerStartsTrackingInitialPosition

	| marsRover statusTracker |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	statusTracker _ self positionStatusTrackerFor: marsRover.
	
	self assert: 1@1 equals: statusTracker positionTextFieldModel.! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:08:06'!
test13StatusTrackersTracksMovements

	| marsRover statusTracker |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	statusTracker _ self positionStatusTrackerFor: marsRover.
	
	marsRover process: 'f'.
	
	self assert: 1@2 equals: statusTracker positionTextFieldModel.! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:08:38'!
test14StatusTrackerTracksInitialHeading

	| marsRover statusTracker |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	statusTracker _ self headingStatusTrackerFor: marsRover.
	
	self assert: (statusTracker headingTextFieldModel isHeading: MarsRoverHeadingNorth).! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:08:50'!
test15StatusTrackerTracksRotations

	| marsRover statusTracker |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	statusTracker _ self headingStatusTrackerFor: marsRover.
	
	marsRover process: 'r'.
	
	self assert: (statusTracker headingTextFieldModel isHeading: MarsRoverHeadingEast).! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:09:04'!
test16StatusTrackerCanTrackBothPositionAndHeading

	| marsRover statusTracker |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	statusTracker _ self headingAndPositionStatusTrackerFor: marsRover.
	
	marsRover process: 'fr'.
	
	self assert: 1@2 equals: statusTracker positionTextFieldModel.
	self assert: (statusTracker headingTextFieldModel isHeading: MarsRoverHeadingEast).! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:09:33'!
test17MarsRoverCanHaveMoreThanOneLogger

	| logReadStream marsRover changesLogger anotherChangesLogger anotherLogReadStream |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	changesLogger _ self headingAndPositionLogTrackerFor: marsRover.
	anotherChangesLogger _ self headingAndPositionLogTrackerFor: marsRover.
	
	marsRover process: 'rf'.
	
	logReadStream _ self readStreamOn: changesLogger.
	anotherLogReadStream _ self readStreamOn: anotherChangesLogger.
	
	self assert: 'East' equals: logReadStream nextLine.
	self assert: '2@1' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.
	
	self assert: 'East' equals: anotherLogReadStream nextLine.
	self assert: '2@1' equals: anotherLogReadStream nextLine.
	self assert: anotherLogReadStream atEnd.! !

!TrackerTest methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 23:09:46'!
test18MarsRoverCanHaveMoreThanOneStatusTracker

	| marsRover statusTracker anotherStatusTracker |
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	statusTracker _ self headingAndPositionStatusTrackerFor: marsRover.
	anotherStatusTracker _ self headingAndPositionStatusTrackerFor: marsRover.
	
	marsRover process: 'fr'.
	
	self assert: 1@2 equals: statusTracker positionTextFieldModel.
	self assert: (statusTracker headingTextFieldModel isHeading: MarsRoverHeadingEast).
	
	self assert: 1@2 equals: anotherStatusTracker positionTextFieldModel.
	self assert: (anotherStatusTracker headingTextFieldModel isHeading: MarsRoverHeadingEast).! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head trackers headingTrackers positionTrackers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'MF 10/26/2021 22:42:25'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	
	headingTrackers _ OrderedCollection new.
	positionTrackers _ OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'MF 10/26/2021 22:46:09'!
changeHeadTo: aNewHeading
	
	head := aNewHeading.
	headingTrackers do: [ :aHeadingTracker | aHeadingTracker trackUpdatedHeading: head].! !

!MarsRover methodsFor: 'heading' stamp: 'MF 10/26/2021 17:37:51'!
headEast
	
	self changeHeadTo: (MarsRoverHeadingEast for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'MF 10/26/2021 17:38:04'!
headNorth
	
	self changeHeadTo: (MarsRoverHeadingNorth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'MF 10/26/2021 17:38:13'!
headSouth
	
	self changeHeadTo: (MarsRoverHeadingSouth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'MF 10/26/2021 17:38:22'!
headWest
	
	self changeHeadTo: (MarsRoverHeadingWest for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'MF 10/26/2021 17:24:00'!
moveEast
	
	self movePositionWithAnOffset: 1@0! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'MF 10/26/2021 17:23:34'!
moveNorth
	
	self movePositionWithAnOffset: 0@1! !

!MarsRover methodsFor: 'moving' stamp: 'MF 10/26/2021 22:46:03'!
movePositionWithAnOffset: anOffset
	
	position := position + anOffset.
	positionTrackers do: [ :aPositionTracker | aPositionTracker trackUpdatedPosition: position].! !

!MarsRover methodsFor: 'moving' stamp: 'MF 10/26/2021 17:23:43'!
moveSouth
	
	self movePositionWithAnOffset: 0@-1! !

!MarsRover methodsFor: 'moving' stamp: 'MF 10/26/2021 17:23:50'!
moveWest
	
	self movePositionWithAnOffset: -1@0! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'MF 10/26/2021 17:04:52'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].


	self signalInvalidCommand.! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:38:03'!
addTracker: aTracker for: aThing

	(trackers at: aThing) add: aTracker.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:42:48'!
trackHeadingChangesTo: aLogger
	
	headingTrackers add: aLogger.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:45:38'!
trackHeadingChangesToStatusView: aMarsRoverStatusView 
	
	headingTrackers add: aMarsRoverStatusView.
	aMarsRoverStatusView trackUpdatedHeading: head.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:42:59'!
trackPositionChangesTo: aLogger

	positionTrackers add: aLogger.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:45:48'!
trackPositionChangesToStatusView: aMarsRoverStatusView 

	positionTrackers add: aMarsRoverStatusView.
	aMarsRoverStatusView trackUpdatedPosition: position.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'printing' stamp: 'MF 10/26/2021 17:33:05'!
printOn: aStream

	aStream nextPutAll: 'East'.! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'printing' stamp: 'MF 10/26/2021 17:33:29'!
printOn: aStream

	aStream nextPutAll: 'North'.! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'printing' stamp: 'MF 10/26/2021 17:33:46'!
printOn: aStream

	aStream nextPutAll: 'South'.! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'printing' stamp: 'MF 10/26/2021 17:34:02'!
printOn: aStream

	aStream nextPutAll: 'West'.! !


!classDefinition: #MarsRoverTracker category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverTracker
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTracker methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:55:58'!
track: aThing of: aMarsRover
	
	aMarsRover addTracker: self for: aThing.
! !


!classDefinition: #MarsRoverLogTracker category: 'MarsRover-WithHeading'!
MarsRoverTracker subclass: #MarsRoverLogTracker
	instanceVariableNames: 'logger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogTracker methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 18:44:40'!
initialize

	logger _ WriteStream on: ''! !

!MarsRoverLogTracker methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 18:48:01'!
readStream

	^ReadStream on: logger contents.! !

!MarsRoverLogTracker methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:10:36'!
trackHeadingChangesOf: aMarsRover
	
	aMarsRover trackHeadingChangesTo: self.
! !

!MarsRoverLogTracker methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:08:09'!
trackPositionChangesOf: aMarsRover
	
	aMarsRover trackPositionChangesTo: self.! !

!MarsRoverLogTracker methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 18:52:10'!
trackUpdatedHeading: aHeading

	logger nextPutAll: aHeading printString; newLine.	! !

!MarsRoverLogTracker methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 18:51:44'!
trackUpdatedPosition: aPosition
	
	logger nextPutAll: aPosition printString; newLine! !


!classDefinition: #MarsRoverStatusView category: 'MarsRover-WithHeading'!
MarsRoverTracker subclass: #MarsRoverStatusView
	instanceVariableNames: 'positionTextFieldModel headingTextFieldModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStatusView methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 18:29:19'!
headingTextFieldModel
	
	^headingTextFieldModel.! !

!MarsRoverStatusView methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 18:14:01'!
positionTextFieldModel

	^positionTextFieldModel.! !

!MarsRoverStatusView methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:14:57'!
trackHeadingOf: aMarsRover

	aMarsRover trackHeadingChangesToStatusView: self.! !

!MarsRoverStatusView methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 22:14:43'!
trackPositionOf: aMarsRover

	aMarsRover trackPositionChangesToStatusView: self..! !

!MarsRoverStatusView methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 18:52:21'!
trackUpdatedHeading: aHeading
	
	headingTextFieldModel _ aHeading.! !

!MarsRoverStatusView methodsFor: 'as yet unclassified' stamp: 'MF 10/26/2021 18:51:57'!
trackUpdatedPosition: aPosition

	positionTextFieldModel _ aPosition.
	
	! !
