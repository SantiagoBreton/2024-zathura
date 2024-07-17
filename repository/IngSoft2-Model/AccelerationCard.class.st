Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #delegating }
AccelerationCard >> cancelEffectUsing: cardPlayResolver playedBy: aPlayer targetting: aTarget [

	cardPlayResolver cancelAnAccelerationCard: self.
]

{ #category : #initialization }
AccelerationCard >> effect [

	^ 1
]

{ #category : #delegating }
AccelerationCard >> uses: cardPlayResolver [

	cardPlayResolver resolveAnAccelerationCardPlay: self
]
