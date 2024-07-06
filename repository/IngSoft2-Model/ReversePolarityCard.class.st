Class {
	#name : #ReversePolarityCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
ReversePolarityCard >> uses: cardPlayResolver [

	cardPlayResolver resolveAReversePolarityCardPlay:self
]
