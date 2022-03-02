"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestVWCompatibility,
	#superclass : #PackageManifest,
	#category : #'APart Basic-Support'
}

{ #category : #'code-critics' }
ManifestVWCompatibility class >> ruleBadMessageRule2V1FalsePositive [
	<ignoreForCoverage>

	^ #(#(#(#RGPackageDefinition #(#'APart Basic')) #'2021-06-28T17:47:19.599+02:00') )
]

{ #category : #'code-critics' }
ManifestVWCompatibility class >> ruleCollectionMessagesToExternalObjectRuleV1FalsePositive [
	<ignoreForCoverage>

	^ #(#(#(#RGPackageDefinition #(#'APart Basic')) #'2021-07-18T11:37:44.251+02:00') )
]

{ #category : #'code-critics' }
ManifestVWCompatibility class >> ruleCollectionProtocolRuleV1FalsePositive [
	<ignoreForCoverage>

	^ #(#(#(#RGMethodDefinition #(#APartClientRegistry #refreshClientClassRegistry #false)) #'2021-07-18T11:55:49.841+02:00') )
]

{ #category : #'code-critics' }
ManifestVWCompatibility class >> ruleMissingSubclassResponsibilityRuleV1FalsePositive [
	<ignoreForCoverage>

	^ #(#(#(#RGClassDefinition #(#APExecutable)) #'2021-02-01T15:15:57.957464+01:00') )
]

{ #category : #'code-critics' }
ManifestVWCompatibility class >> ruleRBUsesAddRuleV1FalsePositive [
	<ignoreForCoverage>

	^ #(#(#(#RGMethodDefinition #(#OrderedCollectionWithDependants #addAll: #false)) #'2020-01-01T11:33:50.000094+01:00') )
]

{ #category : #'code-critics' }
ManifestVWCompatibility class >> ruleUncommonMessageSendRuleV1FalsePositive [
	<ignoreForCoverage>

	^ #(#(#(#RGMethodDefinition #(#APUseCase #conditionForUseCaseAction #false)) #'2021-02-02T09:17:43.911352+01:00') )
]
