Class {
	#name : #CardGiver,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
CardGiver >> triggerReversePolarityEffectBy: aSpaceship on: anEffectManager [

	anEffectManager giveCardFromDeckToAllBut: aSpaceship
]

{ #category : #playing }
CardGiver >> triggeredBy: aSpaceship on: anEffectManager [

	 anEffectManager giveCardFromDeckTo: aSpaceship 
]
