Extension { #name : #Boolean }

{ #category : #'*DrGeo-French' }
Boolean >> contraire [
	"négation booléenne"
	
	^self not.
]

{ #category : #'*DrGeo-French' }
Boolean >> et: UnBloc [
	"et au lieu de and"

	^self and: UnBloc.
]

{ #category : #'*DrGeo-French' }
Boolean >> ou: UnBloc [
	"ou au lieu de or"

	^self or: UnBloc.
]

{ #category : #'*DrGeo-French' }
Boolean >> siFaux: UnBloc [
	"test négatif"

	^self ifFalse: UnBloc.
]

{ #category : #'*DrGeo-French' }
Boolean >> siFaux: leBlocDuFaux siVrai: leBlocDuVrai [
	"test alternatif"

	^self ifFalse: leBlocDuFaux ifTrue: leBlocDuVrai.
]

{ #category : #'*DrGeo-French' }
Boolean >> siVrai: UnBloc [
	"test positif"

	^self ifTrue: UnBloc.
]

{ #category : #'*DrGeo-French' }
Boolean >> siVrai: leBlocDuVrai siFaux: leBlocDuFaux [
	"test alternatif"

	^self ifTrue: leBlocDuVrai ifFalse: leBlocDuFaux.
]
