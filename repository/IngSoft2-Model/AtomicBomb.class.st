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

{ #category : #playing }
AtomicBomb >> triggeredBy: aSpaceship on: anEffectManager [

	anEffectManager moveAllSpaceshipsToFirstPosition
]
