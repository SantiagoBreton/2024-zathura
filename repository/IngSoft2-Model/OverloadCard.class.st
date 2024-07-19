Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
OverloadCard >> canBePlayedAtAnyTime [
	^false
]

{ #category : #delegating }
OverloadCard >> cancelEffectUsing: cardPlayResolver playedBy: aPlayer targetting: aTarget [

	cardPlayResolver cancelTheEffectOf: self appliedTo:aTarget.
]

{ #category : #initialization }
OverloadCard >> effect [

	^ -2
]

{ #category : #delegating }
OverloadCard >> uses: cardPlayResolver [

	cardPlayResolver resolveAnOverloadCardPlay: self
]
