Class {
	#name : #Null,
	#superclass : #Effect,
	#instVars : [
		'reversePolarity'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Null class >> create [

	^ self new initialize.
]

{ #category : #initialization }
Null >> initialize [
	reversePolarity:=false.

	
]

{ #category : #'as yet unclassified' }
Null >> reversePolarity [ 
	reversePolarity := reversePolarity not.
]

{ #category : #playing }
Null >> triggeredBy: aSpaceship on: anEffectManager [

	
]
