Class {
	#name : #SpaceShip,
	#superclass : #Object,
	#instVars : [
		'position',
		'lap',
		'turnsToLose',
		'needsToThrow',
		'ally',
		'fuelTank',
		'turbines',
		'owner'
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
	^ ((self lap > anotherSpaceship lap) or: (self lap = anotherSpaceship lap and: self position > anotherSpaceship position)).
]

{ #category : #accessing }
SpaceShip >> ally [

	^ ally
]

{ #category : #playing }
SpaceShip >> applyPenaltyForEmptyFuelTank [

	position := 1.
	fuelTank refuelToMax.
	self decreaseATurbine .
	self losesTurns: 2
]

{ #category : #'accessing - arguments' }
SpaceShip >> canPlay [
	(turbines > 0 and: turnsToLose <= 0) ifTrue:  [ ^true ].
	^false.
]

{ #category : #asserting }
SpaceShip >> canProvideToAnAlly: anAmountOfFuel [
	fuelTank currentFuel > anAmountOfFuel ifTrue: [ ^true ].
	^false.
]

{ #category : #playing }
SpaceShip >> changeRollingResultNeededToMove: aNumber [

	needsToThrow := aNumber
]

{ #category : #accessing }
SpaceShip >> checkForRollInHyperGravity: rolledNumber [
    (needsToThrow = 0 or: [ rolledNumber = needsToThrow ]) ifTrue: [
        needsToThrow := 0
    ] ifFalse: [
        self decreaseATurbine 
    ].
]

{ #category : #playing }
SpaceShip >> decreaseATurbine [
	turbines := turbines - 1.
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
SpaceShip >> handleAllyFuelForMovePositionBy: aNumber lapBy: quantityOfLapsToMove [

	(ally canProvideToAnAlly: fuelTank currentFuel abs)
		ifTrue: [
			ally decreaseFuelBy: fuelTank currentFuel abs.
			fuelTank fuel: 0.
			self moveToNextPositionBy: aNumber lapBy: quantityOfLapsToMove ]
		ifFalse: [
			ally applyPenaltyForEmptyFuelTank.
			self applyPenaltyForEmptyFuelTank ]
]

{ #category : #playing }
SpaceShip >> handleEmptyFuelTankForMovePositionBy: aNumber lapBy: quantityOfLapsToMove [

	ally ifNil: [ self applyPenaltyForEmptyFuelTank ] ifNotNil: [
		self
			handleAllyFuelForMovePositionBy: aNumber
			lapBy: quantityOfLapsToMove ]
]

{ #category : #initialization }
SpaceShip >> initialize: aName withMaxFuel: anAmount [

	owner := aName.
	position := 1.
	lap := 1.
	turnsToLose := 0.
	needsToThrow := 0.
	turbines:=3.
	fuelTank := FuelTank withMaxFuel: anAmount.
	ally := nil
]

{ #category : #asserting }
SpaceShip >> isAlliedWith: anotherSpaceship [

	ally := anotherSpaceship
]

{ #category : #'accessing - arguments' }
SpaceShip >> lap [

	^ lap
]

{ #category : #playing }
SpaceShip >> losesTurns: amountOfTurns [

	turnsToLose := turnsToLose + amountOfTurns
]

{ #category : #playing }
SpaceShip >> movePositionBy: aNumber lapBy: quantityOfLapsToMove neededFuel: aFuelAmount [

	needsToThrow = 0 ifFalse: [ ^ self ].
	self decreaseFuelBy: aFuelAmount.

	fuelTank isEmpty
		ifTrue: [
			self
				handleEmptyFuelTankForMovePositionBy: aNumber
				lapBy: quantityOfLapsToMove ]
		ifFalse: [
		self moveToNextPositionBy: aNumber lapBy: quantityOfLapsToMove ]
]

{ #category : #playing }
SpaceShip >> moveToNextPositionBy: aNumber lapBy: quantityOfLapsToMove [

	position := position + aNumber.
	lap := lap + quantityOfLapsToMove
]

{ #category : #accessing }
SpaceShip >> owner [

	^ owner
]

{ #category : #'accessing - arguments' }
SpaceShip >> position [

	^ position
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

{ #category : #accessing }
SpaceShip >> turbine [

	^ turbines
]
