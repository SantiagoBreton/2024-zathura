Class {
	#name : #ReversePolarityCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
ReversePolarityCard >> canBePlayedAtAnyTime [
	^false
]

{ #category : #delegating }
ReversePolarityCard >> cancelEffectUsing: cardPlayResolver playedBy: aPlayer targetting: aTarget [

	cardPlayResolver reversePolarityOfEffectAtTile:aTarget.
]

{ #category : #delegating }
ReversePolarityCard >> uses: cardPlayResolver [

	cardPlayResolver resolveAReversePolarityCardPlay:self
]
