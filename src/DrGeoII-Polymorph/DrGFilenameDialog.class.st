"
A dialog to save a sketch
- networked : a checkbox to enable or not network save operation
"
Class {
	#name : #DrGFilenameDialog,
	#superclass : #TextEntryDialogWindow,
	#instVars : [
		'networked'
	],
	#category : #DrGeoII-Polymorph
}

{ #category : #accessing }
DrGFilenameDialog >> network [ 
	^ networked ifNil: [networked := false]
]

{ #category : #accessing }
DrGFilenameDialog >> network: boolean [
	networked := boolean.
	self  changed: #network
]

{ #category : #accessing }
DrGFilenameDialog >> networkShare [
	^ DrGDefault networkShare
]

{ #category : #accessing }
DrGFilenameDialog >> networkShare: aString [
	DrGDefault networkShare: aString
]

{ #category : #actions }
DrGFilenameDialog >> newCheckboxMorph [
	^ self 
		newCheckboxFor:  self
		getSelected: #network 
		setSelected: #network:
		label: 'Network share' translated
		help: 'Save the file on a network share.' translated
]

{ #category : #actions }
DrGFilenameDialog >> newContentMorph [
	"Answer a new content morph."
	self iconMorph: self newIconMorph.
	self textMorph: self newTextMorph.
	self textMorph wrapFlag: false.
	self textEditorMorph: self newTextEditorMorph.
	^ DrGDefault useNetwork 
		ifTrue: [
			self newGroupboxForAll: {
				self newRow: {self iconMorph. self textMorph}.
				self textEditorMorph.
				self newRow: {self newCheckboxMorph. self newNetworkShareMorph}}] 
		ifFalse: [
			self newGroupboxForAll: {
				self newRow: {self iconMorph. self textMorph}.
				self textEditorMorph}]

]

{ #category : #actions }
DrGFilenameDialog >> newNetworkShareMorph [
	^ self 
		newTextEntryFor: self 
		getText: #networkShare
		setText: #networkShare:
		getEnabled: #network
		help: 'The network share to keep this sketch.' translated


]
