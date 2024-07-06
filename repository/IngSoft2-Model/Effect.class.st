Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Effect >> reversePolarity [
	self subclassResponsibility 
]

{ #category : #playing }
Effect >> triggeredBy: aPlayer on: anEffectManager [

	self subclassResponsibility
]
