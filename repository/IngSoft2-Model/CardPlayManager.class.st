Class {
	#name : #CardPlayManager,
	#superclass : #Object,
	#instVars : [
		'game',
		'lastCardPlayed',
		'cardPlayer',
		'cardTarget',
		'cardPlays',
		'cardHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardPlayManager class >> with: aGame [

	^ self new initializeWith: aGame
]

{ #category : #'instance creation' }
CardPlayManager class >> with: aGame having: cardsHands [

	^ self new initializeWith: aGame having:cardsHands.
]

{ #category : #resolving }
CardPlayManager >> addNewCard: aCard to:aPlayer [
	(self cardsHandOf: aPlayer)  addToHand: aCard.
]

{ #category : #resolving }
CardPlayManager >> cancelAnAccelerationCard: aCard [
	cardHands do:[:cardHand | cardHand removeEffectOf: AccelerationCard new]
]

{ #category : #resolving }
CardPlayManager >> cancelAnAllyCardPlayedBy: aPlayer targetting: anotherPlayer [
	game cancelAllianceBetween: aPlayer and: anotherPlayer
	
]

{ #category : #resolving }
CardPlayManager >> cancelAnOverloadCardTargetting: aPlayer [
	(self cardsHandOf: aPlayer) removeEffectOf: OverloadCard new.
]

{ #category : #resolving }
CardPlayManager >> cardsHandOf: aPlayer [

	| aPlayerHand |
	aPlayerHand := cardHands detect: [ :handler |
		                        handler player = aPlayer ].
	^ aPlayerHand
]

{ #category : #initialization }
CardPlayManager >> diceEffectApplyingTo:aPlayer [
	^ (self cardsHandOf: aPlayer ) totalEffectsOnSpaceShip

]

{ #category : #initialization }
CardPlayManager >> initializeWith: aGame having:aCardsHands [

	game := aGame.
	cardHands:=aCardsHands .
	cardPlays:= OrderedCollection new .
]

{ #category : #resolving }
CardPlayManager >> removeFromHand: aCard to: aSpaceShip [

	(self cardsHandOf:  aSpaceShip)
		removeFromHand: aCard
]

{ #category : #resolving }
CardPlayManager >> resolve: aCardPlayed by: aPlayer targetting: anotherPlayer [

	cardPlayer := aPlayer.
	cardTarget := anotherPlayer.
	cardPlays add: (CardPlay a: aCardPlayed  wasPlayedBy: aPlayer targetting:anotherPlayer ).
	
	aCardPlayed uses: self
]

{ #category : #resolving }
CardPlayManager >> resolveACancellationCardPlay: aCard [
	|cardPlayToCancel|
	cardPlayToCancel:=cardPlays detect:  [ :cardPlay | cardPlay = cardTarget  ].
	cardPlayToCancel cancelEffectUsing: self.
	cardPlays remove:cardPlayToCancel.
	lastCardPlayed := aCard.
	self removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayManager >> resolveARedoCardPlay: aCard [

	self addNewCard: lastCardPlayed to: cardPlayer.
	self removeFromHand: aCard to: cardPlayer.
	game play: lastCardPlayed by: cardPlayer targetting: cardTarget.
	
]

{ #category : #resolving }
CardPlayManager >> resolveARepeatCardPlay: aCard [

	game repeatLastEffectAppliedOn: cardTarget.
	lastCardPlayed := aCard.
	self removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayManager >> resolveAReversePolarityCardPlay:aCard [
	
	
	game assertIsTurnOf: cardPlayer.
	game reversePolarityOfEffectAtTile: cardTarget.
	lastCardPlayed := aCard.
	self removeFromHand: aCard to: cardPlayer.
]

{ #category : #resolving }
CardPlayManager >> resolveAnAccelerationCardPlay:aCard [
	
	
	game assertIsTurnOf: cardPlayer.
	cardHands do:[:cardHand| cardHand addEffectOf: aCard ] .
	lastCardPlayed := aCard.
	self removeFromHand: aCard to: cardPlayer.
]

{ #category : #resolving }
CardPlayManager >> resolveAnAllyCardPlay: aCard [

	game assertIsTurnOf: cardPlayer.
	game setAnAllianceBewtween: cardPlayer and: cardTarget.
	lastCardPlayed := aCard.
	self removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayManager >> resolveAnOverloadCardPlay: aCard [

	game assertIsTurnOf: cardPlayer.
	(self cardsHandOf: cardTarget) addEffectOf: aCard .
	lastCardPlayed := aCard.
	self removeFromHand: aCard to: cardPlayer
]
