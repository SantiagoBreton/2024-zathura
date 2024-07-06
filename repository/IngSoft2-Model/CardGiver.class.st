Class {
	#name : #CardGiver,
	#superclass : #Effect,
	#instVars : [
		'reversePolarity'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
CardGiver class >> create [
	^self new initialize
]

{ #category : #initialization }
CardGiver >> initialize [
	reversePolarity:=false.
]

{ #category : #'as yet unclassified' }
CardGiver >> reversePolarity [ 
	reversePolarity := reversePolarity not.
]

{ #category : #playing }
CardGiver >> triggeredBy: aSpaceship on: anEffectManager [

	reversePolarity
		ifTrue: [  anEffectManager giveCardFromDeckToAllBut: aSpaceship ]
		ifFalse: [ anEffectManager giveCardFromDeckTo: aSpaceship ]
]
