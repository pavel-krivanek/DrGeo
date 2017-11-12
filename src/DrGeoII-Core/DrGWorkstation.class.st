"
Preferences for workstation (Linux, Mac, Windows)
"
Class {
	#name : #DrGWorkstation,
	#superclass : #DrGPlateform,
	#category : #DrGeoII-Core-Resources
}

{ #category : #initialize-release }
DrGWorkstation >> checkForPaths [
	super checkForPaths.
	self myExportsPath ensureCreateDirectory
]

{ #category : #path }
DrGWorkstation >> fontPath [
	^  FileSystem disk workingDirectory
]

{ #category : #'user interface' }
DrGWorkstation >> fontSize [
	^ 11
]

{ #category : #initialize-release }
DrGWorkstation >> initialize [
	canWeDisplayLoader := true.
	WorldState desktopMenuTitle: 'Dr. Geo'.
	WorldState desktopMenuPragmaKeyword:  'drgeoMenu'.
	Display newDepth: 32.
	PolymorphSystemSettings uiThemeClass:  UIThemeWatery.
	TaskbarMorph showTaskbar: true.
	SystemWindow fullscreenMargin: 0.
]

{ #category : #testing }
DrGWorkstation >> isWorkstation [
	^ true
]

{ #category : #path }
DrGWorkstation >> myExportsPath [
	^ self rootPath / 'MyExports'
]

{ #category : #'user interface' }
DrGWorkstation >> setFontPreferences [
	StandardFonts codeFont: (LogicalFont familyName: DrGDefault fontName pointSize: 11).
	StandardFonts listFont: (LogicalFont familyName: DrGDefault fontName pointSize: 11).
	StandardFonts menuFont: (LogicalFont familyName: DrGDefault fontName pointSize: 11).
	StandardFonts windowTitleFont: (LogicalFont familyName: DrGDefault fontName pointSize: 11).
	StandardFonts balloonFont: (LogicalFont familyName: DrGDefault fontName pointSize: 11).
	StandardFonts haloFont: (LogicalFont familyName: DrGDefault fontName  pointSize: 11).
	StandardFonts buttonFont: (LogicalFont familyName: DrGDefault fontName  pointSize: 11).
	StandardFonts defaultFont: (LogicalFont familyName: DrGDefault fontName  pointSize: 11).

]

{ #category : #'user interface' }
DrGWorkstation >> smallFontSize [
	^ 9
]

{ #category : #initialize-release }
DrGWorkstation >> startUp [
	super startUp.
	self splash.
	(World submorphs anySatisfy: [:morph | morph class == DrGeoWindow]) ifFalse:
		[DrGeo newFullScreen]
]
