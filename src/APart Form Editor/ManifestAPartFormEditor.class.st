"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAPartFormEditor,
	#superclass : #PackageManifest,
	#category : #'APart Form Editor-Manifest'
}

{ #category : #'code-critics' }
ManifestAPartFormEditor class >> ruleBadMessageRule2V1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#ApedPartWithMemento #fillFrom: #false)) #'2020-10-29T11:19:53.283081+01:00') )
]

{ #category : #'code-critics' }
ManifestAPartFormEditor class >> ruleUsesAddRuleV1FalsePositive [
	^ #(#(#(#RGMetaclassDefinition #(#'ApedFormEditor class' #ApedFormEditor)) #'2020-10-29T09:16:19.967504+01:00') )
]
