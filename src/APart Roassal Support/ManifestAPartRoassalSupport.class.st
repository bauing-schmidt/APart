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
	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#APRsPartInterface)) #'2021-11-05T15:29:32.612+01:00') #(#(#RGClassDefinition #(#APRsBasicDispatcher)) #'2021-11-11T20:39:00.646+01:00') )
]

{ #category : #'code-critics' }
ManifestAPartRoassalSupport class >> ruleCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#APRsBasicDispatcher)) #'2021-11-11T20:38:55.288+01:00') )
]

{ #category : #'code-critics' }
ManifestAPartRoassalSupport class >> ruleUncommonMessageSendRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#APRsBasicDispatcher #onMouseWheelEvent: #false)) #'2021-11-05T16:58:48.26+01:00') )
]
