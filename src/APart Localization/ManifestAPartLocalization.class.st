"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAPartLocalization,
	#superclass : #PackageManifest,
	#category : #'APart Localization-Manifest'
}

{ #category : #'code-critics' }
ManifestAPartLocalization class >> ruleRefersToClassRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'APartLocale class' #fromIsoString: #true)) #'2020-09-30T15:00:20.927832+02:00') )
]
