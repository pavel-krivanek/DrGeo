Extension { #name : #Locale }

{ #category : #'*DrGeoII-Core' }
Locale >> determineLocaleID [
	"Locale current determineLocaleID"
	| langCode isoLang countryCode isoCountry |
	langCode := self fetchISO2Language.
	isoLang := langCode
		ifNil: [^self localeID]
		ifNotNil: [langCode].
	countryCode := self primCountry copyFrom: 1 to: 2.
	isoCountry := countryCode
		ifNil: [^LocaleID isoLanguage: isoLang]
		ifNotNil: [countryCode].
	^LocaleID isoLanguage: isoLang isoCountry: isoCountry
]
