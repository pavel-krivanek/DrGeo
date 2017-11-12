Class {
	#name : #DrGValueCostume,
	#superclass : #DrGMathItemCostume,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #testing }
DrGValueCostume >> basicType [
	^#value
]

{ #category : #layout }
DrGValueCostume >> constraintTextPosition: aPoint [
	^ aPoint
]

{ #category : #accessing }
DrGValueCostume >> contents: aString [
	morph contents: aString
]

{ #category : #updating }
DrGValueCostume >> editMyProperty [
	| answer |
	mathItem isPropertyEditable ifFalse: [^self].
	DrGDefault showVirtualKeyboard: true.
	answer := self view 
		textEntry:  'Edit this value' translated 
		title: 'Edit this value' translated 
		entryText: self valueString.
	answer isEmptyOrNil ifTrue: [^self]. " cancelled"
	[answer := answer asNumber]
		on: Error
		do: [^ self view alert: 'I can''t read your value.' translated].
	self domain propertyCommandFor: mathItem with: answer.	
	DrGDefault showVirtualKeyboard: false.
]

{ #category : #initialize-release }
DrGValueCostume >> instantiateMorph [
	morph := DrGValueMorph new.
	(mathItem class = DrGValueValueItem and: [self app isNotInteractive not]) ifTrue: ["we do want pop up dialog now"
		self editMyProperty].
	morph contents: self roundedValueString
]

{ #category : #updating }
DrGValueCostume >> launchMiniEditor [
	morph contents: self valueString.
	morph launchMiniEditor: ActiveHand lastEvent
]

{ #category : #updating }
DrGValueCostume >> redraw [
	exist ifFalse: [^ self].
	(mathItem name isNil or: [mathItem name size = 0])
		ifTrue: [
			mathItem valueItem isText
				ifTrue: [self contents: mathItem valueItem]
				ifFalse: [self contents: self roundedValueString]]
		ifFalse: [self contents: mathItem name , ' = ' , self roundedValueString].
	self redrawValue.
]

{ #category : #updating }
DrGValueCostume >> redrawValue [
	morph topLeft: self textPosition
]

{ #category : #updating }
DrGValueCostume >> roundedValueString [
	^ (mathItem valueItem isPoint or: [mathItem valueItem isNumber])
		ifTrue: [
			mathItem valueItem isFraction 
				ifTrue: [mathItem valueItem printString] 
				ifFalse: [mathItem valueItem printShowingDecimalPlaces: 2]]
		ifFalse: [mathItem valueItem asString]
]

{ #category : #style }
DrGValueCostume >> styleClass [
	^DrGValueCostumeStyle
]

{ #category : #accessing }
DrGValueCostume >> textMorph: aString [ 
	"We don't have label for ValueCostume"
	mathItem name: aString.
]

{ #category : #updating }
DrGValueCostume >> textPosition [
	^(drawable worldToMorph: mathItem position)
]

{ #category : #updating }
DrGValueCostume >> valueString [
	^mathItem valueItem asString
]
