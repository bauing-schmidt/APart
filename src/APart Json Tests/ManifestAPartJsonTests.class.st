"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAPartJsonTests,
	#superclass : #PackageManifest,
	#category : #'APart Json Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestAPartJsonTests class >> ruleRBYourselfNotUsedRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'APart Json Tests')) #'2019-09-11T11:18:40.422488+02:00') )
]
