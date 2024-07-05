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

{ #category : #tests }
LastVersionTest >> testLV04IfAShipLandsInABlackHoleItLoosesATurbine [

	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := #( 'Danny' 'Walter' ).
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          BlackHole new.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aDie1 := LoadedDie of: { 5. 1. 2. 4. 4. 12 }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 2.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 3.

	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 2.


]

{ #category : #tests }
LastVersionTest >> testLV05IfAShipLoosesThenItCannotPlayAnymore [
	
	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := #( 'Danny' 'Walter' ).
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          (HyperGravity needsToThrow: 3).
				          Null create.
				          Null create.
				          BlackHole new }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aDie1 := LoadedDie of: {3. 1. 2. 1. 2. 2. 3. 1. 2. 1. 2. 4. 20}.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 3
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).
	aGame playNextTurn.
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 2.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 3.
	
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 3.
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 5.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 3.
	
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 6.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 0.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 3.
	self deny: (aGame spaceshipCalled: 'Danny') canPlay .
	aGame playNextTurn .
	aGame playNextTurn .
	aGame playNextTurn .
	aGame playNextTurn .
	
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 3.
	self assert: (aGame spaceshipCalled: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 0.
	self deny: (aGame spaceshipCalled: 'Danny') canPlay.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') lap equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') canPlay.
	
	

		
	


]

{ #category : #tests }
LastVersionTest >> testLV06IfAllShipsLooseTheirTurbinesThenTheGameHasEnded [
	
	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := #( 'Danny' 'Walter' ).
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          (HyperGravity needsToThrow: 3).
				          BlackHole new.
				          Null create
				           }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aDie1 := LoadedDie of: {3. 4. 2. 4. 2. 4. 1. 1. 2. 1. 2. 4. 20}.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 3
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).
	aGame playNextTurn.
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 2.
	
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 1.
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 0.
	
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 0.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 0.
	self assert: aGame hasEnded 
		
	


]

{ #category : #tests }
LastVersionTest >> testLV07IfAllShipsLooseTheirTurbinesThenTheWinnerIsTheOneClosestToTheEnd [
	
	| aGame aBoard aDie1 someSpaceships |
	someSpaceships := #( 'Danny' 'Walter' ).
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          (HyperGravity needsToThrow: 3).
				          BlackHole new.
				          Null create
				           }
		          withUnitsOfMeasurement: (Parsecs with: 10).

	aDie1 := LoadedDie of: {3. 4. 2. 4. 2. 4. 1. 1. 2. 1. 2. 4. 20}.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 3
		         rolling: aDie1
		         usingCardsFrom: (Deck of: { 'card1'. 'card2' }).
	aGame playNextTurn.
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 3.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 2.
	
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 1.
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 1.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 0.
	
	aGame playNextTurn .
	self assert: (aGame spaceshipCalled: 'Danny') position equals: 4.
	self assert: (aGame spaceshipCalled: 'Walter') position equals: 1.
	self assert: (aGame spaceshipCalled: 'Danny') turbine equals: 0.
	self assert: (aGame spaceshipCalled: 'Walter') turbine equals: 0.
	self assert: aGame hasEnded .

		
	


]
