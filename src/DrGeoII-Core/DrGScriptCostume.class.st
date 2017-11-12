"
A costume for script.
The morph view is deduced from the DrGeoScript specific class. 
Class known by the MathItemScript instance.
"
Class {
	#name : #DrGScriptCostume,
	#superclass : #DrGValueCostume,
	#instVars : [
		'browser'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGScriptCostume >> backgroundColor: aColor [
	morph backgroundColor: aColor
]

{ #category : #accessing }
DrGScriptCostume >> borderColor: aColor [
	morph borderColor: aColor
]

{ #category : #updating }
DrGScriptCostume >> editMyProperty [
	| scriptClass |
	scriptClass := mathItem script class.
	DrGDefault showVirtualKeyboard: true.
	browser := Nautilus newOnClass: scriptClass selector: #compute.
	browser ui title: ('Edit script: {1}' translated format: {scriptClass scriptName}).
	SystemAnnouncer uniqueInstance weak on: MethodModified send: #update: to: self domain.
	
	browser  ui window extent: 800@350.
]

{ #category : #accessing }
DrGScriptCostume >> fontSize: integer [
	morph font: (DrGDefault canvasFont: integer).
]

{ #category : #initialize-release }
DrGScriptCostume >> instantiateMorph [
	morph := DrGTextMorph new autoFit: true.
	morph contents: '';
		font: DrGDefault canvasFont;
		backgroundColor: Color white.
	mathItem valueItem isText
		ifTrue: [morph contents: mathItem valueItem]
		ifFalse: [morph contents: self roundedValueString]
]

{ #category : #initialize-release }
DrGScriptCostume >> releasePropertyWidget [
	browser
		ifNotNil: [ browser ui window ifNotNil: [ :view | view delete ].
			browser := nil.
			DrGDefault showVirtualKeyboard: false ]
]

{ #category : #style }
DrGScriptCostume >> styleClass [
	^ DrGTextCostumeStyle 
]
