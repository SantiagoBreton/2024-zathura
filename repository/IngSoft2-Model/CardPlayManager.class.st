Class {
	#name : #CardPlayManager,
	#superclass : #Object,
	#instVars : [
		'game',
		'lastCardPlayed',
		'cardPlayer',
		'cardTarget',
		'cardPlays'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardPlayManager class >> with: aGame [

	^ self new initializeWith: aGame
]

{ #category : #resolving }
CardPlayManager >> cancelAnAccelerationCard: aCard [
	game cancelTheEffectOfAnAccelerationCard 
]

{ #category : #resolving }
CardPlayManager >> cancelAnAllyCardPlayedBy: aPlayer targetting: anotherPlayer [
	game cancelAllianceBetween: aPlayer and: anotherPlayer
	
]

{ #category : #resolving }
CardPlayManager >> cancelAnOverloadCardTargetting: aPlayer [
	game cancelTheEffectOfAnOverloadCardTargeting: aPlayer
]

{ #category : #initialization }
CardPlayManager >> initializeWith: aGame [

	game := aGame.
	cardPlays:= OrderedCollection new .
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
	game removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayManager >> resolveARedoCardPlay: aCard [

	game addNewCard: lastCardPlayed to: cardPlayer.
	game play: lastCardPlayed by: cardPlayer targetting: cardTarget.
	game removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayManager >> resolveARepeatCardPlay: aCard [

	game repeatLastEffectAppliedOn: cardTarget.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayManager >> resolveAReversePolarityCardPlay:aCard [
	
	
	game assertIsTurnOf: cardPlayer.
	game reversePolarityOfEffectAtTile: cardTarget.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer.
]

{ #category : #resolving }
CardPlayManager >> resolveAnAccelerationCardPlay:aCard [
	
	
	game assertIsTurnOf: cardPlayer.
	game applyToAllSpaceShips: aCard.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer.
]

{ #category : #resolving }
CardPlayManager >> resolveAnAllyCardPlay: aCard [

	game assertIsTurnOf: cardPlayer.
	game setAnAllianceBewtween: cardPlayer and: cardTarget.
	game applyACardEffect: aCard to: cardPlayer.
	game applyACardEffect: aCard to: cardTarget.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer
]

{ #category : #resolving }
CardPlayManager >> resolveAnOverloadCardPlay: aCard [

	game assertIsTurnOf: cardPlayer.
	game applyACardEffect: aCard to: cardTarget.
	lastCardPlayed := aCard.
	game removeFromHand: aCard to: cardPlayer
]
