Class {
	#name : #PlayerHand,
	#superclass : #Object,
	#instVars : [
		'cardsInHand',
		'player',
		'cardsAffectingRoll'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PlayerHand class >> of: aSpaceship using: aDeck [

	^ self new initializeOf: aSpaceship using: aDeck
]

{ #category : #adding }
PlayerHand >> addEffectOf: aCard [

	cardsAffectingRoll add: aCard
]

{ #category : #adding }
PlayerHand >> addToHand: aCard [

	cardsInHand add: aCard
]

{ #category : #testing }
PlayerHand >> cardsInHand [

	^ cardsInHand
]

{ #category : #initialization }
PlayerHand >> distributeCardsFrom: aDeck [

	self addToHand: aDeck pick.
	self addToHand: aDeck pick
]

{ #category : #accessing }
PlayerHand >> hasInHand: aCard [

	^ cardsInHand includes: aCard
]

{ #category : #initialization }
PlayerHand >> initializeOf: aSpaceship using: aDeck [

	player := aSpaceship owner.
	cardsInHand := OrderedCollection new.
	cardsAffectingRoll := OrderedCollection new.
	self distributeCardsFrom: aDeck
]

{ #category : #accessing }
PlayerHand >> player [

	^ player
]

{ #category : #removing }
PlayerHand >> removeEffectOf: aCard [

	| cardToRemove |
	cardToRemove := cardsAffectingRoll detect: [ :each | each = aCard ].
	cardsAffectingRoll remove: cardToRemove
]

{ #category : #removing }
PlayerHand >> removeFromHand: aCard [

	cardsInHand remove: aCard
]

{ #category : #accessing }
PlayerHand >> totalEffectsOnPlayer [

	cardsAffectingRoll isEmpty ifTrue: [ ^ 0 ].
	^ cardsAffectingRoll sum: [ :card | card effect ]
]
