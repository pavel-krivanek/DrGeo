"
Preferences common to tablets
"
Class {
	#name : #DrGTablet,
	#superclass : #DrGPlateform,
	#instVars : [
		'wheelHeight'
	],
	#category : #DrGeoII-Core-Resources
}

{ #category : #'user interface' }
DrGTablet >> canvasFontSize [
	^ 12
]

{ #category : #initialize-release }
DrGTablet >> reset [
	super reset.
	wheelHeight := nil
]

{ #category : #'user interface' }
DrGTablet >> setFontPreferences [
	StandardFonts codeFont: (LogicalFont familyName: DrGDefault fontName  pointSize: 12).
	StandardFonts listFont: (LogicalFont familyName: DrGDefault fontName  pointSize: 14).
	StandardFonts menuFont: (LogicalFont familyName: DrGDefault fontName pointSize: 14).
	StandardFonts windowTitleFont: (LogicalFont familyName: DrGDefault fontName pointSize: 14).
	StandardFonts balloonFont: (LogicalFont familyName: DrGDefault fontName  pointSize: 12).
	StandardFonts haloFont: (LogicalFont familyName: DrGDefault fontName  pointSize: 12).
	StandardFonts buttonFont: (LogicalFont familyName: DrGDefault fontName  pointSize: 16).
	StandardFonts defaultFont: (LogicalFont familyName: DrGDefault fontName  pointSize: 14).

]

{ #category : #initialize-release }
DrGTablet >> startUp [
	super startUp.
	self splash.
	(World submorphs anySatisfy: [:morph | morph class == DrGeoWindow]) ifFalse:
		[DrGeo newFullScreen]
]

{ #category : #'user interface' }
DrGTablet >> wheelHeight [
	^ wheelHeight ifNil: [ |maxWheelHeight|
		maxWheelHeight := (self screenHeight - (3.4 * self toolbarIconSize) - 32 - self wheelWidth) // 2.
		wheelHeight := 180 min: maxWheelHeight]
]

{ #category : #'user interface' }
DrGTablet >> wheelWidth [
	^ 55
]
