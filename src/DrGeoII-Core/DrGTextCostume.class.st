Class {
	#name : #DrGTextCostume,
	#superclass : #DrGMathItemCostume,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGTextCostume >> backgroundColor: aColor [
	morph backgroundColor: aColor 
]

{ #category : #testing }
DrGTextCostume >> basicType [
	^#text
]

{ #category : #accessing }
DrGTextCostume >> borderColor: aColor [
	morph borderColor: aColor 
]

{ #category : #updating }
DrGTextCostume >> editMyProperty [
	| answer |
	DrGDefault showVirtualKeyboard: true.
	answer := self view 
		textEditor: 'Edit this text' translated 
		title: 'Edit this text' translated 
		entryText: mathItem text.
	DrGDefault showVirtualKeyboard: false.
	answer isEmptyOrNil ifTrue: [^self]. " cancelled"
	self domain propertyCommandFor: mathItem with: answer string
]

{ #category : #accessing }
DrGTextCostume >> fontSize: integer [
	morph font: (DrGDefault canvasFont: integer).
]

{ #category : #initialize-release }
DrGTextCostume >> instantiateMorph [ 
	morph := DrGTextMorph new autoFit: true.
	self app isNotInteractive not ifTrue: [
		DrGDefault showVirtualKeyboard: true.
		self editMyProperty.
		DrGDefault showVirtualKeyboard: false].
	morph contents: '';
		font: DrGDefault canvasFont;
		contents: mathItem text;
		backgroundColor: Color white
]

{ #category : #updating }
DrGTextCostume >> redraw [
	exist
		ifFalse: [^ self].
	morph center: self textPosition
]

{ #category : #updating }
DrGTextCostume >> registerEvents [
	mathItem
		ifNotNil: [
			mathItem
				when: #deletedMathItem
				send: #deleteCostume:
				to: drawable app
				with: self.
			mathItem 
				when: #updateMyView
				send: #updateMyText
				to: self]
]

{ #category : #style }
DrGTextCostume >> styleClass [
	^ DrGTextCostumeStyle
]

{ #category : #accessing }
DrGTextCostume >> textMorph: aString [
	"no label for text object"
	mathItem name: aString
]

{ #category : #layout }
DrGTextCostume >> textPosition [
	^(drawable worldToMorph: mathItem position)
]

{ #category : #updating }
DrGTextCostume >> updateMyText [
	morph contents: mathItem text.
]
