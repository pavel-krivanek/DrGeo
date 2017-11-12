Class {
	#name : #DrGFlyPointBuildToolState,
	#superclass : #DrGBuildToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGFlyPointBuildToolState >> handleMouseAt: aPoint [ 
	| costumes aTip |
	costumes := self context costumesAt: aPoint.
	costumes size = 1
		ifTrue: [aTip := costumes first mathItem descriptiveName].
	costumes size > 1
		ifTrue: [aTip := 'This intersection' translated].
	aTip
		ifNil: [self area hideTip]
		ifNotNil: [self area tip: aTip at: aPoint].
	^ aTip notNil
]

{ #category : #handling }
DrGFlyPointBuildToolState >> handlePress: aPoint [ 
	"return true if did something"
	| costumes |
	self area hideTip.
	self context last: (self context gridPoint: aPoint).
	costumes := self context costumesAt: aPoint.
	"user clicked in the background or in one or several curve item, handle it immediately"
	self handleChoice: costumes.
	^ true
]
