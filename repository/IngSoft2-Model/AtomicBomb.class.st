Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AtomicBomb >> triggerReversePolarityEffectBy:aSpaceship on: anEffectManager [
]

{ #category : #playing }
AtomicBomb >> triggeredBy: aSpaceship on: anEffectManager [
	anEffectManager moveAllSpaceshipsToFirstPosition  .
	
]
