Class {
	#name : #HyperGravity,
	#superclass : #Effect,
	#instVars : [
		'needsToThrow',
		'reversePolarity'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperGravity class >> needsToThrow: aRollingResult [

	^ self new initializedWith: aRollingResult
]

{ #category : #initialization }
HyperGravity >> initializedWith: aNumber [

	needsToThrow := aNumber.
	reversePolarity:=false.
]

{ #category : #'as yet unclassified' }
HyperGravity >> reversePolarity [ 
	reversePolarity := reversePolarity not.
]

{ #category : #playing }
HyperGravity >> triggeredBy: aSpaceship on: anEffectManager [
	
	reversePolarity ifTrue: [ anEffectManager applyHyperGravityEffectOf: needsToThrow toAllShipsBut: aSpaceship ] ifFalse:[anEffectManager applyHyperGravityEffectOf: needsToThrow to: aSpaceship ]. 
	
]
