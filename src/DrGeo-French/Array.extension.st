Extension { #name : #Array }

{ #category : #'*DrGeo-French-accessing' }
Array >> a: unIndice [
	
	^self at: unIndice.
]

{ #category : #'*DrGeo-French-accessing' }
Array >> a: unIndice mettre: unObjet [
	
	^self at: unIndice put: unObjet.
]
