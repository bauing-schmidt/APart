"
SUTAPOperator ist die abstrakte Basisklasse für Objekte, die innerhalb von UnitTests bestimmte Operationen in einem Part durchführen (z.B. Änderung der Selektion in einem SubPart). Hierbei geht es um alle Arten von Veränderungen, die im Normalbetrieb der Anwendung durch das GUI ausgelöst werden, jedoch weder eine einfache Werteingabe noch eine ausführbare Action darstellen.
Ein Operator entsteht beim Recording aus dem Argument für den Aufruf einer APTriggerAction, indem die zum key des Triggers passende Operator-Subklasse gesucht wird:
	SUTAPOperator createForTriggerAction: aTriggerAction part: aPart

Der vollständig aufgebaute Operator kann seinen Konstruktor als Methodencode ausgeben. Auf Basis dieses Konstruktors wird er vom TestCase mit dem aktuellen Part als Argument aufgerufen, um die aufgezeichnete Trigger-Aktivität beim Ablauf des Tests durchzuführen.

Protokoll für konkrete Subklassen:
Klassenmethoden:
onTrigger: aTrigger part: aPart

Instanzmethoden:
operatoreOnPart: aPart testCase: aTestCase
printConstructorOn: aStream

"
Class {
	#name : #SUTAPOperator,
	#superclass : #Object,
	#instVars : [
		'subPartKey'
	],
	#category : #'APart Tests'
}

{ #category : #API }
SUTAPOperator class >> createForTriggerAction: aTriggerAction part: aPart [

	| triggerKey |
	triggerKey := aTriggerAction key.
	self allSubclasses
		do: [:sc | (sc onTrigger: triggerKey part: aPart) ifNotNil: [:op | ^op]].
	^nil
]

{ #category : #'instance creation' }
SUTAPOperator class >> onTrigger: triggerKey part: aPart [

	self subclassResponsibility
]

{ #category : #API }
SUTAPOperator >> operateOnPart: aPart testCase: aTestCase [

	self subclassResponsibility
]

{ #category : #API }
SUTAPOperator >> printConstructorOn: aStream [

	self subclassResponsibility
]

{ #category : #accessing }
SUTAPOperator >> subPartKey [

	^subPartKey
]

{ #category : #accessing }
SUTAPOperator >> subPartKey: anObject [

	subPartKey := anObject
]
