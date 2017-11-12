Extension { #name : #DrGWrappedValue }

{ #category : #'*DrGeo-French' }
DrGWrappedValue >> deplacerA: aPoint [
	^ self moveTo: aPoint
]

{ #category : #'*DrGeo-French' }
DrGWrappedValue >> nommer: aString [
	^ self name: aString
]

{ #category : #'*DrGeo-French' }
DrGWrappedValue >> valeur: aNumber [
	^ self value: aNumber 
]
