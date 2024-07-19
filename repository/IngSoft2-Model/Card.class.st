Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
Card >> =anotherCard [
	^ self class = anotherCard class
	
]

{ #category : #delegating }
Card >> canBePlayedAtAnyTime [

	self subclassResponsibility
]

{ #category : #delegating }
Card >> uses: cardPlayResolver [

	self subclassResponsibility
]
