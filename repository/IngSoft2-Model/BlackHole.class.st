Class {
	#name : #BlackHole,
	#superclass : #Effect,
	#instVars : [
		'reversePolarity'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
BlackHole class >> create [
	^self new initialize
]

{ #category : #initialization }
BlackHole >> initialize [
	reversePolarity:=false.
]

{ #category : #'as yet unclassified' }
BlackHole >> pol [ 
	^reversePolarity 
]

{ #category : #'as yet unclassified' }
BlackHole >> reversePolarity [ 
	reversePolarity := reversePolarity not.
]

{ #category : #playing }
BlackHole >> triggeredBy: aSpaceship on: anEffectManager [

	reversePolarity
		ifTrue: [ anEffectManager applyBlackHoleEffectToAllBut: aSpaceship ]
		ifFalse: [anEffectManager applyBlackHoleEffectTo: aSpaceship  ]
]
