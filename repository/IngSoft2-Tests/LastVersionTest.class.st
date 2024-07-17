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
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 3.
		
	
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
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Danny') fuelTank currentFuel equals: 5.
	
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 7.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Danny') fuelTank currentFuel equals: 2.
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Danny') fuelTank currentFuel equals: 8.
		
	
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
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 3.
	
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 3.
	
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 3.

		
	
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
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 2.
	aGame playNextTurn.
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 3.

	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 2.


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
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 3.
	
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 3.
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 5.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 3.
	
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 6.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 0.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 3.
	self deny: (aGame spaceshipOwnedBy: 'Danny') canPlay .
	aGame playNextTurn .
	aGame playNextTurn .
	aGame playNextTurn .
	aGame playNextTurn .
	
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Danny') lap equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 0.
	self deny: (aGame spaceshipOwnedBy: 'Danny') canPlay.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') lap equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') canPlay.
	
	

		
	


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
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 2.
	
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 1.
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 0.
	
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 0.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 0.
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
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 2.
	
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 1.
	aGame playNextTurn .
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 0.
	
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 0.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 0.
	self assert: aGame hasEnded .
	self assert: aGame winner equals:'Danny' .

		
	


]

{ #category : #tests }
LastVersionTest >> testLV08IfAPlayersPlaysTheReversePolarityCardOnABlackHoleItMovesAllThePlayerButTheOneWhoTriggeredIt [

	| aGame aBoard aDie1 someSpaceships aDeck aReversePolarityCard |
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          BlackHole new  }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 5. 5. 6. 2. 2. 2. 2. 2. 2. 2. 20 }.

	aReversePolarityCard := ReversePolarityCard new.

	aDeck := LoadedDeck of: {
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
						aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard. }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.
	
 
	
	aGame play: aReversePolarityCard  by: 'Danny'  targetting: 7.

	
	aGame playNextTurn .
	aGame playNextTurn .
	
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 6.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 6.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 1.
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 7.
	
	
	
	
	
	
		
]

{ #category : #tests }
LastVersionTest >> testLV09IfAPlayersPlaysTheReversePolarityCardOnABlackHoleAllThePlayerButTheOneWhoTriggeredItLoseATurbine [

	| aGame aBoard aDie1 someSpaceships aDeck aReversePolarityCard |
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          BlackHole new  }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 5. 5. 6. 2. 2. 2. 2. 2. 2. 2. 20 }.

	aReversePolarityCard := ReversePolarityCard new.

	aDeck := LoadedDeck of: {
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
						aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard. }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.
	
 
	
	aGame play: aReversePolarityCard  by: 'Danny'  targetting: 7.

	
	aGame playNextTurn .
	aGame playNextTurn .
	
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 6.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 6.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') turbine equals: 3.
	
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 7.
	self assert: (aGame spaceshipOwnedBy: 'Danny') turbine equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') turbine equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') turbine equals: 3.
	
	
	
	
	
	
		
]

{ #category : #tests }
LastVersionTest >> testLV10IfAPlayersPlaysTheReversePolarityCardOnAMoonwalkTheOneWhoLandsAtItMoves [

	| aGame aBoard aDie1 someSpaceships aDeck aReversePolarityCard |
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          (MoonWalk backwardDistance: 2).
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 5. 3. 6. 2. 2. 2. 2. 2. 2. 2. 20 }.

	aReversePolarityCard := ReversePolarityCard new.

	aDeck := LoadedDeck of: {
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
						aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard. }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.
	
 
	
	aGame play: aReversePolarityCard  by: 'Danny'  targetting: 4.

	
	aGame playNextTurn .
	aGame playNextTurn .
	aGame playNextTurn .
	
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 6.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 7.

	

	
	
	
	
	
		
]

