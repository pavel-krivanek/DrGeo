Extension { #name : #GeneralScrollPane }

{ #category : #'*DrGeoII-Core' }
GeneralScrollPane >> handlesMouseDown: evt [
	^ true
]

{ #category : #'*DrGeoII-Core' }
GeneralScrollPane >> mouseMove: anEvent [
	anEvent redButtonPressed ifTrue: [
		(anEvent endPoint - anEvent startPoint) y < 0 
			ifTrue: [vScrollbar scrollDown: 2]
			ifFalse: [vScrollbar scrollUp: 2]]	 
		
]
