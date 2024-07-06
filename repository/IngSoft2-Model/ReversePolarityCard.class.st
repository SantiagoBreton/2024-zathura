Class {
	#name : #ReversePolarityCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
ReversePolarityCard >> cancelEffectUsing: cardPlayResolver playedBy: aPlayer targetting: aTarget [

	cardPlayResolver cancelAReversePolarityCardTargetting: aTarget.
]

{ #category : #delegating }
ReversePolarityCard >> uses: cardPlayResolver [

	cardPlayResolver resolveAReversePolarityCardPlay:self
]
