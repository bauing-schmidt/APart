"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAPartBasicParts,
	#superclass : #PackageManifest,
	#category : #'APart BasicParts-Manifest'
}

{ #category : #'code-critics' }
ManifestAPartBasicParts class >> ruleReturnsIfTrueRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#APTPartWithItemSelection #singleSelection #false)) #'2021-08-08T10:02:28.056+02:00') #(#(#RGMethodDefinition #(#APTPartWithItemSelection #multiSelection #false)) #'2021-08-08T10:39:57.394+02:00') )
]
