Class {
	#name : #BaselineOfDrGeo,
	#superclass : #BaselineOf,
	#category : #BaselineOfDrGeo
}

{ #category : #baselines }
BaselineOfDrGeo >> baseline: spec [
	<baseline>

	spec for: #common do: [
		spec project: 'XML Parser' with: [
			spec className: 'ConfigurationOfXMLParser';
			file: 'ConfigurationOfXMLParser';
			repository: 'http://smalltalkhub.com/mc/Pharo//MetaRepoForPharo60'].
		spec 
			package: 'DrGeoII-Core';
			package: 'DrGeoII-Polymorph';
			package: 'DrGeoII-Installer';
			package: 'DrGeoII-User';
			package: 'DrGeo-French';
			package: 'DrGeoII-Test'.
	].		
]
