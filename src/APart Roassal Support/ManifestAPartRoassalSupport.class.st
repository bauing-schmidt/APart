"
Contains all extensions of APart needed to conveniently dealing with Roassal canvases, shapes and events
"
Class {
	#name : #ManifestAPartRoassalSupport,
	#superclass : #PackageManifest,
	#category : #'APart Roassal Support-Manifest'
}

{ #category : #'code-critics' }
ManifestAPartRoassalSupport class >> ruleCollectionMessagesToExternalObjectRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#APRsPartInterface)) #'2021-11-05T15:29:32.612+01:00') )
]

{ #category : #'code-critics' }
ManifestAPartRoassalSupport class >> ruleUncommonMessageSendRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#APRsBasicDispatcher #onMouseWheelEvent: #false)) #'2021-11-05T16:58:48.26+01:00') )
]
