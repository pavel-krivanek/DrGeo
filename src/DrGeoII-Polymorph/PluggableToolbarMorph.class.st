Class {
	#name : #PluggableToolbarMorph,
	#superclass : #PluggableMorphListMorph,
	#category : #DrGeoII-Polymorph
}

{ #category : #'event handling' }
PluggableToolbarMorph >> mouseUp: event [ 
	"The mouse came up within the list; take appropriate action"
	
	| row mdr |
	row := self rowAtLocation: event position.
	event hand hasSubmorphs ifFalse: [
		mdr := self mouseDownRow.
		 self mouseDownRow: nil.
		mdr ifNil: [^self]].
	(self enabled and: [model okToChange])
		ifFalse: [^ self].
	self changeModelSelection: row.
	Cursor normal show
]
