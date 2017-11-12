"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDrGeoIIPolymorph,
	#superclass : #PackageManifest,
	#category : #DrGeoII-Polymorph
}

{ #category : #code-critics }
ManifestDrGeoIIPolymorph class >> ruleRBUtilityMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#DrGScriptBrowser #sourceIn: #false)) #'2017-07-02T19:07:57.435417+02:00') #(#(#RGMethodDefinition #(#DrGScriptBrowser #scriptsIn: #false)) #'2017-07-02T19:08:05.636972+02:00') )
]
