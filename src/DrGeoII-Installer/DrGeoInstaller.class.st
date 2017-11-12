"
I am an abstraction of an installer
"
Class {
	#name : #DrGeoInstaller,
	#superclass : #Object,
	#category : #DrGeoII-Installer
}

{ #category : #setup }
DrGeoInstaller class >> forWorkstation [
	DrGeoInstallerWorksation new install
]

{ #category : #cleaning }
DrGeoInstaller >> cleanMySelf [
	"Remove my self"
	(MCPackage named: 'DrGeoII-Installer') unload.
	(MCPackage named: 'ConfigurationOfGettext') unload.
	(MCPackage named: 'ConfigurationOfXMLSupport') unload.
]

{ #category : #cleaning }
DrGeoInstaller >> cleanUpForRelease [
"Remove all unecessary packages and do cleaning to save dynamic memory space"


	ImageCleaner drgeoCleanUpForProduction.
	self removePackages.
	self deeperCleaning.
	Smalltalk fixObsoleteReferences.

	Smalltalk garbageCollect.
	Smalltalk garbageCollect.
	Smalltalk garbageCollect.

]

{ #category : #cleaning }
DrGeoInstaller >> deeperCleaning [
	"Some more cleaning not done in ImageCleaner"
	FreeTypeFontProvider unload.
	StrikeFont cleanUp.

]

{ #category : #setup }
DrGeoInstaller >> install [
	PharoFilesOpener default unsetInformAboutReadOnlyChanges.
	TextDomainManager registerCategoryPrefix: 'DrGeoII' domain: 'DrGeoII'.
	TextDomainManager registerCategoryPrefix: 'pharo' domain: 'pharo'.	
	Locale activated: true.
]

{ #category : #cleaning }
DrGeoInstaller >> removePackages [
"Package not removed from ImageCleaner we want to remove"
	(MCPackage named: 'HelpSystem-Core') unload.
	(MCPackage named: 'ProfStef-Core') unload.	
	(MCPackage named: 'ReleaseTests') unload.
	(MCPackage named: 'Versionner-Tests-Core-Commands') unload.
	(MCPackage named: 'Versionner-Tests-Core-DependenciesModel') unload.
	(MCPackage named: 'Versionner-Tests-Core-Model') unload.
	(MCPackage named: 'Versionner-Tests-Resources') unload.
	(MCPackage named: 'Polymorph-Tools-Diff') unload.
	"Metacello"
	(MCPackage named: 'Metacello-FileTree') unload.
	(MCPackage named: 'Metacello-GitHub') unload.
	(MCPackage named: 'Metacello-PharoCommonPlatform') unload.
	(MCPackage named: 'Metacello-Platform.pharo30') unload.
	(MCPackage named: 'Metacello-Reference') unload.
	"SUnit"	
	(MCPackage named: 'SUnit-UITesting') unload.
	(MCPackage named: 'SUnit-Utilities') unload.
	(MCPackage named: 'SUnit-UI') unload.
	(MCPackage named: 'SUnit-Core') unload.	
	"KeyChain"	
	(MCPackage named: 'KeyChain') unload.
	"Network"
	(MCPackage named: 'Network-Mail') unload.
	(MCPackage named: 'Network-RFC822') unload.
	(MCPackage named: 'Zodiac-Extra') unload.
	(MCPackage named: 'Zinc-Zodiac') unload.
	(MCPackage named: 'Zinc-FileSystem') unload.
	(MCPackage named: 'Zinc-Ressource-Meta-FileSystem') unload.
	(MCPackage named: 'Zinc-System-Support') unload.
	"Settings"
	(MCPackage named: 'Settings-Compiler') unload.
	(MCPackage named: 'Settings-Display') unload.
	(MCPackage named: 'Settings-FreeType') unload.
	(MCPackage named: 'Settings-Graphics') unload.
	(MCPackage named: 'Settings-Kernel') unload.
	(MCPackage named: 'Settings-Monticello') unload.
	(MCPackage named: 'Settings-Polymorph') unload.
	(MCPackage named: 'Settings-System') unload.
	(MCPackage named: 'Settings-Tools') unload.
	
	(MCPackage named: 'Komitter') unload.


]
