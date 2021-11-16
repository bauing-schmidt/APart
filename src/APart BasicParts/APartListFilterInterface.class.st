"
APartListFilterInterface ist das für einen APartListFilter spezialisierte PartInterface
"
Class {
	#name : #APartListFilterInterface,
	#superclass : #APListInterface,
	#category : #'APart BasicParts'
}

{ #category : #updating }
APartListFilterInterface >> changedAspectValue: aspectKey suppressListeners: shallSuppressListeners bypassUpdatesHold: bypassUpdatesHold [

	self parentInterface changedAspectValue: aspectKey suppressListeners: shallSuppressListeners bypassUpdatesHold: bypassUpdatesHold
]

{ #category : #'initialize-release' }
APartListFilterInterface >> initializeAspects [
	"Instead of own Aspect adapters, those from the ParentInterface continue to be used. Their subjectChannel is changed so that all adapters point to the data of the filter instead of the original list data"
	"DE:Anstelle eigener Aspect-Adaptoren werden die aus dem ParentInterface weiter verwendet. Deren subjectChannel wird so verändert, dass alle Adaptoren auf die Daten des Filters anstatt auf die Daten der originalen Liste zeigen"

	self parentInterface changeSubject: part
]

{ #category : #updating }
APartListFilterInterface >> noticeRemovedFromParent [

	| pif |
	pif := self parentInterface.
	pif isClosing: true.
	pif changeSubject: pif part
]

{ #category : #private }
APartListFilterInterface >> selfOrSubInterfaceDo: aBlock [

	^aBlock value: self parentInterface
]