{ #category : #tests }
LastVersionTest >> testLV11IfAPlayersPlaysTheReversePolarityCardOnANullEffectTileItDoesNothing [

	| aGame aBoard aDie1 someSpaceships aDeck aReversePolarityCard |
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.
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
	aDie1 := LoadedDie of: { 2. 2. 1. 2. 2. 2. 2. 2. 2. 2. 20 }.

	aReversePolarityCard := ReversePolarityCard new.

	aDeck := LoadedDeck of: {
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
						aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard. }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.
	
 
	
	aGame play: aReversePolarityCard  by: 'Danny'  targetting: 3.

	
	aGame playNextTurn .
	aGame playNextTurn .
	aGame playNextTurn .
	
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 2.

	

	
	
	
	
	
		
]

{ #category : #tests }
LastVersionTest >> testLV12IfAPlayersPlaysTheReversePolarityCardOnAnAtomicBombEffectTileItDoesNothing [

	| aGame aBoard aDie1 someSpaceships aDeck aReversePolarityCard |
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          AtomicBomb new.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 3. 3. 4. 2. 2. 2. 2. 2. 2. 2. 20 }.

	aReversePolarityCard := ReversePolarityCard new.

	aDeck := LoadedDeck of: {
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
						aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard. }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.
	
 
	
	aGame play: aReversePolarityCard  by: 'Danny'  targetting: 5.

	
	aGame playNextTurn .
	aGame playNextTurn .
	aGame playNextTurn .
	
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 4.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 5.

	

	
	
	
	
	
		
]

{ #category : #tests }
LastVersionTest >> testLV13IfAPlayersPlaysTheReversePolarityCardOnAHyperJumpEffectTileItTargetsAllButTheSpaceshipThatTriggeredIt [

	| aGame aBoard aDie1 someSpaceships aDeck aReversePolarityCard unitsToMove |
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.
	unitsToMove := OrderedCollection
		               with: (Parsecs with: 3)
		               with: (Parsecs with: 2).
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          (HyperJump of: unitsToMove).
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 4. 5. 3. 2. 2. 2. 2. 2. 2. 2. 20 }.

	aReversePolarityCard := ReversePolarityCard new.

	aDeck := LoadedDeck of: {
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.



	aGame play: aReversePolarityCard by: 'Danny' targetting: 4.


	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 5.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 6.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 1.
	
	aGame playNextTurn.

	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 8.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 9.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 4
]

{ #category : #tests }
LastVersionTest >> testLV14IfAPlayersPlaysTheReversePolarityCardOnACardGiverEffectTileItTargetsAllButTheSpaceshipThatTriggeredIt [

	| aGame aBoard aDie1 someSpaceships aDeck aReversePolarityCard unitsToMove |
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.
	unitsToMove := OrderedCollection
		               with: (Parsecs with: 3)
		               with: (Parsecs with: 2).
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          CardGiver new.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 3. 5. 3. 2. 2. 2. 2. 2. 2. 2. 20 }.

	aReversePolarityCard := ReversePolarityCard new.

	aDeck := LoadedDeck of: {
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	self assert: (aGame handOf: 'Danny') cardsInHand size equals: 2.
	self assert: (aGame handOf: 'Walter') cardsInHand size equals: 2.
	self assert: (aGame handOf: 'Joseph') cardsInHand size equals: 2.

	aGame play: aReversePolarityCard by: 'Danny' targetting: 4.
	
	self assert: (aGame handOf: 'Danny') cardsInHand size equals: 1.

	aGame playNextTurn.
	
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 4.
	self assert: (aGame handOf: 'Danny') cardsInHand size equals: 1.
	self assert: (aGame handOf: 'Walter') cardsInHand size equals: 3.
	self assert: (aGame handOf: 'Joseph') cardsInHand size equals: 3.

]

{ #category : #tests }
LastVersionTest >> testLV15IfAPlayersPlaysTheReversePolarityCardOnAHyperGravityEffectTileItTargetsAllButTheSpaceshipThatTriggeredIt [

	| aGame aBoard aDie1 someSpaceships aDeck aReversePolarityCard |
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          (HyperGravity needsToThrow: 4).
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 4. 5. 3. 2. 2. 3. 2. 4. 2. 4. 20 }.

	aReversePolarityCard := ReversePolarityCard new.

	aDeck := LoadedDeck of: {
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.}.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	aGame play: aReversePolarityCard by: 'Danny' targetting: 4.
	

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 5.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 6.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 4.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 5.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 6.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 7.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 5.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 10.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 7.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 9.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 10.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 9.


]

{ #category : #tests }
LastVersionTest >> testLV16IfAPlayersPlaysTheReversePolarityCardOnAWormholeEffectTileItTargetsAllButTheSpaceshipThatTriggeredIt [

	| aGame aBoard aDie1 someSpaceships aDeck aReversePolarityCard wormholeTile3 wormholeTile5|
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.
	wormholeTile3 := Wormhole betweenTiles: { 3. 5 }.
	wormholeTile5 := Wormhole betweenTiles: { 5. 3 }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          wormholeTile3.
				          Null create.
				          wormholeTile5.
				          Null create.
				          Null create.
				          Null create.
				          Null create }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 1. 5. 2. 2. 2. 3. 2. 4. 2. 4. 20 }.

	aReversePolarityCard := ReversePolarityCard new.

	aDeck := LoadedDeck of: {
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.}.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.

	aGame play: aReversePolarityCard by: 'Danny' targetting: 3.
	

	aGame playNextTurn.
	aGame playNextTurn.
	
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 6.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 1.

	aGame playNextTurn.
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 5.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 5.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 3.


]

{ #category : #tests }
LastVersionTest >> testLV17IfAPlayersPlaysTheReversePolarityCardOnAnAlreadyReversedTileItChangesToTheOriginalTaregt [

	| aGame aBoard aDie1 someSpaceships aDeck aReversePolarityCard |
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          BlackHole new  }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 5. 5. 6. 1. 5. 2. 2. 2. 2. 2. 20 }.

	aReversePolarityCard := ReversePolarityCard new.

	aDeck := LoadedDeck of: {
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
						aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard. }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.
	
 
	
	aGame play: aReversePolarityCard  by: 'Danny'  targetting: 7.

	
	aGame playNextTurn .
	aGame playNextTurn .
	
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 6.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 6.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 1.
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 7.
	aGame playNextTurn .
	
	aGame play: aReversePolarityCard by: 'Walter' targetting: 7.
	
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 7.
	
	

]

{ #category : #tests }
LastVersionTest >> testLV18IfAPlayersPlaysThreeTimesReversePolarityCardOnTheSameTileItIsOnlyReversedOnce [

	| aGame aBoard aDie1 someSpaceships aDeck aReversePolarityCard |
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          BlackHole new  }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 5. 5. 6. 1. 5. 7. 2. 2. 2. 2. 20 }.

	aReversePolarityCard := ReversePolarityCard new.

	aDeck := LoadedDeck of: {
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
						aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard. }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.
	
 
	
	aGame play: aReversePolarityCard  by: 'Danny'  targetting: 7.

	
	aGame playNextTurn .
	aGame playNextTurn .
	
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 6.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 6.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 1.
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 7.
	aGame playNextTurn .
	
	aGame play: aReversePolarityCard by: 'Walter' targetting: 7.
	
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 7.
	aGame play: aReversePolarityCard by: 'Joseph' targetting: 7.
	aGame playNextTurn .
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 1.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 7.
	
	

]

