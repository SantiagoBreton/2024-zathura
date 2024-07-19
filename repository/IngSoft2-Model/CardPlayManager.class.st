Class {
	#name : #CardPlayManager,
	#superclass : #Object,
	#instVars : [
		'game',
		'lastCardPlayed',
		'cardPlayer',
		'cardTarget',
		'cardPlays',
		'allPlayersHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardPlayManager class >> with: aGame having: cardsHands [

	^ self new initializeWith: aGame having:cardsHands.
]

{ #category : #resolving }
CardPlayManager >> addNewCard: aCard to:aPlayer [
	(self handOf: aPlayer)  addToHand: aCard.
]

{ #category : #resolving }
CardPlayManager >> cancelAReversePolarityCardTargetting: aTarget [
	
	game reversePolarityOfEffectAtTile: aTarget.

]

{ #category : #resolving }
CardPlayManager >> cancelAnAccelerationCard: aCard [
	allPlayersHands do:[:playerHand | playerHand removeEffectOf: AccelerationCard new]
]

{ #category : #resolving }
CardPlayManager >> cancelAnAllyCardPlayedBy: aPlayer targetting: anotherPlayer [
	game cancelAllianceBetween: aPlayer and: anotherPlayer
	
]

{ #category : #resolving }
CardPlayManager >> cancelAnOverloadCardTargetting: aPlayer [
	(self handOf: aPlayer) removeEffectOf: OverloadCard new.
]

{ #category : #initialization }
CardPlayManager >> diceEffectApplyingTo:aPlayer [
	^ (self handOf: aPlayer ) totalEffectsOnPlayer

]

{ #category : #resolving }
CardPlayManager >> handOf: aPlayer [

	| aPlayerHand |
	aPlayerHand := allPlayersHands detect: [ :playerHand |
		                        playerHand player = aPlayer ].
	^ aPlayerHand
]

{ #category : #resolving }
CardPlayManager >> handleWrongCancellationCard [
	Error signal: 'There is no CardPlay matching the one tried to be cancelled'.
	cardPlays removeLast .
]

{ #category : #initialization }
CardPlayManager >> initializeWith: aGame having:anAllPlayersHands [

	game := aGame.
	allPlayersHands:=anAllPlayersHands .
	cardPlays:= OrderedCollection new .
]

{ #category : #resolving }
CardPlayManager >> removeFromHand: aCard to: aPlayer [

	(self handOf:  aPlayer)
		removeFromHand: aCard
]

{ #category : #resolving }
CardPlayManager >> resolve: aCardPlayed by: aPlayer targetting: aTarget [
	self validate: aPlayer  has: aCardPlayed.
	cardPlayer := aPlayer.
	cardTarget := aTarget.
	
	aCardPlayed uses: self.
	cardPlays add: (CardPlay a: aCardPlayed  wasPlayedBy: aPlayer targetting: aTarget ).
]

{ #category : #resolving }
CardPlayManager >> resolveACancellationCardPlay: aCard [
	|cardPlayToCancel|

	cardPlayToCancel:=cardPlays detect:  [ :cardPlay | cardPlay = cardTarget  ] ifNone: [ self handleWrongCancellationCard ].
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
	cardPlays removeLast.
	
	
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
	allPlayersHands do:[:cardHand| cardHand addEffectOf: aCard ] .
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
	(self handOf: cardTarget) addEffectOf: aCard .
	lastCardPlayed := aCard.
	self removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayManager >> validate: aPlayer has: aCard [

	| cardsHand |
	cardsHand := self handOf: aPlayer .
	(cardsHand hasInHand: aCard) ifFalse: [
		Error signal:
			'Spaceship cannot throw this card because he does not have it' ]
]
