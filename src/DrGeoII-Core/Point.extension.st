Extension { #name : #Point }

{ #category : #'*DrGeoII-Core-printing' }
Point >> printShowingDecimalPlaces: placeDesired [ 
"do not round when coordinate is a fraction"
	|stringX stringY|
	x isFraction
		ifTrue: [stringX := x printString]
		ifFalse: [stringX := x printShowingDecimalPlaces: placeDesired].
	y isFraction
		ifTrue: [stringY := y printString] 
		ifFalse: [stringY := y printShowingDecimalPlaces: placeDesired].		
	^ stringX, '@', stringY
]

{ #category : #'*DrGeoII-Core-point functions' }
Point >> reflexionBy: aPoint direction: aDirection [
"the reflected point according to the axe defined by aPoint and aDirection"
	^ ((self - aPoint) vectorReflexionBy: aDirection) + aPoint
]

{ #category : #'*DrGeoII-Core-point functions' }
Point >> rotateVector: anAngle [
|cosa sina|
	cosa := anAngle cos.
	sina := anAngle sin.
	^ (x * cosa - (y * sina))@(x * sina + (y * cosa))
]

{ #category : #'*DrGeoII-Core-point functions' }
Point >> vectorReflexionBy: aDirection [
"the reflected vector according to the axe defined by aPoint and aVector"
|unit normal|
	[unit := aDirection normalized.
	normal := unit normal] 
		on: ZeroDivide 
		do: [ 
			 	unit := 0@0.
				normal := 0@0].
	^((self dotProduct: unit) * unit) - ((self dotProduct: normal) * normal)

]
