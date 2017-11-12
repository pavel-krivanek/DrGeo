Class {
	#name : #DrGSegmentMarkMorph,
	#superclass : #DrGSegmentMorph,
	#instVars : [
		'forcedMark'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #private }
DrGSegmentMarkMorph >> computeBounds [ 
	super computeBounds. 
	self costumeMark ~= #none ifTrue: [
		bounds := bounds merge: (Rectangle
			center: (vertices at: 1) + (vertices at: 2) //2
			extent: (self borderWidth * 6 + 9) asPoint).
		self layoutChanged.
		self changed].
	
]

{ #category : #accessing }
DrGSegmentMarkMorph >> costumeMark [
	forcedMark ifNotNil: [^forcedMark].
	costume ifNil: [^#none].
	costume style ifNil: [^#none].
	^ costume style mark ifNil: [#none]
]

{ #category : #drawing }
DrGSegmentMarkMorph >> drawCircleOn: aCanvas [ 
	|rectangle|
	rectangle := Rectangle 
		center:  (vertices first + vertices second / 2)
		extent: (4 @ 4 + (self borderWidth  * 2)).
	aCanvas frameOval: rectangle width: self borderWidth color: self borderColor.
]

{ #category : #drawing }
DrGSegmentMarkMorph >> drawCircleOnAthens: aCanvas [ 
	|rectangle path|
	rectangle := Rectangle 
		center:  (vertices first + vertices second / 2)
		extent: (4 @ 4 + (self borderWidth  * 2)).
	path := aCanvas createPath: [ :builder |
		builder absolute;
			moveTo: rectangle leftCenter;
			cwArcTo: rectangle rightCenter angle: Float pi;
			cwArcTo: rectangle leftCenter angle: Float pi].
	aCanvas setShape: path.
	(aCanvas setStrokePaint: self borderColor) width: self borderWidth.
	aCanvas draw
]

{ #category : #drawing }
DrGSegmentMarkMorph >> drawDiscOn: aCanvas [ 
	| rectangle|
	rectangle := Rectangle 
		center: (vertices first + vertices second // 2)
		extent: (4 @ 4 + (self borderWidth  * 2)).
	aCanvas fillOval: rectangle color: self borderColor.
]

{ #category : #drawing }
DrGSegmentMarkMorph >> drawDiscOnAthens: aCanvas [ 
	| rectangle path|
	rectangle := Rectangle 
		center: (vertices first + vertices second / 2)
		extent: (4 @ 4 + (self borderWidth  * 2)).
	path := aCanvas createPath: [ :builder |
		builder absolute;
			moveTo: rectangle leftCenter;
			cwArcTo: rectangle rightCenter angle: Float pi;
			cwArcTo: rectangle leftCenter angle: Float pi].
	aCanvas setShape: path;
		setPaint: self borderColor;
		draw.
	(aCanvas setStrokePaint: self borderColor)	 width: self borderWidth.
	aCanvas draw.
]

{ #category : #drawing }
DrGSegmentMarkMorph >> drawMark1On: aCanvas [ 
	|center vector u n startPoint endPoint |
	startPoint := vertices at: 1.
	endPoint := vertices at: 2.
	center := startPoint + endPoint / 2.
	vector := endPoint - startPoint.
	[u := vector normalized] on: ZeroDivide do: [u := 0@1].
	n := u y @ u x negated.
	vector :=  (u + n ) normalized * (self borderWidth + 1 * 3).
	aCanvas 
		line: center - vector
		to: center + vector
		width: self borderWidth  
		color: self borderColor.
]

{ #category : #drawing }
DrGSegmentMarkMorph >> drawMark1OnAthens: aCanvas [ 
	|center vector u n startPoint endPoint path|
	startPoint := vertices at: 1.
	endPoint := vertices at: 2.
	center := startPoint + endPoint / 2.
	vector := endPoint - startPoint.
	[u := vector normalized] on: ZeroDivide do: [u := 0@1].
	n := u y @ u x negated.
	vector :=  (u + n ) normalized * (self borderWidth + 1 * 3).
	path := aCanvas createPath: [ :builder |
		builder absolute;
			moveTo: center - vector;
			lineTo: center + vector].
	aCanvas setShape: path.
	(aCanvas setStrokePaint: self borderColor) width: self borderWidth.
	aCanvas draw
]

{ #category : #drawing }
DrGSegmentMarkMorph >> drawMark2On: aCanvas [ 
	|center vector u n startPoint endPoint |
	startPoint := vertices at: 1.
	endPoint := vertices at: 2.
	vector := endPoint - startPoint.
	[u := vector normalized] on: ZeroDivide do: [u := 0@1].
	n := u y @ u x negated.
	vector :=  (u + n ) normalized * (self borderWidth + 1 * 3).
	center := (startPoint + endPoint / 2) - (u * (self borderWidth  * 1.5)).
	2 timesRepeat: [
		aCanvas 
			line: center - vector
			to: center + vector
			width: self borderWidth  
			color: self borderColor.
		center := center + (u * (self borderWidth  * 3))].
]

{ #category : #drawing }
DrGSegmentMarkMorph >> drawMark2OnAthens: aCanvas [ 
	|center vector u n startPoint endPoint path |
	startPoint := vertices at: 1.
	endPoint := vertices at: 2.
	vector := endPoint - startPoint.
	[u := vector normalized] on: ZeroDivide do: [u := 0@1].
	n := u y @ u x negated.
	vector :=  (u + n ) normalized * (self borderWidth + 1 * 3).
	center := (startPoint + endPoint / 2) - (u * (self borderWidth  * 1.5)).
	2 timesRepeat: [
		path := aCanvas createPath: [ :builder |
			builder absolute;
				moveTo: center - vector;
				lineTo: center + vector].
		aCanvas setShape: path.
		(aCanvas setStrokePaint: self borderColor) width: self borderWidth.
		aCanvas draw.		
		center := center + (u * (self borderWidth  * 3))].
]

{ #category : #drawing }
DrGSegmentMarkMorph >> drawMark3On: aCanvas [ 
	|center vector u n startPoint endPoint |
	startPoint := vertices at: 1.
	endPoint := vertices at: 2.
	vector := endPoint - startPoint.
	[u := vector normalized] on: ZeroDivide do: [u := 0@1].
	n := u y @ u x negated.
	vector :=  (u + n ) normalized * (self borderWidth + 1 * 3).
	center := (startPoint + endPoint / 2) - (u * (self borderWidth * 3)).
	3 timesRepeat: [
		aCanvas 
			line: center - vector
			to: center + vector
			width: self borderWidth 
			color: self borderColor.
		center := center + (u * (self borderWidth  * 3))].
]

{ #category : #drawing }
DrGSegmentMarkMorph >> drawMark3OnAthens: aCanvas [ 
	|center vector u n startPoint endPoint path |
	startPoint := vertices at: 1.
	endPoint := vertices at: 2.
	vector := endPoint - startPoint.
	[u := vector normalized] on: ZeroDivide do: [u := 0@1].
	n := u y @ u x negated.
	vector :=  (u + n ) normalized * (self borderWidth + 1 * 3).
	center := (startPoint + endPoint / 2) - (u * (self borderWidth * 3)).
	3 timesRepeat: [
		path := aCanvas createPath: [ :builder |
			builder absolute;
				moveTo: center - vector;
				lineTo: center + vector].
		aCanvas setShape: path.
		(aCanvas setStrokePaint: self borderColor) width: self borderWidth.
		aCanvas draw.		
		center := center + (u * (self borderWidth  * 3))].
]

{ #category : #drawing }
DrGSegmentMarkMorph >> drawMarkOn: aCanvas [
	|mark|
	forcedMark 
		ifNotNil: [mark := forcedMark]
		ifNil: [mark := costume style mark].
	mark == #none ifTrue: [^self].
	mark == #mark1 ifTrue: [^ self drawMark1On: aCanvas].
	mark == #mark2 ifTrue: [^ self drawMark2On: aCanvas].
	mark == #mark3 ifTrue: [^ self drawMark3On: aCanvas].
	mark == #disc ifTrue: [^ self drawDiscOn: aCanvas].
	mark == #circle ifTrue: [^ self drawCircleOn: aCanvas].
	

]

{ #category : #drawing }
DrGSegmentMarkMorph >> drawMarkOnAthensCanvas: aCanvas [
	|mark|
	forcedMark 
		ifNotNil: [mark := forcedMark]
		ifNil: [mark := costume style mark].
	mark == #none ifTrue: [^self].
	mark == #mark1 ifTrue: [^ self drawMark1OnAthens: aCanvas].
	mark == #mark2 ifTrue: [^ self drawMark2OnAthens: aCanvas].
	mark == #mark3 ifTrue: [^ self drawMark3OnAthens: aCanvas].
	mark == #disc ifTrue: [^ self drawDiscOnAthens: aCanvas].
	mark == #circle ifTrue: [^ self drawCircleOnAthens: aCanvas].
	

]

{ #category : #drawing }
DrGSegmentMarkMorph >> drawOn: aCanvas [
	super drawOn: aCanvas.
	self drawMarkOn: aCanvas
]

{ #category : #drawing }
DrGSegmentMarkMorph >> drawOnAthensCanvas: aCanvas [
	super drawOnAthensCanvas: aCanvas.
	self drawMarkOnAthensCanvas: aCanvas
]

{ #category : #accessing }
DrGSegmentMarkMorph >> forcedMark: symbol [
	forcedMark := symbol
]
