Class {
	#name : #Wormhole,
	#superclass : #Effect,
	#instVars : [
		'reversePolarity',
		'tileToTeleport'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Wormhole class >> assertAtLeastTwoWormholes: positionOfTheWormholes [

	positionOfTheWormholes size = 2 ifFalse: [
		Error signal: 'Cannot create a single wormhole' ]
]

{ #category : #'instance creation' }
Wormhole class >> betweenTiles: positionOfTheWormholes [

	self assertAtLeastTwoWormholes: positionOfTheWormholes.
	^ self new initialize:positionOfTheWormholes last 
]

{ #category : #initialization }
Wormhole >> initialize: aTileToTeleportTo [

	tileToTeleport  := aTileToTeleportTo.
	reversePolarity:=false.
]

{ #category : #'as yet unclassified' }
Wormhole >> reversePolarity [ 
	reversePolarity := reversePolarity not.
]

{ #category : #playing }
Wormhole >> triggeredBy: aSpaceship on: anEffectManager [

	reversePolarity
		ifTrue: [
		anEffectManager teleportAllBut: aSpaceship to: tileToTeleport ]
		ifFalse: [ anEffectManager teleport: aSpaceship to: tileToTeleport ]
]
