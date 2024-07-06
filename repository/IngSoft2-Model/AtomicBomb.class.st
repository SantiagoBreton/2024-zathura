Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#instVars : [
		'reversePolarity'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
AtomicBomb class >> create [
	^self new initialize
]

{ #category : #initialization }
AtomicBomb >> initialize [
	reversePolarity:=false.
]

{ #category : #'as yet unclassified' }
AtomicBomb >> reversePolarity [ 
	reversePolarity := reversePolarity not.
]

{ #category : #'as yet unclassified' }
AtomicBomb >> triggerReversePolarityEffectBy:aSpaceship on: anEffectManager [
]

{ #category : #playing }
AtomicBomb >> triggeredBy: aSpaceship on: anEffectManager [
	reversePolarity ifFalse:  [anEffectManager moveAllSpaceshipsToFirstPosition  ].
	
]
