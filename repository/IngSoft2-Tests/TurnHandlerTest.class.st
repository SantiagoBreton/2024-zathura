Class {
	#name : #TurnHandlerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
TurnHandlerTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
TurnHandlerTest >> testATurnHandlerCanBeCreatedWithSomePlayers [

	| aTurnHandler aSpaceShip |
	aSpaceShip := SpaceShip ownedBy: 'Danny' withMaxFuel: 10.
	aTurnHandler := TurnHandler withPlayers: { aSpaceShip }.
	self assert: aTurnHandler spaceships first owner equals: 'Danny'
]

{ #category : #tests }
TurnHandlerTest >> testATurnHandlerCannotBeCreatedWithoutPlayers [

	self
		should: [ TurnHandler withPlayers: {  } ]
		raise: Error
		withMessage: 'Game must have at least one player'
]

{ #category : #tests }
TurnHandlerTest >> testPlayer1throwsfirst [

	| aTurnHandler aSpaceShip1 aSpaceShip2 |
	aSpaceShip1 := SpaceShip ownedBy: 'Danny' withMaxFuel: 10.
	aSpaceShip2 := SpaceShip ownedBy: 'Walter' withMaxFuel: 10.
	aTurnHandler := TurnHandler withPlayers: {
			                aSpaceShip1.
			                aSpaceShip2 }.
	self assert: aTurnHandler nextSpaceshipTurn owner equals: 'Danny'
]

{ #category : #tests }
TurnHandlerTest >> testPlayer2throwsAfterPlayer1 [

	| aTurnHandler aSpaceShip1 aSpaceShip2 |
	aSpaceShip1 := SpaceShip ownedBy: 'Danny' withMaxFuel: 10.
	aSpaceShip2 := SpaceShip ownedBy: 'Walter' withMaxFuel: 10.
	aTurnHandler := TurnHandler withPlayers: {
			                aSpaceShip1.
			                aSpaceShip2 }.
	aTurnHandler nextSpaceshipTurn.
	self assert: aTurnHandler nextSpaceshipTurn owner equals: 'Walter'
]
