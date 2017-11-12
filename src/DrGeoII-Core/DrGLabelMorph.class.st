Class {
	#name : #DrGLabelMorph,
	#superclass : #DrGStringMorph,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #editing }
DrGLabelMorph >> acceptContents [
	costume mathItem name: contents asString.
]

{ #category : #'event handling' }
DrGLabelMorph >> mouseMove: evt [
	costume 
		ifNotNil: 
			[costume constraintTextPosition: evt cursorPoint.
			self position: costume textPosition].

]
