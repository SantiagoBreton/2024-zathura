Class {
	#name : #SpaceShip,
	#superclass : #Object,
	#instVars : [
		'turnsToLose',
		'needsToThrow',
		'ally',
		'fuelTank',
		'turbines',
		'owner',
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
SpaceShip class >> assertValidNameFor: aName [

	aName isEmpty ifTrue: [
		Error signal: 'Ship cant be created without a name' ]
]

{ #category : #'instance creation' }
SpaceShip class >> ownedBy: aName withMaxFuel: anAmount [

	self assertValidNameFor: aName.
	^ self new initialize: aName withMaxFuel: anAmount
]
{ #category : #accessing }
SpaceShip >> >=anotherSpaceship [
	^ ((self lap > anotherSpaceship lap) or: (self lap = anotherSpaceship lap and: self tileNumber > anotherSpaceship tileNumber)).
]

{ #category : #testing }
SpaceShip >> ally [

	^ ally
]

{ #category : #playing }
SpaceShip >> applyPenaltyForEmptyFuelTank [

	self resetPosition.
	fuelTank refuelToMax.
	self decreaseATurbine.
	self losesTurns: 2
]

{ #category : #'accessing - arguments' }
SpaceShip >> canPlay [

	(turbines > 0 and: turnsToLose <= 0) ifTrue: [ ^ true ].
	^ false
]

{ #category : #asserting }
SpaceShip >> canProvideToAnAlly: anAmountOfFuel [

	fuelTank currentFuel > anAmountOfFuel ifTrue: [ ^ true ].
	^ false
]

{ #category : #playing }
SpaceShip >> changeRollingResultNeededToMove: aNumber [

	needsToThrow := aNumber
]

{ #category : #accessing }
SpaceShip >> checkForRollInHyperGravity: rolledNumber [

	(needsToThrow = 0 or: [ rolledNumber = needsToThrow ])
		ifTrue: [ needsToThrow := 0 ]
		ifFalse: [ self decreaseATurbine ]
]

{ #category : #playing }
SpaceShip >> decreaseATurbine [

	turbines := turbines - 1
]

{ #category : #playing }
SpaceShip >> decreaseFuelBy: amountOfFuel [

	fuelTank decreaseFuelBy: amountOfFuel
]

{ #category : #accessing }
SpaceShip >> fuelTank [

	^ fuelTank
]

{ #category : #playing }
SpaceShip >> handleAllyFuelToMoveFor: positionAfterMovement [

	(ally canProvideToAnAlly: fuelTank currentFuel abs)
		ifTrue: [
			ally decreaseFuelBy: fuelTank currentFuel abs.
			fuelTank fuel: 0.
			self moveToNextPostion: positionAfterMovement ]
		ifFalse: [
			ally applyPenaltyForEmptyFuelTank.
			self applyPenaltyForEmptyFuelTank ]
]

{ #category : #playing }
SpaceShip >> handleEmptyFuelTankToMoveFor: positionAfterMovement [

	ally
		ifNil: [ self applyPenaltyForEmptyFuelTank ]
		ifNotNil: [ self handleAllyFuelToMoveFor: positionAfterMovement ]
]

{ #category : #initialization }
SpaceShip >> initialize: aName withMaxFuel: anAmount [

	owner := aName.
	turnsToLose := 0.
	needsToThrow := 0.
	turbines := 3.
	fuelTank := FuelTank withMaxFuel: anAmount.
	position := SpaceShipPosition createAt: 1 and: 1.
	ally := nil
]

{ #category : #'accessing - arguments' }
SpaceShip >> lap [

	^ position lap
]

{ #category : #playing }
SpaceShip >> losesTurns: amountOfTurns [

	turnsToLose := turnsToLose + amountOfTurns
]

{ #category : #asserting }
SpaceShip >> makeAnAllianceWith: anotherSpaceship [

	ally := anotherSpaceship
]

{ #category : #playing }
SpaceShip >> moveTo: positionAfterMovement needing: amountOfFuelNeeded [

	needsToThrow = 0 ifFalse: [ ^ self ].
	self decreaseFuelBy: amountOfFuelNeeded.

	fuelTank isEmpty
		ifTrue: [ self handleEmptyFuelTankToMoveFor: positionAfterMovement ]
		ifFalse: [ self moveToNextPostion: positionAfterMovement ]
]

{ #category : #playing }
SpaceShip >> moveToNextPostion: positionAfterMovement [

	position := positionAfterMovement
]

{ #category : #accessing }
SpaceShip >> owner [

	^ owner
]

{ #category : #'accessing - arguments' }
SpaceShip >> position [

	^ position .
]

{ #category : #accessing }
SpaceShip >> resetPosition [

	position resetPosition
]

{ #category : #playing }
SpaceShip >> rollDiceUsing: aDiceRoller [

	| rolledNumber |
	rolledNumber := aDiceRoller roll.
	self checkForRollInHyperGravity: rolledNumber.
	^ rolledNumber
]

{ #category : #asserting }
SpaceShip >> setAllyToNil [

	ally := nil
]

{ #category : #playing }
SpaceShip >> skipTurn [

	self losesTurns: 1.
	fuelTank refuelToMax
]

{ #category : #'accessing - arguments' }
SpaceShip >> tileNumber [

	^ position tileNumber .
]

{ #category : #accessing }
SpaceShip >> turbine [

	^ turbines
]
