Class {
	#name : #AllyCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
AllyCard >> cancelEffectUsing: cardPlayResolver playedBy: aPlayer targetting: aTarget [

	cardPlayResolver cancelAnAllyCardPlayedBy: aPlayer targetting: aTarget.
]

{ #category : #delegating }
AllyCard >> uses: cardPlayResolver [

	cardPlayResolver resolveAnAllyCardPlay: self
]
