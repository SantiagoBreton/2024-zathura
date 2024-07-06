Class {
	#name : #AllyCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
AllyCard >> cancelEffectUsing: cardPlayResolver playedBy: aPlayer targetting: aTarget [

	cardPlayResolver cancelAnAllyCardPlayedBy: aPlayer targetting: aTarget.
]

{ #category : #initialization }
AllyCard >> effect [

	^ 0
]

{ #category : #delegating }
AllyCard >> uses: cardPlayResolver [

	cardPlayResolver resolveAnAllyCardPlay: self
]
