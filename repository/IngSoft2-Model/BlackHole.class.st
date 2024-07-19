Class {
	#name : #BlackHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
BlackHole >> triggerReversePolarityEffectBy: aSpaceship on: anEffectManager [

	anEffectManager applyBlackHoleEffectToAllBut: aSpaceship
]

{ #category : #playing }
BlackHole >> triggeredBy: aSpaceship on: anEffectManager [

	anEffectManager applyBlackHoleEffectTo: aSpaceship 
]
