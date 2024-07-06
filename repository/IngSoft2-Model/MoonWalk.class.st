Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'tilesToMove',
		'reversePolarity'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalk class >> backwardDistance: anAmountOfTiles [

	^ self new initializedWith: anAmountOfTiles 
]

{ #category : #initialization }
MoonWalk >> initializedWith: anAmountOfTiles [

	tilesToMove := 0 - anAmountOfTiles.
	reversePolarity:=false.
]

{ #category : #'as yet unclassified' }
MoonWalk >> reversePolarity [ 
	reversePolarity := reversePolarity not.
]

{ #category : #playing }
MoonWalk >> triggeredBy: aSpaceship on: anEffectManager [

	anEffectManager
		applyMoonwalkMoving: tilesToMove
		notAffecting: aSpaceship
]
