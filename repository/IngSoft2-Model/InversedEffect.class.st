Class {
	#name : #InversedEffect,
	#superclass : #Object,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
InversedEffect class >> reversePolarityOf:anEffect [
	^ self new inizializewith:anEffect .
]

{ #category : #'as yet unclassified' }
InversedEffect >> inizializewith: anEffect [
	effect:=  anEffect.
]

{ #category : #playing }
InversedEffect >> triggerReversePolarityEffectBy:aSpaceship on: anEffectManager [
	effect triggeredBy: aSpaceship on: anEffectManager.
]

{ #category : #playing }
InversedEffect >> triggeredBy: aSpaceship on: anEffectManager [
	effect triggerReversePolarityEffectBy:aSpaceship on: anEffectManager.
]
