"
A SelectItemDialogWindow is a dialog with a list of item and checkboxes to select or unselect the items.

Instance Variables
 model is an array of 3 cells arrays: {model .  title . ValueHolder}

"
Class {
	#name : #SelectItemDialog,
	#superclass : #ProceedDialogWindow,
	#instVars : [
		'items'
	],
	#category : #DrGeoII-Polymorph
}

{ #category : #'as yet unclassified' }
SelectItemDialog class >> items: items [
	 ^ self basicNew 
		items: items;
		initialize
]

{ #category : #accessing }
SelectItemDialog >> items: array [
	items := array 
]

{ #category : #actions }
SelectItemDialog >> newContentMorph [
	self iconMorph: self newIconMorph.
	self textMorph: self newTextMorph.
	^self newGroupboxForAll: {
		self newRow: {self iconMorph. self textMorph}.
		self newTableMorph}
]

{ #category : #controls }
SelectItemDialog >> newItem: array [
	^ self newColumn: {
		self newCheckboxFor: (array at: 3 put: array third)
			getSelected: #contents setSelected: #contents:
			label: array second help: nil
	}
]

{ #category : #controls }
SelectItemDialog >> newTableMorph [
	^self newColumn: (items collect: [:item | self newItem: item])
]
