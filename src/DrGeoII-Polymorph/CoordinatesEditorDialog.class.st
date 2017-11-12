"
A dialog to edit the coordinates of a point.
"
Class {
	#name : #CoordinatesEditorDialog,
	#superclass : #MessageDialogWindow,
	#instVars : [
		'xTextEditorMorph',
		'yTextEditorMorph',
		'xEntryText',
		'yEntryText'
	],
	#classVars : [
		'MinimumWidth'
	],
	#category : #DrGeoII-Polymorph
}

{ #category : #settings }
CoordinatesEditorDialog class >> minimumWidth [
	^ MinimumWidth ifNil: [MinimumWidth := 450]
]

{ #category : #settings }
CoordinatesEditorDialog class >> minimumWidth: anInteger [
	MinimumWidth := anInteger
]

{ #category : #'as yet unclassified' }
CoordinatesEditorDialog class >> taskbarIcon [
	"Answer the icon for the receiver in a task bar."

	^Smalltalk ui icons  smallQuestionIcon
]

{ #category : #actions }
CoordinatesEditorDialog >> cancel [
	"Cancel and close."

	self xEntryText: nil.
	self yEntryText: nil.
	^super cancel
]

{ #category : #'focus handling' }
CoordinatesEditorDialog >> defaultFocusMorph [
	"Answer the morph that should have the keyboard
	focus by default when the dialog is opened."
	
	^self xTextEditorMorph textMorph
]

{ #category : #'visual properties' }
CoordinatesEditorDialog >> entryHeight: aNumber [
	"Set the height of the text editor morph.
	Set the width to be 2 times this also."

	self xTextEditorMorph
		vResizing: #rigid;
		height: aNumber;
		hResizing: #rigid;
		width: aNumber * 2.
	self yTextEditorMorph
		vResizing: #rigid;
		height: aNumber;
		hResizing: #rigid;
		width: aNumber * 2
]

{ #category : #'visual properties' }
CoordinatesEditorDialog >> icon [
	"Answer an icon for the receiver."
	
	^Smalltalk ui icons questionIcon
]

{ #category : #open/close }
CoordinatesEditorDialog >> initialExtent [
	^ self minimumWidth @ (super initialExtent y)

]

{ #category : #initialization }
CoordinatesEditorDialog >> initialize [
	"Initialize the receiver."

	super initialize.
	self xEntryText: ''.
	self yEntryText: ''
]

{ #category : #accessing }
CoordinatesEditorDialog >> minimumWidth [
	^ (super minimumWidth max: self class minimumWidth) min: (Display width)
]

{ #category : #actions }
CoordinatesEditorDialog >> newButtons [
	"Answer new buttons as appropriate."

	^{self newOKButton isDefault: true. self newCancelButton}
]

{ #category : #actions }
CoordinatesEditorDialog >> newContentMorph [
	"Answer a new content morph."

	self iconMorph: self newIconMorph.
	self textMorph: self newTextMorph.
	self textMorph wrapFlag: false.
	self xTextEditorMorph: self newXTextEditorMorph.
	self yTextEditorMorph: self newYTextEditorMorph.
	^self newGroupboxForAll: {
		self newRow: {self iconMorph. self textMorph}.
		self newRow: {self newText: 'X =' . self xTextEditorMorph}.
		self newRow: {self newText: 'Y ='. self yTextEditorMorph}}
]

{ #category : #initialization }
CoordinatesEditorDialog >> newXTextEditorMorph [
	"Answer a new text entry morph."

	^(self
		newTextEntryFor: self
		getText: #xEntryText
		setText: #xEntryText:
		getEnabled: nil
		help: nil)
		acceptOnCR: false;
		selectAll
]

{ #category : #initialization }
CoordinatesEditorDialog >> newYTextEditorMorph [
	"Answer a new text entry morph."

	^(self
		newTextEntryFor: self
		getText: #yEntryText
		setText: #yEntryText:
		getEnabled: nil
		help: nil)
		acceptOnCR: false;
		selectAll
]

{ #category : #accessing }
CoordinatesEditorDialog >> xEntryText [
	^ xEntryText 
]

{ #category : #accessing }
CoordinatesEditorDialog >> xEntryText: anObject [
	"Set the value of xEntryText"

	xEntryText := anObject.
	self changed: #xEntryText.
	self xTextEditorMorph selectAll
]

{ #category : #accessing }
CoordinatesEditorDialog >> xTextEditorMorph [
	^ xTextEditorMorph
]

{ #category : #accessing }
CoordinatesEditorDialog >> xTextEditorMorph: anObject [
	xTextEditorMorph := anObject
]

{ #category : #accessing }
CoordinatesEditorDialog >> yEntryText [
	^ yEntryText 
]

{ #category : #accessing }
CoordinatesEditorDialog >> yEntryText: anObject [
	"Set the value of yEntryText"

	yEntryText := anObject.
	self changed: #yEntryText.
	self yTextEditorMorph selectAll
]

{ #category : #accessing }
CoordinatesEditorDialog >> yTextEditorMorph [
	^ yTextEditorMorph
]

{ #category : #accessing }
CoordinatesEditorDialog >> yTextEditorMorph: anObject [
	yTextEditorMorph := anObject
]
