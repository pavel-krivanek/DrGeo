"
A DrGCanvasMenu is a popup menu for the canvas. Its menu items are costumes of the canvas. When a menu item is highlighted, the matching costume in the canvas is emphasised as well.

"
Class {
	#name : #DrGCanvasMenuMorph,
	#superclass : #MenuMorph,
	#instVars : [
		'costumes'
	],
	#category : #DrGeoII-Polymorph
}

{ #category : #'as yet unclassified' }
DrGCanvasMenuMorph class >> chooseFrom: aList lines: linesArray title: queryString [
	"Choose an item from the given list. Answer the index of the selected item."
	"MenuMorph
		chooseFrom: #('Hello' 'Pharoers' 'Here' 'We' 'Go')
		lines: #(2 4)
		title: 'What''s up?'"
		
	| menu result |
	(ProvideAnswerNotification signal: queryString) ifNotNil:[:answer | 
		1 to: aList size do:[:i| (aList at: i) = answer ifTrue:[^i]].
		^0].
	result := 0.
	menu := self new.
	menu costumes: aList.
	menu addTitle: queryString.
	1 to: aList size do:[:i| 
		menu add: (aList at: i) asString target: [:v| result := v] selector: #value: argument: i.
		(linesArray includes: i) ifTrue: [menu addLine]].
	
	menu invokeAt: ActiveHand position in: ActiveWorld allowKeyboard: true.
	^result
]

{ #category : #accessing }
DrGCanvasMenuMorph >> costumes: aCollection [
	costumes := aCollection
]

{ #category : #control }
DrGCanvasMenuMorph >> selectItem: aMenuItem event: anEvent [
	selectedItem ifNotNil:[
		selectedItem deselect: anEvent.
		(costumes at: selectedItem arguments first) stopBlinking].
	selectedItem := aMenuItem.
	selectedItem ifNotNil:[
		selectedItem select: anEvent.
		(costumes at: selectedItem arguments first) startBlinking].
]

{ #category : #events }
DrGCanvasMenuMorph >> updateColor [
	super updateColor.
	self color: (self color alpha: 0.6).
	self borderColor: (self borderColor alpha: 0.6).

]
