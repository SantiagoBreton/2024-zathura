Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'spaceships',
		'diceCollection',
		'hasEnded',
		'turnHandler',
		'deck',
		'effectManager',
		'cardPlayManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Game class >> assertValidNumberOf: someSpaceShips [

	someSpaceShips isEmpty ifTrue: [
		Error signal: 'Game must have at least one player' ]
]

{ #category : #'instance creation' }
Game class >> assertValidNumberOfLaps: laps [

	laps <= 0 ifTrue: [ Error signal: 'Game must have one or more laps!' ]
]

{ #category : #'instance creation' }
Game class >> createSpaceshipsUsing: spaceshipNames withMaxFuel: anAmount [

	^ spaceshipNames collect: [ :spaceship |
		  SpaceShip ownedBy: spaceship withMaxFuel: 2 * anAmount ]
]

{ #category : #'instance creation' }
Game class >> playedBy: someSpaceShips on: aBoard finishingAfter: laps rolling: dice usingCardsFrom: aDeck [

	| currentSpaceships |
	currentSpaceships := self
		                     createSpaceshipsUsing: someSpaceShips
		                     withMaxFuel: dice maxRoll.
	self assertValidNumberOf: currentSpaceships.
	self assertValidNumberOfLaps: laps.
	^ self new
		  initializePlayedBy: currentSpaceships
		  on: aBoard
		  finishingAfter: laps
		  rolling: dice
		  usingCardsFrom: aDeck
]

{ #category : #accessing }
Game >> anySpaceShipAtLastTileAndLap [

	^ spaceships anySatisfy: [ :aSpaceship |
		  board laps + 1 = aSpaceship lap and: [ 1 = aSpaceship tileNumber ] ]
]

{ #category : #asserting }
Game >> assertIsTurnOf: aPlayer [

	turnHandler nextTurn = (self spaceshipOwnedBy: aPlayer) ifFalse: [
		Error signal: 'It is not your turn' ]
]

{ #category : #asserting }
Game >> assignRewardForMaxRollFor: aSpaceship [

	| adjustmentDistribution randomNumber |
	adjustmentDistribution := { 1. 1. 1. 1. 1. 1. 1. 1. -1. -1 }.

	randomNumber := adjustmentDistribution atRandom.
	randomNumber = 1
		ifTrue: [ aSpaceship fuelTank increaseMaxFuelByOne ]
		ifFalse: [ aSpaceship fuelTank decreaseFuelBy: 1 ]

]

{ #category : #initialization }
Game >> cancelAllianceBetween: aPlayer and: anotherPlayer [
	(self spaceshipOwnedBy: aPlayer ) setAllyToNil .
	(self spaceshipOwnedBy: anotherPlayer ) setAllyToNil .
	

]

{ #category : #asserting }
Game >> checkIf: spaceshipTurn isRewardedWhenRolling: rollingResult [

	rollingResult = diceCollection maxRoll ifTrue: [
		self assignRewardForMaxRollFor: spaceshipTurn ]
]

{ #category : #asserting }
Game >> endGameIfPossible [

	self anySpaceShipAtLastTileAndLap ifTrue: [ hasEnded := true ].

	(spaceships anySatisfy: [ :aSpaceship | aSpaceship canPlay ])
		ifFalse: [ hasEnded := true ]
]

{ #category : #playing }
Game >> giveCardFromDeckTo: aSpaceship [

	| card |
	card := deck pick.
	cardPlayManager addNewCard: card to: aSpaceship owner
]

{ #category : #testing }
Game >> handOf: aPlayer [

	^ cardPlayManager handOf: aPlayer
]

{ #category : #testing }
Game >> hasEnded [

	^ hasEnded
]

{ #category : #initialization }
Game >> initializePlayedBy: someSpaceShips on: aBoard finishingAfter: laps rolling: dice usingCardsFrom: aDeck [

	| cardHands |
	board := aBoard.
	diceCollection := dice.
	spaceships := someSpaceShips.
	hasEnded := false.
	deck := aDeck.
	board finishesAfter: laps.
	cardHands := spaceships collect: [ :spaceShip |
		             PlayerHand of: spaceShip using: aDeck ].
	cardPlayManager := CardPlayManager with: self having: cardHands.
	turnHandler := TurnHandler withPlayers: someSpaceShips.
	effectManager := EffectManager
		                 usedIn: self
		                 with: aBoard
		                 affecting: someSpaceShips
]

{ #category : #'target resize' }
Game >> play: aCard by: aPlayer targetting: aTarget [

	aCard canBePlayedAtAnyTime ifFalse: [ self assertIsTurnOf: aPlayer ].
	cardPlayManager resolve: aCard by: aPlayer targetting: aTarget.
	cardPlayManager removeFromHand: aCard to: aPlayer
]

{ #category : #playing }
Game >> playNextTurn [

	| rollingResult spaceshipTurn rollModifier |
	self hasEnded ifTrue: [ Error signal: 'Game has already ended' ].
	spaceshipTurn := turnHandler nextSpaceshipTurn.
	rollingResult := spaceshipTurn rollDiceUsing: diceCollection.
	self checkIf: spaceshipTurn isRewardedWhenRolling: rollingResult.
	rollModifier := cardPlayManager diceEffectApplyingTo: spaceshipTurn owner.
	board move: spaceshipTurn by: rollingResult + rollModifier.
	board triggerLandingEffectFor:spaceshipTurn using: effectManager .
	"effectManager applyEffectOnLandingShip: spaceshipTurn."
	self endGameIfPossible
]

{ #category : #accessing }
Game >> repeatLastEffectAppliedOn: aPlayer [

	effectManager repeatLastEffectAppliedOn:
		(self spaceshipOwnedBy: aPlayer)
]

{ #category : #testing }
Game >> reversePolarityOfEffectAtTile: aNumber [

	board reversePolarityOfEffectAtTile: aNumber
]

{ #category : #'target resize' }
Game >> setAnAllianceBewtween: aPlayer and: anotherPlayer [

	| spaceship1 spaceship2 |
	spaceship1 := self spaceshipOwnedBy: aPlayer.
	spaceship2 := self spaceshipOwnedBy: anotherPlayer.

	spaceship1 makeAnAllianceWith: spaceship2.
	spaceship2 makeAnAllianceWith: spaceship1
]

{ #category : #asserting }
Game >> skipTurnFor: aSpaceship [

	aSpaceship skipTurn
]

{ #category : #accessing }
Game >> spaceShipsPositionsRanking [

	| spaceShipsPositions |
	spaceShipsPositions := spaceships.

	^ spaceShipsPositions asSortedCollection: [ :spaceShipA :spaceShipB |
		  spaceShipA >= spaceShipB ]
]

{ #category : #asserting }
Game >> spaceshipOwnedBy: aName [

	^ spaceships detect: [ :spaceship | spaceship owner = aName ]
]

{ #category : #asserting }
Game >> winner [

	| winner |
	self hasEnded ifFalse: [ ^ self hasEnded ].

	winner := self spaceShipsPositionsRanking first owner.
	^ winner
]
