Extension { #name : #Float }

{ #category : #'*DrGeo-French' }
Float >> commeFraction [

	^self asFraction.
]

{ #category : #'*DrGeo-French' }
Float >> commeFractionApprochee [

	^self asApproximateFraction.
]

{ #category : #'*DrGeo-French' }
Float >> commeFractionApprocheeDordre: ordre [

	^self asApproximateFractionAtOrder: ordre.
]

{ #category : #'*DrGeo-French' }
Float >> commeFractionDecimale [

	^self asMinimalDecimalFraction.
]

{ #category : #'*DrGeo-French' }
Float >> commeVraieFraction [

	^self asTrueFraction.
]
