"
Preferences for OLPC sugar based laptop
"
Class {
	#name : #DrGSugar,
	#superclass : #DrGWorkstation,
	#category : #DrGeoII-Core-Resources
}

{ #category : #initialize-release }
DrGSugar >> initialize [
	canWeDisplayLoader := true.
	WorldState desktopMenuTitle: 'Dr. Geo'.
	WorldState desktopMenuPragmaKeyword:  'drgeoMenu'.
	Display newDepth: 16.
	(Smalltalk at: #UIThemeSugar) resetDefaultSettings.
	PolymorphSystemSettings uiThemeClass:  (Smalltalk at: #UIThemeSugar).
	UITheme currentSettings fastDragging: true.
	UITheme currentSettings fadedBackgroundWindows: false.

	World color: Color white.
	SystemWindow fullscreenMargin: 0.
]

{ #category : #testing }
DrGSugar >> isSugar [
	^ true
]

{ #category : #testing }
DrGSugar >> isWorkstation [
	^ false
]

{ #category : #path }
DrGSugar >> rootPath [
	^   FileLocator imageDirectory
]

{ #category : #'user interface' }
DrGSugar >> setFontPreferences [
	StandardFonts codeFont: (LogicalFont familyName: DrGDefault fontName pointSize: 14).
	StandardFonts listFont: (LogicalFont familyName: DrGDefault fontName  pointSize: 14).
	StandardFonts menuFont: (LogicalFont familyName: DrGDefault fontName  pointSize: 14).
	StandardFonts windowTitleFont: (LogicalFont familyName: DrGDefault fontName pointSize: 14).
	StandardFonts balloonFont: (LogicalFont familyName: DrGDefault fontName pointSize: 12).
	StandardFonts haloFont: (LogicalFont familyName: DrGDefault fontName  pointSize: 12).
	StandardFonts buttonFont: (LogicalFont familyName: DrGDefault fontName  pointSize: 14).
	StandardFonts defaultFont: (LogicalFont familyName: DrGDefault fontName  pointSize: 14).

]