{ #category : #tests }
LastVersionTest >> testLV19IfAPlayersPlaysTheReversePolarityEffectOnATileThatDoesntExistItCannot [

	| aGame aBoard aDie1 someSpaceships aDeck aReversePolarityCard|
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          BlackHole new }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 5. 5. 6. 1. 5. 7. 2. 2. 2. 2. 20 }.

	aReversePolarityCard := ReversePolarityCard new.

	aDeck := LoadedDeck of: {
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard.
			         aReversePolarityCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.


	self
		should: [
		aGame play: aReversePolarityCard by: 'Danny' targetting: 556 ]
		raise: Error
		withMessage:
		'The tile number is greater or lower than the amounts of tiles in the board'.
	self
		should: [
		aGame play: aReversePolarityCard by: 'Danny' targetting: -4 ]
		raise: Error
		withMessage:
		'The tile number is greater or lower than the amounts of tiles in the board'.
	

		
	
]

{ #category : #tests }
LastVersionTest >> testLV20IfAPlayersCancelsAReversePolarityCardTheTileEffectGoesBackToNormal [

	| aGame aBoard aDie1 someSpaceships aDeck aReversePolarityCard aCancellationCard cardPlay|
	someSpaceships := { 'Danny'. 'Walter'. 'Joseph' }.
	aBoard := Board
		          of: {
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          Null create.
				          BlackHole new }
		          withUnitsOfMeasurement: (Parsecs with: 10).
	aDie1 := LoadedDie of: { 5. 5. 6. 1. 5. 7. 2. 2. 2. 2. 20 }.

	aReversePolarityCard := ReversePolarityCard new.
	aCancellationCard:=CancellationCard new.

	aDeck := LoadedDeck of: {
			         aReversePolarityCard.
			         aCancellationCard.
			         aReversePolarityCard.
			         aCancellationCard.
			         aReversePolarityCard.
			         aCancellationCard.
			         aReversePolarityCard.
			         aCancellationCard.
			         aReversePolarityCard }.

	aGame := Game
		         playedBy: someSpaceships
		         on: aBoard
		         finishingAfter: 2
		         rolling: aDie1
		         usingCardsFrom: aDeck.


	aGame play: aReversePolarityCard  by: 'Danny' targetting: 7.
	
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 2.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 7.
	aGame playNextTurn.
	cardPlay:= CardPlay a:aReversePolarityCard  wasPlayedBy: 'Danny' targetting: 7 .
	aGame play: aCancellationCard  by: 'Walter'  targetting: cardPlay . 
	aGame playNextTurn.
	self assert: (aGame spaceshipOwnedBy: 'Danny') position equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Walter') position equals: 3.
	self assert: (aGame spaceshipOwnedBy: 'Joseph') position equals: 7.
	

		
	
]
