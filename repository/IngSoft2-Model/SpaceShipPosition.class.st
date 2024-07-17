Class {
	#name : #SpaceShipPosition,
	#superclass : #Object,
	#instVars : [
		'tileNumber',
		'lap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
SpaceShipPosition class >> create [
	^self new initilizeNewPosition.
]

{ #category : #'as yet unclassified' }
SpaceShipPosition >> initilizeNewPosition [
	tileNumber := 1.
	lap :=1.
]

{ #category : #'as yet unclassified' }
SpaceShipPosition >> lap [
	^lap
]

{ #category : #'as yet unclassified' }
SpaceShipPosition >> resetPosition [
	tileNumber :=1.
]

{ #category : #'as yet unclassified' }
SpaceShipPosition >> tileNumber [
	^tileNumber
]

{ #category : #'as yet unclassified' }
SpaceShipPosition >> updateLapBy: aLap [
	lap := lap + aLap .
]

{ #category : #'as yet unclassified' }
SpaceShipPosition >> updateTileNumberBy: aTile [
	tileNumber :=tileNumber + aTile.
]
