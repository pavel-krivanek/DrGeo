Extension { #name : #DrGWrappedText }

{ #category : #'*DrGeo-French' }
DrGWrappedText >> couleurFond: aColor [
	^ self backgroundColor: aColor
]

{ #category : #'*DrGeo-French' }
DrGWrappedText >> deplacerA: aPoint [
	^ self moveTo: aPoint
]

{ #category : #'*DrGeo-French' }
DrGWrappedText >> texte: aString [
	^ self text: aString
]
