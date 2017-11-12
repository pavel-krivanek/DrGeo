"
A singleton to hold the prefered user style for the mathematic items.

(SettingBrowser forKeywords: #('drgeosettings')) open.
"
Class {
	#name : #DrGStylePreference,
	#superclass : #Object,
	#instVars : [
		'pointColor',
		'pointShape',
		'pointSize',
		'lineColor',
		'lineThickness',
		'lineStyle',
		'rayColor',
		'rayThickness',
		'rayStyle',
		'segmentColor',
		'segmentThickness',
		'segmentStyle',
		'segmentArrow',
		'segmentMark',
		'vectorColor',
		'vectorThickness',
		'vectorStyle',
		'circleColor',
		'circleThickness',
		'circleStyle',
		'circleFilled',
		'circleTranslucent',
		'arcColor',
		'arcThickness',
		'arcStyle',
		'arcArrow',
		'arcFilled',
		'arcTranslucent',
		'polygonColor',
		'polygonThickness',
		'polygonStyle',
		'polygonFilled',
		'polygonTranslucent',
		'locusColor',
		'locusThickness',
		'locusStyle',
		'valueColor',
		'textColor',
		'textBackgroundColor',
		'textBorderColor'
	],
	#classVars : [
		'UniquieInstance'
	],
	#category : #DrGeoII-Core-Resources
}

