Extension { #name : #DrGWrappedItem }

{ #category : #'*DrGeo-French' }
DrGWrappedItem >> bloquer [
	^ self lock
]

{ #category : #'*DrGeo-French' }
DrGWrappedItem >> cacher [
	^ self hide
]

{ #category : #'*DrGeo-French' }
DrGWrappedItem >> couleur: aColor [
	^ self color: aColor
]

{ #category : #'*DrGeo-French' }
DrGWrappedItem >> debloquer [
	^ self unlock
]

{ #category : #'*DrGeo-French' }
DrGWrappedItem >> decacher [
	^ self unhide
]

{ #category : #'*DrGeo-French' }
DrGWrappedItem >> deplacerA: aPoint [
	^ self moveTo: aPoint
]

{ #category : #'*DrGeo-French' }
DrGWrappedItem >> montrer [
	^ self show
]

{ #category : #'*DrGeo-French' }
DrGWrappedItem >> nommer: aString [
	^ self name: aString
]

{ #category : #'*DrGeo-French' }
DrGWrappedItem >> renommer: aString [
	^ self rename: aString
]
