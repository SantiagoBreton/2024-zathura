Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Effect >> triggerReversePolarityEffectBy: aSpaceship on: anEffectManager [

	self subclassResponsibility
]

{ #category : #playing }
Effect >> triggeredBy: aPlayer on: anEffectManager [

	self subclassResponsibility
]
