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
CardPlayManager >> addNewCard: aCard to: aPlayer [

	(self handOf: aPlayer) addToHand: aCard
]

{ #category : #cancelling }
CardPlayManager >> cancelACardEffectAppliedToAllPlayers: aCard [

	allPlayersHands do: [ :playerHand | playerHand removeEffectOf: aCard ]
]

{ #category : #cancelling }
CardPlayManager >> cancelAnAllyCardPlayedBy: aPlayer targetting: anotherPlayer [

	game cancelAllianceBetween: aPlayer and: anotherPlayer
]

{ #category : #cancelling }
CardPlayManager >> cancelTheEffectOf: aCard appliedTo: aPlayer [

	(self handOf: aPlayer) removeEffectOf: aCard
]

{ #category : #playing }
CardPlayManager >> diceEffectApplyingTo: aPlayer [

	^ (self handOf: aPlayer) totalEffectsOnPlayer
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

	Error signal:
		'There is no CardPlay matching the one tried to be cancelled'.
	cardPlays removeLast
]

{ #category : #initialization }
CardPlayManager >> initializeWith: aGame having: anAllPlayersHands [

	game := aGame.
	allPlayersHands := anAllPlayersHands.
	cardPlays := OrderedCollection new
]

{ #category : #resolving }
CardPlayManager >> removeFromHand: aCard to: aPlayer [

	(self handOf: aPlayer) removeFromHand: aCard
]

{ #category : #resolving }
CardPlayManager >> resolve: aCardPlayed by: aPlayer targetting: aTarget [

	self validate: aPlayer has: aCardPlayed.
	cardPlayer := aPlayer.
	cardTarget := aTarget.
	cardPlays add:
		(CardPlay a: aCardPlayed wasPlayedBy: aPlayer targetting: aTarget).
	aCardPlayed uses: self.

	self removeFromHand: aCardPlayed to: aPlayer.
]

{ #category : #resolving }
CardPlayManager >> resolveACancellationCardPlay: aCard [

	| cardPlayToCancel |
	cardPlayToCancel := cardPlays
		                    detect: [ :cardPlay | cardPlay = cardTarget ]
		                    ifNone: [
			                    cardPlays removeLast.
			                    self handleWrongCancellationCard ].
	cardPlayToCancel cancelEffectUsing: self.
	cardPlays remove: cardPlayToCancel.
	lastCardPlayed := aCard
]

{ #category : #resolving }
CardPlayManager >> resolveARedoCardPlay: aCard [

	self addNewCard: lastCardPlayed to: cardPlayer.
	cardPlays removeLast.
	game play: lastCardPlayed by: cardPlayer targetting: cardTarget.
	
]

{ #category : #resolving }
CardPlayManager >> resolveARepeatCardPlay: aCard [

	game repeatLastEffectAppliedOn: cardTarget.
	lastCardPlayed := aCard
]

{ #category : #resolving }
CardPlayManager >> resolveAReversePolarityCardPlay: aCard [

	game reversePolarityOfEffectAtTile: cardTarget.
	lastCardPlayed := aCard.
]

{ #category : #resolving }
CardPlayManager >> resolveAnAccelerationCardPlay: aCard [

	allPlayersHands do: [ :cardHand | cardHand addEffectOf: aCard ].
	lastCardPlayed := aCard
]

{ #category : #resolving }
CardPlayManager >> resolveAnAllyCardPlay: aCard [

	game setAnAllianceBewtween: cardPlayer and: cardTarget.
	lastCardPlayed := aCard
]

{ #category : #resolving }
CardPlayManager >> resolveAnOverloadCardPlay: aCard [

	(self handOf: cardTarget) addEffectOf: aCard.
	lastCardPlayed := aCard
]

{ #category : #resolving }
CardPlayManager >> reversePolarityOfEffectAtTile: aTarget [

	game reversePolarityOfEffectAtTile: aTarget
]

{ #category : #validation }
CardPlayManager >> validate: aPlayer has: aCard [

	| cardsHand |
	cardsHand := self handOf: aPlayer.
	(cardsHand hasInHand: aCard) ifFalse: [
		Error signal:
			'Spaceship cannot throw this card because he does not have it' ]
]
