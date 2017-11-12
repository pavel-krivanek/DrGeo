Class {
	#name : #DrGCurveCostumeStyle,
	#superclass : #DrGCostumeStyle,
	#instVars : [
		'thickness',
		'lineStyle'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGCurveCostumeStyle >> borderColor [
	"Answer the value of border color"

	^hidden ifTrue: [DrGStylePreference hiddenColor] ifFalse: [color alpha: 1]
]

{ #category : #accessing }
DrGCurveCostumeStyle >> color: aColor [
"Set the value of fill color and border color"
	color := self isTranslucent ifTrue: [aColor alpha: 0.3] ifFalse: [aColor alpha: 1].
	self isHidden ifFalse: [
		costume borderColor: color.
		costume color: (self isFilled ifTrue: [color] ifFalse: [Color transparent])].
	self changed
]

{ #category : #accessing }
DrGCurveCostumeStyle >> lineStyle [
	"Answer the value of lineStyle"

	^ lineStyle
]

{ #category : #accessing }
DrGCurveCostumeStyle >> lineStyle: aSymbol [
	"Set the value of lineStyle"
	lineStyle := aSymbol.
	costume dash: (DrGStylePreference styleFor: aSymbol).
	self changed

]

{ #category : #accessing }
DrGCurveCostumeStyle >> lineStyleIndex [
	"Answer the index of lineStyle"
	^ DrGStylePreference lineStyleIndexOf: lineStyle
]

{ #category : #accessing }
DrGCurveCostumeStyle >> lineStyleIndex: integer [
	"Set the value of lineStyle"
	self lineStyle: (DrGStylePreference lineStyleSymbols at: integer)

]

{ #category : #widget }
DrGCurveCostumeStyle >> lineWidget [
	^ 'Style' translated ->
		(self view
			newMorphDropListFor: self
			list: #styleLineMorphCollection
			getSelected: #lineStyleIndex
			setSelected: #lineStyleIndex:
			help: 'Set the style of the line.' translated)
]

{ #category : #widget }
DrGCurveCostumeStyle >> myWidgets [ 
	^ OrderedCollection with: self lineWidget with: self thicknessWidget
]

{ #category : #widget }
DrGCurveCostumeStyle >> styleLineMorphCollection [
	^ DrGStylePreference styleLineMorphCollection
]

{ #category : #accessing }
DrGCurveCostumeStyle >> thickness [
	"Answer the value of thickness"

	^ thickness
]

{ #category : #accessing }
DrGCurveCostumeStyle >> thickness: anObject [
	"Set the value of thickness"
	thickness := anObject.
	costume width: self width.
	self changed
]

{ #category : #accessing }
DrGCurveCostumeStyle >> thicknessIndex [
	"Answer the index of thickness"

	^DrGStylePreference thicknessIndexOf: thickness
]

{ #category : #accessing }
DrGCurveCostumeStyle >> thicknessIndex: integer [
	"Set the value of thickness"
	self thickness: (DrGStylePreference thicknessFor: integer)
]

{ #category : #widget }
DrGCurveCostumeStyle >> thicknessMorphCollection [
	^ DrGStylePreference thicknessMorphCollection
]

{ #category : #widget }
DrGCurveCostumeStyle >> thicknessWidget [
	^ 'Thickness' translated ->
		(self view
			newMorphDropListFor: self
			list: #thicknessMorphCollection
			getSelected: #thicknessIndex
			setSelected: #thicknessIndex:
			help: 'Set the thickness of the line.' translated)
]

{ #category : #accessing }
DrGCurveCostumeStyle >> width [
	"give the width"
	^ DrGStylePreference widthFor: thickness
]

{ #category : #'xml writing' }
DrGCurveCostumeStyle >> writeAttributesTo: aNode [
	|attr|
	super writeAttributesTo: aNode.
	(self lineStyle = #dot or: [self lineStyle =#dashed] )
		ifTrue: [attr := 'Dashed']
		ifFalse: [attr := 'Normal'].
	aNode attributeAt: #style put: self lineStyle.
	"(self thickness = #large or: [self thickness = #medium]) ifTrue: [attr := 'Thick']."
	aNode attributeAt: #thickness put: self thickness.
]
