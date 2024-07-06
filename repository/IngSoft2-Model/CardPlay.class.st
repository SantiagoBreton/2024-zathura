Class {
	#name : #CardPlay,
	#superclass : #Object,
	#instVars : [
		'card',
		'cardPlayer',
		'cardTarget'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardPlay class >> a:card wasPlayedBy:aPlayer targetting:aTarget [
	^self new initializewith:card playedBy:aPlayer targetting:aTarget.
]

{ #category : #comparing }
CardPlay >> =anotherCardPlay [
	^ self hash = anotherCardPlay hash and: self class = anotherCardPlay class
]

{ #category : #comparing }
CardPlay >> =anotherCardPlay [
	^ self hash = anotherCardPlay hash and: self class = anotherCardPlay class
]

{ #category : #'as yet unclassified' }
CardPlay >> cancelEffectUsing: aCardPlayManager [
	card cancelEffectUsing: aCardPlayManager  playedBy: cardPlayer  targetting: cardTarget  .
]

{ #category : #'as yet unclassified' }
CardPlay >> hash [ 

	^ (cardPlayer hash + card hash + cardTarget hash)
]

{ #category : #'as yet unclassified' }
CardPlay >> initializewith:aCard playedBy:aPlayer targetting:aTarget [
	card:=aCard.
	cardPlayer:=aPlayer.
	cardTarget:=aTarget.
]
