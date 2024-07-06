Class {
	#name : #CardsHand,
	#superclass : #Object,
	#instVars : [
		'cardsInHand',
		'cardsAffecting',
		'player'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardsHand class >> of: aSpaceship using: aDeck [

	^ self new initializeOf: aSpaceship using: aDeck
]

{ #category : #adding }
CardsHand >> addEffectOf: aCard [

	cardsAffecting add: aCard
]

{ #category : #adding }
CardsHand >> addToHand: aCard [

	cardsInHand add: aCard
]

{ #category : #asserting }
CardsHand >> affectsSpaceShip: aCard [

	^ cardsAffecting includes: aCard
]

{ #category : #accessing }
CardsHand >> cardsInHand [

	^ cardsInHand
]

{ #category : #initialization }
CardsHand >> distributeCardsFrom: aDeck [

	self addToHand: aDeck pick.
	self addToHand: aDeck pick
]

{ #category : #accessing }
CardsHand >> hasInHand: aCard [

	^ cardsInHand includes: aCard
]

{ #category : #initialization }
CardsHand >> initializeOf: aSpaceship using: aDeck [

	player := aSpaceship name.
	cardsInHand := OrderedCollection new.
	cardsAffecting := OrderedCollection new.
	self distributeCardsFrom: aDeck
]

{ #category : #accessing }
CardsHand >> player [

	^ player
]

{ #category : #removing }
CardsHand >> removeEffectOf: aCard [
	|cardToRemove|
	cardToRemove := cardsAffecting detect: [ :each | each = aCard ].
	cardsAffecting remove:cardToRemove.
	
]

{ #category : #removing }
CardsHand >> removeFromHand: aCard [

	cardsInHand remove: aCard
]

{ #category : #accessing }
CardsHand >> totalEffectsOnSpaceShip [

	cardsAffecting isEmpty ifTrue: [ ^ 0 ].
	^ cardsAffecting sum: [ :card | card effect ]
]