{ #category : #arc }
DrGStylePreference class >> arcArrow [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #arc }
DrGStylePreference class >> arcArrowIndex [
	^ self arrowIndexOf: self current arcArrow
]

{ #category : #arc }
DrGStylePreference class >> arcArrowIndex: anIndex [
	^ self current arcArrow: (self arrowFor: anIndex)
]

{ #category : #arc }
DrGStylePreference class >> arcArrowWidget [
	^ self arrowWidget: #arcArrowIndex
]

{ #category : #arc }
DrGStylePreference class >> arcColor [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #arc }
DrGStylePreference class >> arcColorIndex [
	^ self colorIndexOf: self current arcColor
]

{ #category : #arc }
DrGStylePreference class >> arcColorIndex: anIndex [
	^ self current arcColor: (self colorFor: anIndex)
]

{ #category : #arc }
DrGStylePreference class >> arcColorWidget [
	^ self colorWidget: #arcColorIndex
]

{ #category : #arc }
DrGStylePreference class >> arcFilled [
	^ self current arcFilled
]

{ #category : #arc }
DrGStylePreference class >> arcFilled: aBoolean [
	^ self current arcFilled: aBoolean
]

{ #category : #arc }
DrGStylePreference class >> arcStyle [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #arc }
DrGStylePreference class >> arcStyleIndex [
	^ self lineStyleIndexOf: self current arcStyle
]

{ #category : #arc }
DrGStylePreference class >> arcStyleIndex: anIndex [
	^ self current arcStyle: (self lineStyleFor: anIndex)
]

{ #category : #arc }
DrGStylePreference class >> arcStyleWidget [
	^ self styleWidget: #arcStyleIndex
]

{ #category : #settings }
DrGStylePreference class >> arcStylesOn: aBuilder [
	<drgeosettings>
	(aBuilder group: #arc)
		label: 'Arc' translated;
		order: 70;
		parent: #drgeoStyle;
		description: 'Set the default style for arc.' translated;
		with: [
			(aBuilder setting: #arcColor)
				order: 1;
				label: 'Colour' translated.
			(aBuilder setting: #arcStyle)
				order: 2;
				label: 'Style' translated.
			(aBuilder setting: #arcThickness)
				order: 3;
				label: 'Thickness' translated.
			(aBuilder setting: #arcArrow)
				order: 4;
				label: 'Arrow' translated.	
			(aBuilder setting: #arcFilled)
				order: 5;
				label: 'Fill' translated.
			(aBuilder setting: #arcTranslucent)
				order: 6;
				label: 'Translucent' translated].

]

{ #category : #arc }
DrGStylePreference class >> arcThickness [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #arc }
DrGStylePreference class >> arcThicknessIndex [
	^ self thicknessIndexOf: self current arcThickness
]

{ #category : #arc }
DrGStylePreference class >> arcThicknessIndex: anIndex [
	^ self current arcThickness: (self thicknessFor: anIndex)
]

{ #category : #arc }
DrGStylePreference class >> arcThicknessWidget [
	^ self thicknessWidget: #arcThicknessIndex

]

{ #category : #arc }
DrGStylePreference class >> arcTranslucent [
	^ self current arcTranslucent
]

{ #category : #arc }
DrGStylePreference class >> arcTranslucent: aBoolean [
	^ self current arcTranslucent: aBoolean
]

{ #category : #'curve finit' }
DrGStylePreference class >> arrowFor: index [
	^ self arrowSymbols at: index
]

{ #category : #'curve finit' }
DrGStylePreference class >> arrowIndexOf: aSymbol [
	^ self arrowSymbols indexOf: aSymbol
]

{ #category : #'curve finit' }
DrGStylePreference class >> arrowMorphCollection [
	^ self arrowSymbols collect: [:symbol |
		(DrGIcons 
			segment: (self widthFor: #small) 
			color: Color black
			dash: (self styleFor: #plain)
			arrow: symbol) asMorph]
]

{ #category : #'curve finit' }
DrGStylePreference class >> arrowSymbols [
	^ #(#makeBackArrow #makeForwardArrow #makeBothArrows #makeNoArrows) 
]

{ #category : #helpers }
DrGStylePreference class >> arrowWidget: getAccessor [
	^ (UITheme builder
			newMorphDropListFor: self
			list: #arrowMorphCollection
			getSelected: getAccessor
			setSelected: (getAccessor, ':') asSymbol
			help: nil) minWidth: DrGIcons menuExtent x + 35
]

{ #category : #color }
DrGStylePreference class >> blinkingColor [
	^Color lightGray lighter lighter
]

{ #category : #circle }
DrGStylePreference class >> circleColor [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #circle }
DrGStylePreference class >> circleColorIndex [
	^ self colorIndexOf: self current circleColor
]

{ #category : #circle }
DrGStylePreference class >> circleColorIndex: anIndex [
	^ self current circleColor: (self colorFor: anIndex)
]

{ #category : #circle }
DrGStylePreference class >> circleColorWidget [
	^ self colorWidget: #circleColorIndex
]

{ #category : #circle }
DrGStylePreference class >> circleFilled [
	^ self current circleFilled
]

{ #category : #circle }
DrGStylePreference class >> circleFilled: aBoolean [
	^ self current circleFilled: aBoolean
]

{ #category : #circle }
DrGStylePreference class >> circleStyle [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #circle }
DrGStylePreference class >> circleStyleIndex [
	^ self lineStyleIndexOf: self current circleStyle
]

{ #category : #circle }
DrGStylePreference class >> circleStyleIndex: anIndex [
	^ self current circleStyle: (self lineStyleFor: anIndex)
]

{ #category : #circle }
DrGStylePreference class >> circleStyleWidget [
	^ self styleWidget: #circleStyleIndex
]

{ #category : #settings }
DrGStylePreference class >> circleStylesOn: aBuilder [
	<drgeosettings>
	(aBuilder group: #circle)
		label: 'Circle' translated;
		order:60;
		parent: #drgeoStyle;
		description: 'Set the default style for circle.' translated;
		with: [
			(aBuilder setting: #circleColor)
				order: 1;
				label: 'Colour' translated.
			(aBuilder setting: #circleStyle)
				order: 2;
				label: 'Style' translated.
			(aBuilder setting: #circleThickness)
				order: 3;
				label: 'Thickness' translated.
			(aBuilder setting: #circleFilled)
				order: 4;
				label: 'Fill' translated.
			(aBuilder setting: #circleTranslucent)
				order: 5;
				label: 'Translucent' translated].

]

{ #category : #circle }
DrGStylePreference class >> circleThickness [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #circle }
DrGStylePreference class >> circleThicknessIndex [
	^ self thicknessIndexOf: self current circleThickness
]

{ #category : #circle }
DrGStylePreference class >> circleThicknessIndex: anIndex [
	^ self current circleThickness: (self thicknessFor: anIndex)
]

{ #category : #circle }
DrGStylePreference class >> circleThicknessWidget [
	^ self thicknessWidget: #circleThicknessIndex

]

{ #category : #circle }
DrGStylePreference class >> circleTranslucent [
	^ self current circleTranslucent
]

{ #category : #circle }
DrGStylePreference class >> circleTranslucent: aBoolean [
	^ self current circleTranslucent: aBoolean
]

{ #category : #color }
DrGStylePreference class >> colorFor: index [
	^ Color perform: (self colorSymbols at: index)
]

{ #category : #color }
DrGStylePreference class >> colorIndexOf: aColor [
	^self colors indexOf: (aColor alpha: 1)
]

{ #category : #color }
DrGStylePreference class >> colorMorphCollection [
	^ self colors collect: [:aColor |
		(DrGIcons colorForm: aColor ) asMorph]
]

{ #category : #color }
DrGStylePreference class >> colorSymbols [
	^#(#black #blue #brown #green #magenta #orange #red #yellow #white)
]

{ #category : #helpers }
DrGStylePreference class >> colorWidget: getAccessor [
	^ (UITheme builder
			newMorphDropListFor: self
			list: #colorMorphCollection
			getSelected: getAccessor
			setSelected: (getAccessor, ':') asSymbol
			help: nil) minWidth: DrGIcons menuExtent x + 35
]

{ #category : #color }
DrGStylePreference class >> colors [
	^ self colorSymbols collect: [:symbol | Color perform: symbol]
]

{ #category : #'instance creation' }
DrGStylePreference class >> current [
	^UniquieInstance ifNil: [ 
		UniquieInstance := self basicNew initialize ]
]

{ #category : #settings }
DrGStylePreference class >> drgeoStylesOn: aBuilder [
	<drgeosettings>
	(aBuilder group: #drgeoStyle)
		label: 'Style';
		description: 'Dr. Geo style settings' translated
]

{ #category : #color }
DrGStylePreference class >> hiddenColor [
	^Color lightGray lighter lighter lighter
]

{ #category : #line }
DrGStylePreference class >> lineColor [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #line }
DrGStylePreference class >> lineColorIndex [
	^ self colorIndexOf: self current lineColor
]

{ #category : #line }
DrGStylePreference class >> lineColorIndex: anIndex [
	^ self current lineColor: (self colorFor: anIndex)
]

{ #category : #line }
DrGStylePreference class >> lineColorWidget [
	^ self colorWidget: #lineColorIndex
]

{ #category : #line }
DrGStylePreference class >> lineStyle [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #line }
DrGStylePreference class >> lineStyleFor: index [
	^ self lineStyleSymbols at: index

]

{ #category : #line }
DrGStylePreference class >> lineStyleIndex [
	^ self lineStyleIndexOf: self current lineStyle
]

{ #category : #line }
DrGStylePreference class >> lineStyleIndex: anIndex [
	^ self current lineStyle: (self lineStyleFor: anIndex)
]

{ #category : #line }
DrGStylePreference class >> lineStyleIndexOf: aLineStyle [
	^ self lineStyleSymbols indexOf: aLineStyle
]

{ #category : #line }
DrGStylePreference class >> lineStyleSymbols [
	^ #(#dot #dash #plain) 
]

{ #category : #line }
DrGStylePreference class >> lineStyleWidget [
	^ self styleWidget: #lineStyleIndex
]

{ #category : #settings }
DrGStylePreference class >> lineStylesOn: aBuilder [
	<drgeosettings>
	(aBuilder group: #line)
		label: 'Line' translated;
		order:20;
		parent: #drgeoStyle;
		description: 'Set the default style for line.' translated;
		with: [ 
			(aBuilder setting: #lineColor)
				label: 'Colour' translated.
			(aBuilder setting: #lineStyle)
				label: 'Style' translated.
			(aBuilder setting: #lineThickness)
				label: 'Thickness' translated]
]

{ #category : #line }
DrGStylePreference class >> lineThickness [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #line }
DrGStylePreference class >> lineThicknessIndex [
	^ self thicknessIndexOf: self current lineThickness
]

{ #category : #line }
DrGStylePreference class >> lineThicknessIndex: anIndex [
	^ self current lineThickness: (self thicknessFor: anIndex)
]

{ #category : #line }
DrGStylePreference class >> lineThicknessWidget [
	^ self thicknessWidget: #lineThicknessIndex
]

{ #category : #locus }
DrGStylePreference class >> locusColor [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #locus }
DrGStylePreference class >> locusColorIndex [
	^ self colorIndexOf: self current locusColor
]

{ #category : #locus }
DrGStylePreference class >> locusColorIndex: anIndex [
	^ self current locusColor: (self colorFor: anIndex)
]

{ #category : #locus }
DrGStylePreference class >> locusColorWidget [
	^ self colorWidget: #locusColorIndex
]

{ #category : #locus }
DrGStylePreference class >> locusStyle [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #locus }
DrGStylePreference class >> locusStyleIndex [
	^ self lineStyleIndexOf: self current locusStyle
]

{ #category : #locus }
DrGStylePreference class >> locusStyleIndex: anIndex [
	^ self current locusStyle: (self lineStyleFor: anIndex)
]

{ #category : #locus }
DrGStylePreference class >> locusStyleWidget [
	^ self styleWidget: #locusStyleIndex
]

{ #category : #settings }
DrGStylePreference class >> locusStylesOn: aBuilder [
	<drgeosettings>
	(aBuilder group: #locus)
		label: 'Locus' translated;
		order: 90;
		parent: #drgeoStyle;
		description: 'Set the default style for locus.' translated;
		with: [ 
			(aBuilder setting: #locusColor)
				label: 'Colour' translated.
			(aBuilder setting: #locusStyle)
				label: 'Style' translated.
			(aBuilder setting: #locusThickness)
				label: 'Thickness' translated]
]

{ #category : #locus }
DrGStylePreference class >> locusThickness [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #locus }
DrGStylePreference class >> locusThicknessIndex [
	^ self thicknessIndexOf: self current locusThickness
]

{ #category : #locus }
DrGStylePreference class >> locusThicknessIndex: anIndex [
	^ self current locusThickness: (self thicknessFor: anIndex)
]

{ #category : #locus }
DrGStylePreference class >> locusThicknessWidget [
	^ self thicknessWidget: #locusThicknessIndex

]

{ #category : #segment }
DrGStylePreference class >> markFor: index [
	^ self markSymbols at: index
]

{ #category : #segment }
DrGStylePreference class >> markIndexOf: aMark [
	^ self markSymbols indexOf: aMark
]

{ #category : #segment }
DrGStylePreference class >> markMorphCollection [
	^ self markSymbols collect: [:symbol |
		 (DrGIcons 
			segment: (self widthFor: #small) 
			color: Color black 
			mark: symbol) asMorph]
]

{ #category : #segment }
DrGStylePreference class >> markSymbols [
	^ #(#none #mark1 #mark2 #mark3 #disc #circle)
]

{ #category : #'instance creation' }
DrGStylePreference class >> new [
	self error: 'You may access my unique instance with the #current message.'
]

{ #category : #point }
DrGStylePreference class >> pointColor [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #point }
DrGStylePreference class >> pointColorIndex [
	^ self colorIndexOf: self current pointColor
]

{ #category : #point }
DrGStylePreference class >> pointColorIndex: anIndex [
	^ self current pointColor: (self colorFor: anIndex)
]

{ #category : #point }
DrGStylePreference class >> pointColorWidget [
	^ self colorWidget: #pointColorIndex
]

{ #category : #point }
DrGStylePreference class >> pointExtentFor: pointSize [
	pointSize == #small ifTrue: [^ 6@6].
	pointSize == #large ifTrue: [^ 10@10].
	^ 8@8.
]

{ #category : #point }
DrGStylePreference class >> pointShape [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #point }
DrGStylePreference class >> pointShapeFor: index [
	^ self pointShapeSymbols at: index
]

{ #category : #point }
DrGStylePreference class >> pointShapeIndex [
	^ self pointShapeIndexOf: self current pointShape
]

{ #category : #point }
DrGStylePreference class >> pointShapeIndex: anIndex [
	^ self current pointShape: (self pointShapeFor: anIndex) 
]

{ #category : #point }
DrGStylePreference class >> pointShapeIndexOf: pointShape [
	^ self pointShapeSymbols indexOf: pointShape
]

{ #category : #point }
DrGStylePreference class >> pointShapeSymbols [
	^ #(#cross #round #square)
]

{ #category : #point }
DrGStylePreference class >> pointShapeWidget [
	^ (UITheme builder
			newMorphDropListFor: self
			list: #shapeMorphCollection
			getSelected: #pointShapeIndex
			setSelected: #pointShapeIndex:
			help: nil) 
]

{ #category : #point }
DrGStylePreference class >> pointSize [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #point }
DrGStylePreference class >> pointSizeFor: index [
	^ self pointSizeSymbols at: index
]

{ #category : #point }
DrGStylePreference class >> pointSizeIndex [
	^ self pointSizeIndexOf: self current pointSize
]

{ #category : #point }
DrGStylePreference class >> pointSizeIndex: anIndex [
	^ self current pointSize: (self pointSizeFor: anIndex)
]

{ #category : #point }
DrGStylePreference class >> pointSizeIndexOf: aSize [
	^ self pointSizeSymbols indexOf: aSize
]

{ #category : #point }
DrGStylePreference class >> pointSizeSymbols [
	^ #(#small #medium #large)
]

{ #category : #point }
DrGStylePreference class >> pointSizeWidget [
	^ (UITheme builder
			newMorphDropListFor: self
			list: #sizeMorphCollection
			getSelected: #pointSizeIndex
			setSelected: #pointSizeIndex:
			help: nil) 
]

{ #category : #settings }
DrGStylePreference class >> pointStylesOn: aBuilder [
	<drgeosettings>
	(aBuilder group: #point)
		label: 'Point' translated;
		order:10;
		parent: #drgeoStyle;
		description: 'Set the default style for point.' translated;
		with: [ 
			(aBuilder setting: #pointColor)
				label: 'Colour' translated.
			(aBuilder setting: #pointShape)
				label: 'Shape' translated.
			(aBuilder setting: #pointSize)
				label: 'Size' translated ]
]

{ #category : #polygon }
DrGStylePreference class >> polygonColor [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #polygon }
DrGStylePreference class >> polygonColorIndex [
	^ self colorIndexOf: self current polygonColor
]

{ #category : #polygon }
DrGStylePreference class >> polygonColorIndex: anIndex [
	^ self current polygonColor: (self colorFor: anIndex)
]

{ #category : #polygon }
DrGStylePreference class >> polygonColorWidget [
	^ self colorWidget: #polygonColorIndex
]

{ #category : #polygon }
DrGStylePreference class >> polygonFilled [
	^ self current polygonFilled
]

{ #category : #polygon }
DrGStylePreference class >> polygonFilled: aBoolean [
	^ self current polygonFilled: aBoolean
]

{ #category : #polygon }
DrGStylePreference class >> polygonStyle [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #polygon }
DrGStylePreference class >> polygonStyleIndex [
	^ self lineStyleIndexOf: self current polygonStyle
]

{ #category : #polygon }
DrGStylePreference class >> polygonStyleIndex: anIndex [
	^ self current polygonStyle: (self lineStyleFor: anIndex)
]

{ #category : #polygon }
DrGStylePreference class >> polygonStyleWidget [
	^ self styleWidget: #polygonStyleIndex
]

{ #category : #settings }
DrGStylePreference class >> polygonStylesOn: aBuilder [
	<drgeosettings>
	(aBuilder group: #polygon)
		label: 'Polygon' translated;
		order: 80;
		parent: #drgeoStyle;
		description: 'Set the default style for polygon.' translated;
		with: [
			(aBuilder setting: #polygonColor)
				order: 1;
				label: 'Colour' translated.
			(aBuilder setting: #polygonStyle)
				order: 2;
				label: 'Style' translated.
			(aBuilder setting: #polygonThickness)
				order: 3;
				label: 'Thickness' translated.
			(aBuilder setting: #polygonFilled)
				order: 4;
				label: 'Fill' translated.
			(aBuilder setting: #polygonTranslucent)
				order: 5;
				label: 'Translucent' translated].

]

{ #category : #polygon }
DrGStylePreference class >> polygonThickness [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #polygon }
DrGStylePreference class >> polygonThicknessIndex [
	^ self thicknessIndexOf: self current polygonThickness
]

{ #category : #polygon }
DrGStylePreference class >> polygonThicknessIndex: anIndex [
	^ self current polygonThickness: (self thicknessFor: anIndex)
]

{ #category : #polygon }
DrGStylePreference class >> polygonThicknessWidget [
	^ self thicknessWidget: #polygonThicknessIndex

]

{ #category : #polygon }
DrGStylePreference class >> polygonTranslucent [
	^ self current polygonTranslucent
]

{ #category : #polygon }
DrGStylePreference class >> polygonTranslucent: aBoolean [
	^ self current polygonTranslucent: aBoolean
]

{ #category : #ray }
DrGStylePreference class >> rayColor [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #ray }
DrGStylePreference class >> rayColorIndex [
	^ self colorIndexOf: self current rayColor
]

{ #category : #ray }
DrGStylePreference class >> rayColorIndex: anIndex [
	^ self current rayColor: (self colorFor: anIndex)
]

{ #category : #ray }
DrGStylePreference class >> rayColorWidget [
	^ self colorWidget: #rayColorIndex
]

{ #category : #ray }
DrGStylePreference class >> rayStyle [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #ray }
DrGStylePreference class >> rayStyleIndex [
	^ self lineStyleIndexOf: self current rayStyle
]

{ #category : #ray }
DrGStylePreference class >> rayStyleIndex: anIndex [
	^ self current rayStyle: (self lineStyleFor: anIndex)
]

{ #category : #ray }
DrGStylePreference class >> rayStyleWidget [
	^ self styleWidget: #rayStyleIndex
]

{ #category : #settings }
DrGStylePreference class >> rayStylesOn: aBuilder [
	<drgeosettings>
	(aBuilder group: #ray)
		label: 'Ray' translated;
		order:30;
		parent: #drgeoStyle;
		description: 'Set the default style for ray.' translated;
		with: [ 
			(aBuilder setting: #rayColor)
				label: 'Colour' translated.
			(aBuilder setting: #rayStyle)
				label: 'Style' translated.
			(aBuilder setting: #rayThickness)
				label: 'Thickness' translated ]
]

{ #category : #ray }
DrGStylePreference class >> rayThickness [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #ray }
DrGStylePreference class >> rayThicknessIndex [
	^ self thicknessIndexOf: self current rayThickness
]

{ #category : #ray }
DrGStylePreference class >> rayThicknessIndex: anIndex [
	^ self current rayThickness: (self thicknessFor: anIndex)
]

{ #category : #ray }
DrGStylePreference class >> rayThicknessWidget [
	^ self thicknessWidget: #rayThicknessIndex

]

{ #category : #'as yet unclassified' }
DrGStylePreference class >> reset [
"reset all the style preference"
	self allInstVarNames do: [ :instVarName |
		self current instVarNamed: instVarName put: nil]

]

{ #category : #segment }
DrGStylePreference class >> segmentArrow [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #segment }
DrGStylePreference class >> segmentArrowIndex [
	^ self arrowIndexOf: self current segmentArrow
]

{ #category : #segment }
DrGStylePreference class >> segmentArrowIndex: anIndex [
	^ self current segmentArrow: (self arrowFor: anIndex)
]

{ #category : #segment }
DrGStylePreference class >> segmentArrowWidget [
	^ self arrowWidget: #segmentArrowIndex
]

{ #category : #segment }
DrGStylePreference class >> segmentColor [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #segment }
DrGStylePreference class >> segmentColorIndex [
	^ self colorIndexOf: self current segmentColor
]

{ #category : #segment }
DrGStylePreference class >> segmentColorIndex: anIndex [
	^ self current segmentColor: (self colorFor: anIndex)
]

{ #category : #segment }
DrGStylePreference class >> segmentColorWidget [
	^ self colorWidget: #segmentColorIndex
]

{ #category : #segment }
DrGStylePreference class >> segmentMark [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #segment }
DrGStylePreference class >> segmentMarkIndex [
	^ self markIndexOf: self current segmentMark
]

{ #category : #segment }
DrGStylePreference class >> segmentMarkIndex: anIndex [
	^ self current segmentMark: (self markFor: anIndex)
]

{ #category : #segment }
DrGStylePreference class >> segmentMarkWidget [
	^ (UITheme builder
			newMorphDropListFor: self
			list: #markMorphCollection
			getSelected: #segmentMarkIndex
			setSelected: #segmentMarkIndex:
			help: nil) minWidth: DrGIcons menuExtent x + 35
]

{ #category : #segment }
DrGStylePreference class >> segmentStyle [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #segment }
DrGStylePreference class >> segmentStyleIndex [
	^ self lineStyleIndexOf: self current segmentStyle
]

{ #category : #segment }
DrGStylePreference class >> segmentStyleIndex: anIndex [
	^ self current segmentStyle: (self lineStyleFor: anIndex)
]

{ #category : #segment }
DrGStylePreference class >> segmentStyleWidget [
	^ self styleWidget: #segmentStyleIndex
]

{ #category : #settings }
DrGStylePreference class >> segmentStylesOn: aBuilder [
	<drgeosettings>
	(aBuilder group: #segment)
		label: 'Segment' translated;
		order:40;
		parent: #drgeoStyle;
		description: 'Set the default style for segment.' translated;
		with: [
			(aBuilder setting: #segmentColor)
				order: 1;
				label: 'Colour' translated.
			(aBuilder setting: #segmentStyle)
				order: 2;
				label: 'Style' translated.
			(aBuilder setting: #segmentThickness)
				order: 3;
				label: 'Thickness' translated.
			(aBuilder setting: #segmentArrow)
				order: 4;
				label: 'Arrow' translated.	
			(aBuilder setting: #segmentMark)
				order: 5;
				label: 'Mark' translated].

]

{ #category : #segment }
DrGStylePreference class >> segmentThickness [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #segment }
DrGStylePreference class >> segmentThicknessIndex [
	^ self thicknessIndexOf: self current segmentThickness
]

{ #category : #segment }
DrGStylePreference class >> segmentThicknessIndex: anIndex [
	^ self current segmentThickness: (self thicknessFor: anIndex)
]

{ #category : #segment }
DrGStylePreference class >> segmentThicknessWidget [
	^ self thicknessWidget: #segmentThicknessIndex

]

{ #category : #settings }
DrGStylePreference class >> settingInputWidgetForNode: aSettingDeclaration [
	^ (aSettingDeclaration name, 'Widget') asSymbol value: self.
]

{ #category : #point }
DrGStylePreference class >> shapeMorphCollection [
	^ self pointShapeSymbols collect: [:symbol |
		(DrGIcons 
			point: (self pointExtentFor: #medium) 
			color: Color black 
			shape: symbol) asMorph].

]

{ #category : #point }
DrGStylePreference class >> sizeMorphCollection [
	^ self  pointSizeSymbols collect: [:symbol |
		(DrGIcons 
			point: (self pointExtentFor: symbol) 
			color: Color black 
			shape: #square) asMorph].

]

{ #category : #line }
DrGStylePreference class >> styleFor: aStyle [
	"possible lineStyle"
	aStyle = #dot ifTrue: [^ #(2 3)].
	aStyle = #dash ifTrue: [^ #(5 8)].
	^ nil
]

{ #category : #line }
DrGStylePreference class >> styleLineMorphCollection [
	^ self lineStyleSymbols collect: [:symbol |
		(DrGIcons 
			segment: (self widthFor: #small)
			color: Color black
			dash: (self styleFor: symbol)) asMorph]
]

{ #category : #helpers }
DrGStylePreference class >> styleWidget: getAccessor [
	^ (UITheme builder
			newMorphDropListFor: self
			list: #styleLineMorphCollection
			getSelected: getAccessor
			setSelected: (getAccessor, ':') asSymbol
			help: nil) minWidth: DrGIcons menuExtent x + 35
]

{ #category : #'value & text' }
DrGStylePreference class >> textBackgroundColor [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #'value & text' }
DrGStylePreference class >> textBackgroundColorIndex [
	^ self colorIndexOf: self current textBackgroundColor
]

{ #category : #'value & text' }
DrGStylePreference class >> textBackgroundColorIndex: anIndex [
	^ self current textBackgroundColor: (self colorFor: anIndex)
]

{ #category : #'value & text' }
DrGStylePreference class >> textBackgroundColorWidget [
	^ self colorWidget: #textBackgroundColorIndex
]

{ #category : #'value & text' }
DrGStylePreference class >> textColor [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #'value & text' }
DrGStylePreference class >> textColorIndex [
	^ self colorIndexOf: self current textColor
]

{ #category : #'value & text' }
DrGStylePreference class >> textColorIndex: anIndex [
	^ self current textColor: (self colorFor: anIndex)
]

{ #category : #'value & text' }
DrGStylePreference class >> textColorWidget [
	^ self colorWidget: #textColorIndex
]

{ #category : #settings }
DrGStylePreference class >> textStylesOn: aBuilder [
	<drgeosettings>
	(aBuilder group: #Text)
		label: 'Text' translated;
		order: 110;
		parent: #drgeoStyle;
		description: 'Set the default style for text.' translated;
		with: [ 
			(aBuilder setting: #textColor)
				order: 1;
				label: 'Colour' translated.
			(aBuilder setting: #textBackgroundColor)
				order: 2;
				label: 'Background' translated]
]

{ #category : #line }
DrGStylePreference class >> thicknessFor: index [
	^ self thicknessSymbols at: index
]

{ #category : #line }
DrGStylePreference class >> thicknessIndexOf: thickness [
	^ self thicknessSymbols indexOf: thickness
]

{ #category : #line }
DrGStylePreference class >> thicknessMorphCollection [
	^ self thicknessSymbols collect: [:symbol |
		(DrGIcons 
			segment: (self widthFor: symbol)
			color: Color black
			dash: nil) asMorph]
]

{ #category : #line }
DrGStylePreference class >> thicknessSymbols [
	^ #(#small #medium #large)
]

{ #category : #helpers }
DrGStylePreference class >> thicknessWidget: getAccessor [
	^ (UITheme builder
			newMorphDropListFor: self
			list: #thicknessMorphCollection
			getSelected: getAccessor
			setSelected: (getAccessor, ':') asSymbol 
			help: nil) minWidth: DrGIcons menuExtent x + 35
]

{ #category : #'value & text' }
DrGStylePreference class >> valueColor [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #'value & text' }
DrGStylePreference class >> valueColorIndex [
	^ self colorIndexOf: self current valueColor
]

{ #category : #'value & text' }
DrGStylePreference class >> valueColorIndex: anIndex [
	^ self current valueColor: (self colorFor: anIndex)
]

{ #category : #'value & text' }
DrGStylePreference class >> valueColorWidget [
	^ self colorWidget: #valueColorIndex
]

{ #category : #settings }
DrGStylePreference class >> valueStylesOn: aBuilder [
	<drgeosettings>
	(aBuilder group: #value)
		label: 'Value' translated;
		order: 100;
		parent: #drgeoStyle;
		description: 'Set the default style for value.' translated;
		with: [ 
			(aBuilder setting: #valueColor)
				label: 'Colour' translated]
]

{ #category : #vector }
DrGStylePreference class >> vectorColor [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #vector }
DrGStylePreference class >> vectorColorIndex [
	^ self colorIndexOf: self current vectorColor
]

{ #category : #vector }
DrGStylePreference class >> vectorColorIndex: anIndex [
	^ self current vectorColor: (self colorFor: anIndex)
]

{ #category : #vector }
DrGStylePreference class >> vectorColorWidget [
	^ self colorWidget: #vectorColorIndex
]

{ #category : #vector }
DrGStylePreference class >> vectorStyle [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #vector }
DrGStylePreference class >> vectorStyleIndex [
	^ self lineStyleIndexOf: self current vectorStyle
]

{ #category : #vector }
DrGStylePreference class >> vectorStyleIndex: anIndex [
	^ self current vectorStyle: (self lineStyleFor: anIndex)
]

{ #category : #vector }
DrGStylePreference class >> vectorStyleWidget [
	^ self styleWidget: #vectorStyleIndex
]

{ #category : #settings }
DrGStylePreference class >> vectorStylesOn: aBuilder [
	<drgeosettings>
	(aBuilder group: #vector)
		label: 'Vector' translated;
		order:50;
		parent: #drgeoStyle;
		description: 'Set the default style for vector.' translated;
		with: [
			(aBuilder setting: #vectorColor)
				label: 'Colour' translated.
			(aBuilder setting: #vectorStyle)
				label: 'Style' translated.
			(aBuilder setting: #vectorThickness)
				label: 'Thickness' translated].

]

{ #category : #vector }
DrGStylePreference class >> vectorThickness [
"respond the singleton, widget build up set later"
	^ self current
]

{ #category : #vector }
DrGStylePreference class >> vectorThicknessIndex [
	^ self thicknessIndexOf: self current vectorThickness
]

{ #category : #vector }
DrGStylePreference class >> vectorThicknessIndex: anIndex [
	^ self current vectorThickness: (self thicknessFor: anIndex)
]

{ #category : #vector }
DrGStylePreference class >> vectorThicknessWidget [
	^ self thicknessWidget: #vectorThicknessIndex

]

{ #category : #line }
DrGStylePreference class >> widthFor: aThickness [
	"give the width"
	aThickness = #small ifTrue: [^1].
	aThickness = #medium ifTrue: [^2].
	aThickness = #large ifTrue: [^3].
	^ 0
]

{ #category : #arc }
DrGStylePreference >> arcArrow [
	^ arcArrow ifNil: [ arcArrow := #makeNoArrows ]
]

{ #category : #arc }
DrGStylePreference >> arcArrow: anObject [
	arcArrow := anObject
]

{ #category : #arc }
DrGStylePreference >> arcColor [
	^ arcColor ifNil: [ arcColor := Color black ]
]

{ #category : #arc }
DrGStylePreference >> arcColor: anObject [
	arcColor := anObject
]

{ #category : #arc }
DrGStylePreference >> arcFilled [
	^ arcFilled ifNil: [ arcFilled := false ]
]

{ #category : #arc }
DrGStylePreference >> arcFilled: anObject [
	arcFilled := anObject
]

{ #category : #arc }
DrGStylePreference >> arcStyle [
	^ arcStyle ifNil: [ arcStyle := #plain ]
]

{ #category : #arc }
DrGStylePreference >> arcStyle: anObject [
	arcStyle := anObject
]

{ #category : #arc }
DrGStylePreference >> arcThickness [
	^ arcThickness ifNil: [ arcThickness := #small ]
]

{ #category : #arc }
DrGStylePreference >> arcThickness: anObject [
	arcThickness := anObject
]

{ #category : #arc }
DrGStylePreference >> arcTranslucent [
	^ arcTranslucent ifNil: [ arcTranslucent := true ]
]

{ #category : #arc }
DrGStylePreference >> arcTranslucent: anObject [
	arcTranslucent := anObject
]

{ #category : #circle }
DrGStylePreference >> circleColor [
	^ circleColor ifNil: [ circleColor := Color black ]
]

{ #category : #circle }
DrGStylePreference >> circleColor: anObject [
	circleColor := anObject
]

{ #category : #circle }
DrGStylePreference >> circleFilled [
	^ circleFilled ifNil: [ circleFilled := false ]
]

{ #category : #circle }
DrGStylePreference >> circleFilled: anObject [
	circleFilled := anObject
]

{ #category : #circle }
DrGStylePreference >> circleStyle [
	^ circleStyle ifNil: [ circleStyle := #plain ]
]

{ #category : #circle }
DrGStylePreference >> circleStyle: anObject [
	circleStyle := anObject
]

{ #category : #circle }
DrGStylePreference >> circleThickness [
	^ circleThickness ifNil: [ circleThickness := #small ]
]

{ #category : #circle }
DrGStylePreference >> circleThickness: anObject [
	circleThickness := anObject
]

{ #category : #circle }
DrGStylePreference >> circleTranslucent [
	^ circleTranslucent ifNil: [ circleTranslucent := true ]
]

{ #category : #circle }
DrGStylePreference >> circleTranslucent: anObject [
	circleTranslucent := anObject
]

{ #category : #line }
DrGStylePreference >> lineColor [
	^ lineColor ifNil: [ lineColor := Color black ]
]

{ #category : #line }
DrGStylePreference >> lineColor: anObject [
	lineColor := anObject
]

{ #category : #line }
DrGStylePreference >> lineStyle [
	^ lineStyle ifNil: [ lineStyle := #plain ]
]

{ #category : #line }
DrGStylePreference >> lineStyle: anObject [
	lineStyle := anObject
]

{ #category : #line }
DrGStylePreference >> lineThickness [
	^ lineThickness ifNil: [ lineThickness := #small ]
]

{ #category : #line }
DrGStylePreference >> lineThickness: anObject [
	lineThickness := anObject
]

{ #category : #locus }
DrGStylePreference >> locusColor [
	^ locusColor ifNil: [ locusColor := Color red ]
]

{ #category : #locus }
DrGStylePreference >> locusColor: aColor [
	locusColor := aColor
]

{ #category : #locus }
DrGStylePreference >> locusStyle [
	^ locusStyle ifNil: [ locusStyle := #plain ]
]

{ #category : #locus }
DrGStylePreference >> locusStyle: aSymbol [
	locusStyle := aSymbol 
]

{ #category : #locus }
DrGStylePreference >> locusThickness [
	^ locusThickness ifNil: [ locusThickness := #small ]
]

{ #category : #locus }
DrGStylePreference >> locusThickness: aSymbol [
	locusThickness := aSymbol 
]

{ #category : #point }
DrGStylePreference >> pointColor [
	^ pointColor ifNil: [ pointColor := Color red ]
]

{ #category : #point }
DrGStylePreference >> pointColor: anObject [
	pointColor := anObject
]

{ #category : #point }
DrGStylePreference >> pointShape [
	^ pointShape ifNil: [ pointShape := #round ]
]

{ #category : #point }
DrGStylePreference >> pointShape: anObject [
	pointShape := anObject
]

{ #category : #point }
DrGStylePreference >> pointSize [
	^ pointSize ifNil: [ pointSize := #small ]
]

{ #category : #point }
DrGStylePreference >> pointSize: anObject [
	pointSize := anObject
]

{ #category : #polygon }
DrGStylePreference >> polygonColor [
	^ polygonColor ifNil: [ polygonColor := Color blue ]
]

{ #category : #polygon }
DrGStylePreference >> polygonColor: anObject [
	polygonColor := anObject
]

{ #category : #polygon }
DrGStylePreference >> polygonFilled [
	^ polygonFilled ifNil: [ polygonFilled := true ]
]

{ #category : #polygon }
DrGStylePreference >> polygonFilled: anObject [
	polygonFilled := anObject
]

{ #category : #polygon }
DrGStylePreference >> polygonStyle [
	^ polygonStyle ifNil: [ polygonStyle := #plain ]
]

{ #category : #polygon }
DrGStylePreference >> polygonStyle: anObject [
	polygonStyle := anObject
]

{ #category : #polygon }
DrGStylePreference >> polygonThickness [
	^ polygonThickness ifNil: [ polygonThickness := #small ]
]

{ #category : #polygon }
DrGStylePreference >> polygonThickness: anObject [
	polygonThickness := anObject
]

{ #category : #polygon }
DrGStylePreference >> polygonTranslucent [
	^ polygonTranslucent ifNil: [ polygonTranslucent := true ]
]

{ #category : #polygon }
DrGStylePreference >> polygonTranslucent: anObject [
	polygonTranslucent := anObject
]

{ #category : #ray }
DrGStylePreference >> rayColor [
	^ rayColor ifNil: [ rayColor := Color black ]
]

{ #category : #ray }
DrGStylePreference >> rayColor: aColor [
	rayColor := aColor
]

{ #category : #ray }
DrGStylePreference >> rayStyle [
	^ rayStyle ifNil: [ rayStyle := #plain ]
]

{ #category : #ray }
DrGStylePreference >> rayStyle: aSymbol [
	rayStyle := aSymbol 
]

{ #category : #ray }
DrGStylePreference >> rayThickness [
	^ rayThickness ifNil: [ rayThickness := #small ]
]

{ #category : #ray }
DrGStylePreference >> rayThickness: aSymbol [
	rayThickness := aSymbol 
]

{ #category : #segment }
DrGStylePreference >> segmentArrow [
	^ segmentArrow ifNil: [ segmentArrow := #makeNoArrows ]
]

{ #category : #segment }
DrGStylePreference >> segmentArrow: anObject [
	segmentArrow := anObject
]

{ #category : #segment }
DrGStylePreference >> segmentColor [
	^ segmentColor ifNil: [ segmentColor := Color black ]
]

{ #category : #segment }
DrGStylePreference >> segmentColor: anObject [
	segmentColor := anObject
]

{ #category : #segment }
DrGStylePreference >> segmentMark [
	^ segmentMark ifNil: [ segmentMark := #none ]
]

{ #category : #segment }
DrGStylePreference >> segmentMark: anObject [
	segmentMark := anObject
]

{ #category : #segment }
DrGStylePreference >> segmentStyle [
	^ segmentStyle ifNil: [ segmentStyle := #plain ]
]

{ #category : #segment }
DrGStylePreference >> segmentStyle: anObject [
	segmentStyle := anObject
]

{ #category : #segment }
DrGStylePreference >> segmentThickness [
	^ segmentThickness ifNil: [ segmentThickness := #small ]
]

{ #category : #segment }
DrGStylePreference >> segmentThickness: anObject [
	segmentThickness := anObject
]

{ #category : #'value & text' }
DrGStylePreference >> textBackgroundColor [
	^ textBackgroundColor ifNil: [ textBackgroundColor := Color white ]
]

{ #category : #'value & text' }
DrGStylePreference >> textBackgroundColor: anObject [
	textBackgroundColor := anObject
]

{ #category : #'value & text' }
DrGStylePreference >> textBorderColor [
	^ textBorderColor ifNil: [ textBorderColor := Color transparent]
]

{ #category : #'value & text' }
DrGStylePreference >> textBorderColor: anObject [
	textBorderColor := anObject
]

{ #category : #'value & text' }
DrGStylePreference >> textColor [
	^ textColor ifNil: [ textColor := Color black ]
]

{ #category : #'value & text' }
DrGStylePreference >> textColor: anObject [
	textColor := anObject
]

{ #category : #'value & text' }
DrGStylePreference >> valueColor [
	^ valueColor ifNil: [ valueColor := Color black ]
]

{ #category : #'value & text' }
DrGStylePreference >> valueColor: anObject [
	valueColor := anObject
]

{ #category : #vector }
DrGStylePreference >> vectorColor [
	^ vectorColor ifNil: [ vectorColor := Color black ]
]

{ #category : #vector }
DrGStylePreference >> vectorColor: anObject [
	vectorColor := anObject
]

{ #category : #vector }
DrGStylePreference >> vectorStyle [
	^ vectorStyle ifNil: [ vectorStyle := #plain ]
]

{ #category : #vector }
DrGStylePreference >> vectorStyle: anObject [
	vectorStyle := anObject
]

{ #category : #vector }
DrGStylePreference >> vectorThickness [
	^ vectorThickness ifNil: [ vectorThickness := #small ]
]

{ #category : #vector }
DrGStylePreference >> vectorThickness: anObject [
	vectorThickness := anObject
]
