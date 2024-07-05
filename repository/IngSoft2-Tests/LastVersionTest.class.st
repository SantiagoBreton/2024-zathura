Class {
	#name : #LastVersionTest,
	#superclass : #GameTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
LastVersionTest >> testLV01ShipsAreInitializeWithThreeTurbines [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := #( 'Danny' 'Walter' ).
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aDie1 := LoadedDie of: {3}.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 3.
		
	
]

{ #category : #tests }
LastVersionTest >> testLV02IfAShipRunsOutOfFuelItLoosesATurbine [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := #( 'Danny' 'Walter' ).
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aDie1 := LoadedDie of: {3. 1. 3. 1. 3. 4}.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).
	aGame playNextTurn.
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 3.
	self assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel equals: 5.
	
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 7.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 3.
	self assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel equals: 2.
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 3.
	self assert: (aGame spaceshipCalled: 'Danny') fuelTank currentFuel equals: 8.
		
	
]

{ #category : #tests }
LastVersionTest >> testLV03IfAShipTriestoEscapeFromAnHyperGravityAndItCantItLoosesATurbine [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := #( 'Danny' 'Walter' ).
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          (HyperGravity needsToThrow: 4).
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aDie1 := LoadedDie of: {3. 1. 2. 1. 4. 12}.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).
	aGame playNextTurn.
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 3.
	
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 3.
	
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 3.

		
	
]
