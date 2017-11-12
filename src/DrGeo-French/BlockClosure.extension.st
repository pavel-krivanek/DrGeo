Extension { #name : #BlockClosure }

{ #category : #'*DrGeo-French' }
BlockClosure >> de: unArgument [
	
	^self value: unArgument.
]

{ #category : #'*DrGeo-French' }
BlockClosure >> de: unArgument de: unAutre [
	
	^self value: unArgument value: unAutre.
]

{ #category : #'*DrGeo-French' }
BlockClosure >> de: unArgument de: unAutre de: unTroisieme [
	^self value: unArgument value: unAutre value: unTroisieme.
]

{ #category : #'*DrGeo-French' }
BlockClosure >> jusquaVrai: unBloc [

	^self whileFalse: unBloc.
]

{ #category : #'*DrGeo-French' }
BlockClosure >> tantQueFaux: unBloc [

	^self whileFalse: unBloc.
]

{ #category : #'*DrGeo-French' }
BlockClosure >> tantQueVrai: unBloc [

	^self whileTrue: unBloc.
]

{ #category : #'*DrGeo-French' }
BlockClosure >> tempsPourFaire [
	
	^self timeToRun.
]

{ #category : #'*DrGeo-French' }
BlockClosure >> valeur [
	
	^self value.
]

{ #category : #'*DrGeo-French' }
BlockClosure >> valeur: unArgument [
	
	^self value: unArgument.
]

{ #category : #'*DrGeo-French' }
BlockClosure >> valeur: unArgument valeur: unAutre [
	
	^self value: unArgument value: unAutre.
]

{ #category : #'*DrGeo-French' }
BlockClosure >> valeur: unArgument valeur: unAutre valeur: unTroisieme [	
	^self value: unArgument value: unAutre value: unTroisieme.
]
