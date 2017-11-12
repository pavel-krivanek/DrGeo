Extension { #name : #DrGCompositeItem }

{ #category : #'*DrGeoII-Core-testing' }
DrGCompositeItem >> isCompositeItem [
	^true
]

{ #category : #'*DrGeoII-Core-testing' }
DrGCompositeItem >> isGeometricItem [
"if all subitem are geometric item, considere ourself as a geometric item"
	subItems do: [:aMathItem |
		(aMathItem isGeometricItem) 
			ifFalse: [^false]].
	^true
]
