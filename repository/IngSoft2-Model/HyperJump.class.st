Class {
	#name : #HyperJump,
	#superclass : #Effect,
	#instVars : [
		'distances',
		'reversePolarity'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJump class >> of: distances [

	^ self new initializeOf: distances
]

{ #category : #'instance creation' }
HyperJump >> initializeOf: groupOfDistances [

	distances := groupOfDistances asOrderedCollection.
	reversePolarity:=false.
]

{ #category : #'as yet unclassified' }
HyperJump >> nextJumpValue [

	| valueAsParsec |
	valueAsParsec := (distances at: 1) valueAsParsecs.
	distances add: distances first.
	distances removeFirst.
	^ valueAsParsec
]

{ #category : #'as yet unclassified' }
HyperJump >> reversePolarity [ 
	reversePolarity := reversePolarity not.
]

{ #category : #playing }
HyperJump >> triggerReversePolarityEffectBy:aSpaceship on: anEffectManager [
	| valueAsParsec |
	valueAsParsec := self nextJumpValue.
	anEffectManager moveAllBut: aSpaceship jumping: valueAsParsec
]

{ #category : #playing }
HyperJump >> triggeredBy: aSpaceship on: anEffectManager [

	| valueAsParsec |
	valueAsParsec := self nextJumpValue.

	 anEffectManager move: aSpaceship jumping: valueAsParsec 
]
