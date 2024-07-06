Class {
	#name : #CardPlayManager,
	#superclass : #Object,
	#instVars : [
		'game',
		'lastCardPlayed',
		'cardPlayer',
		'cardTarget'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardPlayManager class >> with: aGame [

	^ self new initializeWith: aGame
]

{ #category : #resolving }
CardPlayManager >> cancelAnAccelerationCard: aCard [
	game cancelTheEffectOf: aCard
]

{ #category : #resolving }
CardPlayManager >> cancelAnAllyCard: aCard [

game setAllyToNil.
]

{ #category : #resolving }
CardPlayManager >> cancelAnOverloadCard: aCard [
	game cancelTheEffectOf:aCard
]

{ #category : #initialization }
CardPlayManager >> initializeWith: aGame [

	game := aGame
]

{ #category : #resolving }
CardPlayManager >> resolve: aCardPlayed by: aPlayer targetting: anotherPalyer [

	cardPlayer := aPlayer.
	cardTarget := anotherPalyer.
	aCardPlayed uses: self
]

{ #category : #resolving }
CardPlayManager >> resolveACancellationCardPlay: aCard [

	
	cardTarget cancelEffectUsing:self.
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
