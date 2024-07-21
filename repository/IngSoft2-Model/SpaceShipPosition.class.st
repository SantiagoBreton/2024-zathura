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
SpaceShipPosition class >> createAt:aTile and:aLap [
	^self new initilizewith: aTile and:aLap.
]

{ #category : #correcting }
SpaceShipPosition >> correctIfBeyond: maxLaps [

	lap >= maxLaps ifFalse: [ ^ self ].
	tileNumber := 1.
	lap := maxLaps
]

{ #category : #correcting }
SpaceShipPosition >> correctIfInNegativeLap [

	lap < 1 ifFalse: [ ^ self ].
	tileNumber := 1.
	lap := 1
]

{ #category : #'class initialization' }
SpaceShipPosition >> initilizewith: aTileNumber and: aLap [

	tileNumber := aTileNumber.
	lap := aLap.
	self correctIfInNegativeLap
]

{ #category : #'accessing - arguments' }
SpaceShipPosition >> lap [

	^ lap
]

{ #category : #playing }
SpaceShipPosition >> resetPosition [

	tileNumber := 1
]

{ #category : #'accessing - attributes' }
SpaceShipPosition >> tileNumber [

	^ tileNumber
]

{ #category : #calculating }
SpaceShipPosition >> totalAmountOfSquaresMovedWith: anAmountOfTilesPerLap [

	^ tileNumber + (lap - 1 * anAmountOfTilesPerLap)
]

{ #category : #calculating }
SpaceShipPosition >> totalTilesToMoveTo: anotherPostion withBoardSize: boardSize [

	^ ((self totalAmountOfSquaresMovedWith: boardSize)
	   - (anotherPostion totalAmountOfSquaresMovedWith: boardSize)) abs
]
